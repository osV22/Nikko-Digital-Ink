part of 'drawing_bloc.dart';

@freezed
class DrawingEvent with _$DrawingEvent {
  const factory DrawingEvent.strokeAdded(Stroke stroke) = DrawingStrokeAdded;
  const factory DrawingEvent.clearRequested() = DrawingClearRequested;
  const factory DrawingEvent.canvasClearRequested() =
      DrawingCanvasClearRequested;
}
