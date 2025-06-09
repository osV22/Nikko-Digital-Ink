import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'drawing_settings.freezed.dart';

@freezed
class DrawingSettings with _$DrawingSettings {
  const factory DrawingSettings({
    @Default(4.0) double strokeWidth,
    @Default(Color(0xFF000000)) Color strokeColor,
  }) = _DrawingSettings;

  static const List<double> availableStrokeWidths = [4.0, 6.0, 8.0, 10.0];

  static const List<Color> availableColors = [
    Color(0xFF000000), // Black (default)
    Color(0xFF1976D2), // Blue
    Color(0xFF388E3C), // Green
    Color(0xFFFF1493), // Neon pink (DeepPink)
  ];
}
