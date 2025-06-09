// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Nikko Digital Ink';

  @override
  String get appSubtitle => 'Japanese Character Recognition';

  @override
  String get checkingModelStatus => 'Checking model status...';

  @override
  String get downloadingModel => 'Downloading AI Model, please wait...';

  @override
  String get modelReady => 'Model ready! You can now proceed.';

  @override
  String get downloadFailed => 'Failed to download model. Please try again.';

  @override
  String get getStarted => 'Get Started';

  @override
  String get pleaseWait => 'Please Wait...';

  @override
  String get recognizedText => 'Recognized Text';

  @override
  String get drawCharactersHint =>
      'Draw Japanese characters below to see recognition results...';

  @override
  String get process => 'Process';

  @override
  String get clear => 'Clear';

  @override
  String get processing => 'Processing...';

  @override
  String strokes(int count) {
    return 'Strokes: $count';
  }

  @override
  String get drawJapaneseCharacters => 'Draw Japanese Characters';

  @override
  String get useFingerOrStylus => 'Use your finger or stylus to write';

  @override
  String get language => 'Language';
}
