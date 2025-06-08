part of 'drawing_bloc.dart';

@freezed
class DrawingState with _$DrawingState {
  const factory DrawingState({
    @Default([]) List<Stroke> strokes,
    @Default('') String recognizedText,
    @Default(false) bool isRecognizing,
    @Default(false) bool shouldClearCanvas,
    String? errorMessage,
  }) = _DrawingState;
}
