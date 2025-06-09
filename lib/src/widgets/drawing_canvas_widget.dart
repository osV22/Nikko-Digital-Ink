import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_signature/signature.dart';
import 'package:google_mlkit_digital_ink_recognition/google_mlkit_digital_ink_recognition.dart'
    hide Ink;
import '../blocs/drawing_bloc.dart';
import '../../l10n/app_localizations.dart';
import '../utils/dotted_grid_painter.dart';
import '../models/drawing_settings.dart';

class DrawingCanvasWidget extends StatefulWidget {
  final DrawingSettings settings;

  const DrawingCanvasWidget({
    super.key,
    required this.settings,
  });

  @override
  State<DrawingCanvasWidget> createState() => _DrawingCanvasWidgetState();
}

class _DrawingCanvasWidgetState extends State<DrawingCanvasWidget> {
  late HandSignatureControl _handSignatureControl;
  Timer? _strokeEndTimer;
  int _lastStrokeCount = 0;

  @override
  void initState() {
    super.initState();
    _initializeControl();
  }

  @override
  void didUpdateWidget(DrawingCanvasWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.settings != widget.settings) {
      _updateControl();
    }
  }

  void _initializeControl() {
    _handSignatureControl = HandSignatureControl(
      threshold: widget.settings.threshold,
      smoothRatio: widget.settings.smoothRatio,
      velocityRange: widget.settings.velocityRange,
    );

    // Listen to changes in the signature control
    _handSignatureControl.addListener(_onSignatureChanged);
  }

  void _updateControl() {
    final currentData = _handSignatureControl.toMap();

    // Remove listener from old control
    _handSignatureControl.removeListener(_onSignatureChanged);
    _handSignatureControl.clear();

    // Create new control with updated settings
    _handSignatureControl = HandSignatureControl(
      threshold: widget.settings.threshold,
      smoothRatio: widget.settings.smoothRatio,
      velocityRange: widget.settings.velocityRange,
    );

    _handSignatureControl.addListener(_onSignatureChanged);

    if (currentData.isNotEmpty) {
      _handSignatureControl.importData(currentData);
      _lastStrokeCount = _handSignatureControl.paths.length;
    }
  }

  @override
  void dispose() {
    _strokeEndTimer?.cancel();
    _handSignatureControl.removeListener(_onSignatureChanged);
    _handSignatureControl.clear();
    super.dispose();
  }

  void _onSignatureChanged() {
    // Check if new stroke was completed by monitoring path count
    final currentStrokeCount = _handSignatureControl.paths.length;

    if (currentStrokeCount > _lastStrokeCount) {
      // New stroke completed
      _lastStrokeCount = currentStrokeCount;
      _onStrokeEnd();
    } else if (_handSignatureControl.hasActivePath) {
      // User is currently drawing, restart the timer
      _strokeEndTimer?.cancel();
      _strokeEndTimer = Timer(const Duration(milliseconds: 300), () {
        // Check if stroke ended (no more active path)
        if (!_handSignatureControl.hasActivePath) {
          _onStrokeEnd();
        }
      });
    }
  }

  // Convert hand_signature data to ML Kit Stroke by sampling actual path points
  List<Stroke> _convertToMLKitStrokes() {
    final strokes = <Stroke>[];

    try {
      // Group lines by paths to create separate strokes
      final paths = _handSignatureControl.paths;

      for (int pathIndex = 0; pathIndex < paths.length; pathIndex++) {
        final path = paths[pathIndex];
        final strokePoints = <StrokePoint>[];
        final baseTime =
            DateTime.now().millisecondsSinceEpoch -
            (paths.length - pathIndex) * 1000;

        // Sample points along each line in the path
        for (int lineIndex = 0; lineIndex < path.lines.length; lineIndex++) {
          final line = path.lines[lineIndex];

          // Sample points along the cubic bezier curve
          final sampledPoints = _sampleCubicBezier(
            line.start,
            line.cpStart,
            line.cpEnd,
            line.end,
            samples: 8, // Sample 8 points per line segment
          );

          for (int i = 0; i < sampledPoints.length; i++) {
            final point = sampledPoints[i];
            strokePoints.add(
              StrokePoint(
                x: point.dx,
                y: point.dy,
                t:
                    baseTime +
                    (lineIndex * 80) +
                    (i * 10), // 10ms between sampled points
              ),
            );
          }
        }

        if (strokePoints.isNotEmpty) {
          final stroke = Stroke();
          stroke.points = strokePoints;
          strokes.add(stroke);
        }
      }
    } catch (e) {
      // Fallback: create a simple stroke if there's any drawing
      if (_handSignatureControl.isFilled) {
        final stroke = Stroke();
        stroke.points = [
          StrokePoint(
            x: 50.0,
            y: 50.0,
            t: DateTime.now().millisecondsSinceEpoch,
          ),
          StrokePoint(
            x: 60.0,
            y: 60.0,
            t: DateTime.now().millisecondsSinceEpoch + 100,
          ),
        ];
        strokes.add(stroke);
      }
    }

    return strokes;
  }

  // Sample points along a cubic Bezier curve to simulate actual touch points
  List<Offset> _sampleCubicBezier(
    Offset p0,
    Offset p1,
    Offset p2,
    Offset p3, {
    int samples = 8,
  }) {
    final points = <Offset>[];

    for (int i = 0; i < samples; i++) {
      final t = i / (samples - 1);

      // Cubic Bezier formula: B(t) = (1-t)³P₀ + 3(1-t)²tP₁ + 3(1-t)t²P₂ + t³P₃
      final x =
          (1 - t) * (1 - t) * (1 - t) * p0.dx +
          3 * (1 - t) * (1 - t) * t * p1.dx +
          3 * (1 - t) * t * t * p2.dx +
          t * t * t * p3.dx;

      final y =
          (1 - t) * (1 - t) * (1 - t) * p0.dy +
          3 * (1 - t) * (1 - t) * t * p1.dy +
          3 * (1 - t) * t * t * p2.dy +
          t * t * t * p3.dy;

      points.add(Offset(x, y));
    }

    return points;
  }

  void _onStrokeEnd() {
    // Convert all strokes and send to bloc
    final mlKitStrokes = _convertToMLKitStrokes();
    if (mlKitStrokes.isNotEmpty) {
      // Send the latest stroke (last one added)
      final latestStroke = mlKitStrokes.last;
      context.read<DrawingBloc>().add(DrawingEvent.strokeAdded(latestStroke));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    return BlocListener<DrawingBloc, DrawingState>(
      listenWhen: (previous, current) => current.shouldClearCanvas,
      listener: (context, state) {
        _handSignatureControl.clear();
        context.read<DrawingBloc>().add(
          const DrawingEvent.canvasClearRequested(),
        );
      },
      child: Card(
        elevation: 2,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: theme.colorScheme.outline.withValues(alpha: 0.2),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.shadow.withValues(alpha: 0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(11),
            child: Stack(
              children: [
                // Background with subtle dotted grid
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.white,
                  child: CustomPaint(
                    painter: DottedGridPainter(
                      dotColor: theme.colorScheme.outline.withValues(
                        alpha: 0.15,
                      ),
                      dotSize: 1.2,
                      spacing: 24.0,
                    ),
                    size: Size.infinite,
                  ),
                ),
                // Hint overlay when no strokes (behind the drawing area)
                BlocBuilder<DrawingBloc, DrawingState>(
                  builder: (context, state) {
                    if (state.strokes.isEmpty && !state.isRecognizing) {
                      return IgnorePointer(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.brush,
                                size: 48,
                                color: Colors.blueGrey[50],
                              ),
                              const SizedBox(height: 12),
                              Text(
                                l10n?.drawJapaneseCharacters ??
                                    'Draw Japanese Characters',
                                style: theme.textTheme.titleMedium?.copyWith(
                                  color: Colors.blueGrey[50],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                l10n?.useFingerOrStylus ??
                                    'Use your finger or stylus to write',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: Colors.blueGrey[50],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
                // Hand Signature drawing area (on top to receive touch events)
                Positioned.fill(
                  child: HandSignature(
                    control: _handSignatureControl,
                    color: widget.settings.strokeColor,
                    width: widget.settings.strokeWidth,
                    maxWidth: widget.settings.maxStrokeWidth,
                    type: widget.settings.drawType,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
