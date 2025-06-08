import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signature/signature.dart';
import 'package:google_mlkit_digital_ink_recognition/google_mlkit_digital_ink_recognition.dart'
    hide Ink;
import '../blocs/drawing_bloc.dart';

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
      penColor: Colors.black,
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
    return BlocListener<DrawingBloc, DrawingState>(
      listenWhen: (previous, current) => current.shouldClearCanvas,
      listener: (context, state) {
        _controller.clear();
        context.read<DrawingBloc>().add(
          const DrawingEvent.canvasClearRequested(),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Signature(
          controller: _controller,
          height: double.infinity,
          width: double.infinity,
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
