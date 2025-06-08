import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mlkit_digital_ink_recognition/google_mlkit_digital_ink_recognition.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'drawing_bloc.freezed.dart';
part 'drawing_event.dart';
part 'drawing_state.dart';

class DrawingBloc extends Bloc<DrawingEvent, DrawingState> {
  final DigitalInkRecognizer _recognizer;

  DrawingBloc()
    : _recognizer = DigitalInkRecognizer(languageCode: 'ja'),
      super(const DrawingState()) {
    on<DrawingStrokeAdded>(_onStrokeAdded);
    on<DrawingClearRequested>(_onClearRequested);
    on<DrawingCanvasClearRequested>(_onCanvasClearRequested);
  }

  Future<void> _onStrokeAdded(
    DrawingStrokeAdded event,
    Emitter<DrawingState> emit,
  ) async {
    // Add stroke to list
    final updatedStrokes = [...state.strokes, event.stroke];
    emit(
      state.copyWith(
        strokes: updatedStrokes,
        isRecognizing: true,
      ),
    );

    // Perform recognition
    try {
      final ink = Ink();
      ink.strokes = updatedStrokes;
      final candidates = await _recognizer.recognize(ink);

      if (candidates.isNotEmpty) {
        final recognizedText = candidates.first.text;
        emit(
          state.copyWith(
            recognizedText: state.recognizedText + recognizedText,
            isRecognizing: false,
          ),
        );
      } else {
        emit(state.copyWith(isRecognizing: false));
      }
    } catch (e) {
      emit(
        state.copyWith(
          isRecognizing: false,
          errorMessage: 'Recognition error: $e',
        ),
      );
    }
  }

  void _onClearRequested(
    DrawingClearRequested event,
    Emitter<DrawingState> emit,
  ) {
    emit(
      state.copyWith(
        strokes: [],
        recognizedText: '',
        errorMessage: null,
        shouldClearCanvas: true,
      ),
    );
  }

  void _onCanvasClearRequested(
    DrawingCanvasClearRequested event,
    Emitter<DrawingState> emit,
  ) {
    emit(state.copyWith(shouldClearCanvas: false));
  }

  @override
  Future<void> close() {
    _recognizer.close();
    return super.close();
  }
}
