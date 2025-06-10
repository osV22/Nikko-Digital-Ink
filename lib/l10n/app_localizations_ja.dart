// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'ニッコーインク';

  @override
  String get appSubtitle => '日本語文字認識';

  @override
  String get checkingModelStatus => 'モデルの状態を確認しています...';

  @override
  String get downloadingModel => 'AIモデルをダウンロードしています。お待ちください...';

  @override
  String get modelReady => 'モデルの準備ができました！続行できます。';

  @override
  String get downloadFailed => 'モデルのダウンロードに失敗しました。もう一度お試しください。';

  @override
  String get getStarted => '開始';

  @override
  String get pleaseWait => 'お待ちください...';

  @override
  String get recognizedText => '認識されたテキスト';

  @override
  String get drawCharactersHint => '下に日本語の文字を描いて認識結果を確認してください...';

  @override
  String get process => '処理';

  @override
  String get clear => 'クリア';

  @override
  String get processing => '処理中...';

  @override
  String strokes(int count) {
    return 'ストローク: $count';
  }

  @override
  String get drawJapaneseCharacters => '日本語の文字を描く';

  @override
  String get useFingerOrStylus => '指またはスタイラスを使って書いてください';

  @override
  String get language => '言語';
}
