import 'package:flutter/material.dart';

/// Custom painter for creating a subtle dotted grid background
class DottedGridPainter extends CustomPainter {
  final Color dotColor;
  final double dotSize;
  final double spacing;

  DottedGridPainter({
    required this.dotColor,
    this.dotSize = 1.5,
    this.spacing = 20.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = dotColor
      ..style = PaintingStyle.fill;

    // Calculate the number of dots that fit in the canvas
    final horizontalDots = (size.width / spacing).floor();
    final verticalDots = (size.height / spacing).floor();

    // Calculate offsets to center the grid
    final horizontalOffset = (size.width - (horizontalDots - 1) * spacing) / 2;
    final verticalOffset = (size.height - (verticalDots - 1) * spacing) / 2;

    // Draw the dots
    for (int i = 0; i < horizontalDots; i++) {
      for (int j = 0; j < verticalDots; j++) {
        final x = horizontalOffset + i * spacing;
        final y = verticalOffset + j * spacing;
        canvas.drawCircle(Offset(x, y), dotSize, paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
