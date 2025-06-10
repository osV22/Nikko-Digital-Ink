import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hand_signature/signature.dart';

part 'drawing_settings.freezed.dart';

@freezed
class DrawingSettings with _$DrawingSettings {
  const factory DrawingSettings({
    @Default(4.0) double strokeWidth,
    @Default(8.0) double maxStrokeWidth,
    @Default(Color(0xFF000000)) Color strokeColor,
    @Default(SignatureDrawType.shape) SignatureDrawType drawType,
    @Default(3.0) double threshold,
    @Default(0.65) double smoothRatio,
    @Default(2.0) double velocityRange,
  }) = _DrawingSettings;

  static const List<double> availableStrokeWidths = [
    1.5, // Very thin - precise details
    4.0, // Medium - good balance
    8.0, // Thick - bold strokes
    16.0, // Very thick - maximum impact
  ];

  static const List<double> availableMaxStrokeWidths = [6.0, 8.0, 12.0, 16.0];

  static const List<Color> availableColors = [
    Color(0xFF000000), // Black (default)
    Color(0xFF1976D2),
    Color(0xFF00FF32),
    Color(0xFFFF1493),
  ];

  static const List<SignatureDrawType> availableDrawTypes = [
    SignatureDrawType.line, // Basic performance
    SignatureDrawType.shape, // Good balance (default)
    SignatureDrawType.arc, // Best quality
  ];
}
