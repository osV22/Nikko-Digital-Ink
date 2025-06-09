/// Configuration helper for Japanese character recognition optimization
class JapaneseRecognitionConfig {
  // Stroke quality settings
  static const double preferredStrokeWidth = 4.0;
  static const double minimumStrokeLength = 5.0;

  // Timing settings for better recognition
  static const double characterSpacingMs = 100.0; // 100ms between characters
  static const double strokePointIntervalMs = 10.0; // 10ms between points

  // Recognition settings
  static const int maxCandidates = 3;
  static const String languageCode = 'ja'; // Japanese language code

  // Canvas settings for optimal character size
  static const double minCanvasSize = 200.0;
  static const double preferredCanvasSize = 300.0;

  // Visual feedback settings
  static const int recognitionDelayMs = 800; // Wait 800ms after last stroke

  /// Get recommended canvas dimensions based on screen size
  static double getOptimalCanvasSize(double screenWidth, double screenHeight) {
    final minDimension = screenWidth < screenHeight
        ? screenWidth
        : screenHeight;

    // Use 70% of the smaller dimension, but ensure minimum size
    return (minDimension * 0.7).clamp(minCanvasSize, double.infinity);
  }

  /// Check if strokes are suitable for recognition
  static bool shouldAttemptRecognition(int strokeCount) {
    // Japanese characters typically require at least 1-3 strokes minimum
    return strokeCount >= 1 && strokeCount <= 30; // Reasonable upper limit
  }

  /// Get writing area dimensions for ML Kit context
  static Map<String, double> getWritingAreaDimensions(
    double canvasWidth,
    double canvasHeight,
  ) {
    // For Japanese, assume single line writing
    // Height should be estimated for one character line
    final characterHeight = canvasHeight * 0.8; // Use 80% of canvas height

    return {
      'width': canvasWidth,
      'height': characterHeight,
    };
  }
}
