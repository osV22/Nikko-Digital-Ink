import 'package:google_mlkit_digital_ink_recognition/google_mlkit_digital_ink_recognition.dart';
import 'dart:math' as math;

/// Utility class for optimizing ink strokes for better Japanese character recognition
class InkOptimizer {
  /// Optimize strokes for better recognition accuracy
  /// This includes smoothing, minimum point requirements, and proper timing
  static Ink optimizeForJapanese(List<Stroke> originalStrokes) {
    final optimizedStrokes = <Stroke>[];

    for (final stroke in originalStrokes) {
      final optimizedStroke = _optimizeStroke(stroke);
      if (optimizedStroke != null) {
        optimizedStrokes.add(optimizedStroke);
      }
    }

    final ink = Ink();
    ink.strokes = optimizedStrokes;
    return ink;
  }

  /// Optimize individual stroke for better recognition
  static Stroke? _optimizeStroke(Stroke originalStroke) {
    if (originalStroke.points.isEmpty) return null;

    // Ensure minimum points for a meaningful stroke
    if (originalStroke.points.length < 2) {
      // For single point strokes (dots), duplicate the point slightly offset
      final point = originalStroke.points.first;
      final stroke = Stroke();
      stroke.points = [
        point,
        StrokePoint(
          x: point.x + 0.5, // Very small offset
          y: point.y + 0.5,
          t: point.t + 1,
        ),
      ];
      return stroke;
    }

    // Apply smoothing for better recognition
    final smoothedPoints = _smoothPoints(originalStroke.points);

    // Ensure proper timing sequence
    final timedPoints = _ensureProperTiming(smoothedPoints);

    final stroke = Stroke();
    stroke.points = timedPoints;
    return stroke;
  }

  /// Smooth stroke points to reduce noise
  static List<StrokePoint> _smoothPoints(List<StrokePoint> points) {
    if (points.length <= 2) return points;

    final smoothed = <StrokePoint>[points.first];

    // Simple moving average smoothing
    for (int i = 1; i < points.length - 1; i++) {
      final prev = points[i - 1];
      final current = points[i];
      final next = points[i + 1];

      // Average position with neighbors for smoothing
      final smoothedX = (prev.x + current.x + next.x) / 3;
      final smoothedY = (prev.y + current.y + next.y) / 3;

      smoothed.add(
        StrokePoint(
          x: smoothedX,
          y: smoothedY,
          t: current.t,
        ),
      );
    }

    smoothed.add(points.last);
    return smoothed;
  }

  /// Ensure proper timing progression
  static List<StrokePoint> _ensureProperTiming(List<StrokePoint> points) {
    if (points.length <= 1) return points;

    final timed = <StrokePoint>[];
    int baseTime = points.first.t;

    for (int i = 0; i < points.length; i++) {
      final point = points[i];

      // Ensure monotonic time progression
      final properTime = math.max(baseTime + i * 10, point.t);

      timed.add(
        StrokePoint(
          x: point.x,
          y: point.y,
          t: properTime,
        ),
      );

      baseTime = properTime;
    }

    return timed;
  }

  /// Remove strokes that are too short or likely noise
  static List<Stroke> removeNoiseStrokes(List<Stroke> strokes) {
    return strokes.where((stroke) {
      if (stroke.points.length < 2) return false;

      // Calculate stroke length
      double totalLength = 0;
      for (int i = 1; i < stroke.points.length; i++) {
        final p1 = stroke.points[i - 1];
        final p2 = stroke.points[i];
        totalLength += math.sqrt(
          math.pow(p2.x - p1.x, 2) + math.pow(p2.y - p1.y, 2),
        );
      }

      // Minimum stroke length threshold (adjust based on testing)
      return totalLength > 5.0;
    }).toList();
  }

  /// Add spacing between characters for better recognition
  /// This helps ML Kit understand character boundaries
  static Ink addCharacterSpacing(Ink originalInk, double spacingMs) {
    if (originalInk.strokes.isEmpty) return originalInk;

    final adjustedStrokes = <Stroke>[];

    // Add time gaps between distinct character strokes
    for (int i = 0; i < originalInk.strokes.length; i++) {
      final currentStroke = originalInk.strokes[i];

      if (i == 0) {
        // First stroke remains unchanged
        adjustedStrokes.add(currentStroke);
      } else {
        final prevStroke = adjustedStrokes[i - 1];

        if (prevStroke.points.isNotEmpty && currentStroke.points.isNotEmpty) {
          final lastTime = prevStroke.points.last.t;
          final firstTime = currentStroke.points.first.t;

          // If strokes are very close in time, add spacing
          if (firstTime - lastTime < spacingMs) {
            final timeOffset = (lastTime + spacingMs - firstTime).round();

            // Create new points with adjusted timing
            final adjustedPoints = currentStroke.points.map((point) {
              return StrokePoint(
                x: point.x,
                y: point.y,
                t: point.t + timeOffset,
              );
            }).toList();

            final adjustedStroke = Stroke();
            adjustedStroke.points = adjustedPoints;
            adjustedStrokes.add(adjustedStroke);
          } else {
            adjustedStrokes.add(currentStroke);
          }
        } else {
          adjustedStrokes.add(currentStroke);
        }
      }
    }

    final ink = Ink();
    ink.strokes = adjustedStrokes;
    return ink;
  }
}
