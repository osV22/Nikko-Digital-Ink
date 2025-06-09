import 'package:flutter/material.dart';
import 'router.dart';
import 'src/style/theme.dart';
import 'l10n/app_localizations.dart';

class NikkoInkApp extends StatefulWidget {
  const NikkoInkApp({super.key});

  @override
  State<NikkoInkApp> createState() => NikkoInkAppState();

  static NikkoInkAppState? of(BuildContext context) {
    return context.findAncestorStateOfType<NikkoInkAppState>();
  }
}

class NikkoInkAppState extends State<NikkoInkApp> {
  Locale _locale = const Locale('en');

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Nikko Digital Ink',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: AppRouter.createRouter(),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: _locale,
    );
  }
}
