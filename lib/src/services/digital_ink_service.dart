import 'package:google_mlkit_digital_ink_recognition/google_mlkit_digital_ink_recognition.dart';

/// Service for handling ML Kit Digital Ink Recognition
/// Manages model downloads, initialization, and text recognition
class DigitalInkService {
  static const String _defaultLanguageCode = 'ja';

  DigitalInkRecognizer? _recognizer;
  DigitalInkRecognizerModelManager? _modelManager;
  String _currentLanguageCode = _defaultLanguageCode;

  Future<void> initialize({String languageCode = _defaultLanguageCode}) async {
    _currentLanguageCode = languageCode;
    _modelManager ??= DigitalInkRecognizerModelManager();

    // Initialize recognizer only after ensuring model is ready
    await _ensureModelReady();
    _recognizer = DigitalInkRecognizer(languageCode: _currentLanguageCode);
  }

  /// Check if the model for the current language is downloaded
  Future<bool> isModelDownloaded() async {
    _modelManager ??= DigitalInkRecognizerModelManager();

    return await _modelManager!.isModelDownloaded(_currentLanguageCode);
  }

  /// Download the model for the current language
  Future<bool> downloadModel() async {
    _modelManager ??= DigitalInkRecognizerModelManager();

    return await _modelManager!.downloadModel(_currentLanguageCode);
  }

  /// Ensure the model is ready (downloaded and available)
  Future<void> _ensureModelReady() async {
    final bool isDownloaded = await isModelDownloaded();

    if (!isDownloaded) {
      final bool downloadSuccess = await downloadModel();
      if (!downloadSuccess) {
        throw Exception('Failed to download language model');
      }
    }
  }

  /// Recognize text from ink strokes
  Future<List<RecognitionCandidate>> recognizeInk(Ink ink) async {
    if (_recognizer == null) {
      throw StateError('Recognizer not initialized. Call initialize() first.');
    }

    try {
      return await _recognizer!.recognize(ink);
    } catch (e) {
      throw Exception('Recognition failed: $e');
    }
  }

  /// Recognize text and return the best candidate as a string
  Future<String?> recognizeText(Ink ink) async {
    final candidates = await recognizeInk(ink);

    if (candidates.isNotEmpty) {
      return candidates.first.text;
    }

    return null;
  }

  String get currentLanguageCode => _currentLanguageCode;

  /// requires reinitialization
  Future<void> changeLanguage(String languageCode) async {
    if (languageCode == _currentLanguageCode) return;

    await dispose();

    // Reinitialize with new language
    await initialize(languageCode: languageCode);
  }

  Future<void> dispose() async {
    await _recognizer?.close();
    _recognizer = null;
    _modelManager = null;
  }
}
