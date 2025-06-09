import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mlkit_digital_ink_recognition/google_mlkit_digital_ink_recognition.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../services/digital_ink_service.dart';
import '../utils/ink_optimizer.dart';

part 'drawing_bloc.freezed.dart';
part 'drawing_event.dart';
part 'drawing_state.dart';

class DrawingBloc extends Bloc<DrawingEvent, DrawingState> {
  final DigitalInkService _digitalInkService;

  DrawingBloc({DigitalInkService? digitalInkService})
    : _digitalInkService = digitalInkService ?? DigitalInkService(),
      super(const DrawingState()) {
    on<DrawingStrokeAdded>(_onStrokeAdded);
    on<DrawingProcessRequested>(_onProcessRequested);
    on<DrawingClearRequested>(_onClearRequested);
    on<DrawingCanvasClearRequested>(_onCanvasClearRequested);
  }

  void _onStrokeAdded(
    DrawingStrokeAdded event,
    Emitter<DrawingState> emit,
  ) {
    // Just add stroke to list, don't process yet
    final updatedStrokes = [...state.strokes, event.stroke];
    emit(state.copyWith(strokes: updatedStrokes));
  }

  Future<void> _onProcessRequested(
    DrawingProcessRequested event,
    Emitter<DrawingState> emit,
  ) async {
    if (state.strokes.isEmpty) return;

    emit(state.copyWith(isRecognizing: true));

    try {
      // Remove noise strokes before processing
      final cleanStrokes = InkOptimizer.removeNoiseStrokes(state.strokes);
      if (cleanStrokes.isEmpty) {
        emit(state.copyWith(isRecognizing: false));
        return;
      }

      // Optimize ink for Japanese character recognition
      var optimizedInk = InkOptimizer.optimizeForJapanese(cleanStrokes);

      // Add character spacing for better recognition
      optimizedInk = InkOptimizer.addCharacterSpacing(
        optimizedInk,
        100.0,
      ); // 100ms spacing

      // For Japanese, get multiple candidates for better accuracy
      final candidates = await _digitalInkService.getRecognitionCandidates(
        optimizedInk,
        maxCandidates: 3,
      );

      if (candidates.isNotEmpty) {
        // Use the best candidate but could show alternatives to user
        final recognizedText = candidates.first;
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
  Future<void> close() async {
    await _digitalInkService.dispose();
    return super.close();
  }
}
