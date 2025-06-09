import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signature/signature.dart';
import 'package:google_mlkit_digital_ink_recognition/google_mlkit_digital_ink_recognition.dart'
    hide Ink;
import '../blocs/drawing_bloc.dart';
import '../../l10n/app_localizations.dart';

class DrawingCanvasWidget extends StatefulWidget {
  const DrawingCanvasWidget({super.key});

  @override
  State<DrawingCanvasWidget> createState() => _DrawingCanvasWidgetState();
}

class _DrawingCanvasWidgetState extends State<DrawingCanvasWidget> {
  late final SignatureController _controller;

  @override
  void initState() {
    super.initState();
    _controller = SignatureController(
      penStrokeWidth: 3,
      penColor: const Color(0xFF435053),
      exportBackgroundColor: Colors.white,
    );
    _controller.onDrawEnd = _onStrokeEnd;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Convert Signature points to ML Kit Stroke
  Stroke _convertToMLKitStroke(List<Point> points) {
    final strokePoints = <StrokePoint>[];

    for (final point in points) {
      strokePoints.add(
        StrokePoint(
          x: point.offset.dx,
          y: point.offset.dy,
          t: DateTime.now().millisecondsSinceEpoch,
        ),
      );
    }

    final stroke = Stroke();
    stroke.points = strokePoints;
    return stroke;
  }

  void _onStrokeEnd() {
    final points = _controller.points;
    if (points.isNotEmpty) {
      final stroke = _convertToMLKitStroke(points);
      context.read<DrawingBloc>().add(DrawingEvent.strokeAdded(stroke));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    return BlocListener<DrawingBloc, DrawingState>(
      listenWhen: (previous, current) => current.shouldClearCanvas,
      listener: (context, state) {
        _controller.clear();
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
            borderRadius: BorderRadius.circular(
              11,
            ), // Slightly smaller to account for border
            child: Stack(
              children: [
                // Background pattern (optional subtle grid)
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.white,
                ),
                // Drawing area
                Signature(
                  controller: _controller,
                  height: double.infinity,
                  width: double.infinity,
                  backgroundColor: Colors.transparent,
                ),
                // Hint overlay when no strokes
                BlocBuilder<DrawingBloc, DrawingState>(
                  builder: (context, state) {
                    if (state.strokes.isEmpty && !state.isRecognizing) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.draw,
                              size: 48,
                              color: theme.colorScheme.onSurface.withValues(
                                alpha: 0.3,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              l10n?.drawJapaneseCharacters ??
                                  'Draw Japanese Characters',
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: theme.colorScheme.onSurface.withValues(
                                  alpha: 0.5,
                                ),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              l10n?.useFingerOrStylus ??
                                  'Use your finger or stylus to write',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurface.withValues(
                                  alpha: 0.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
