import 'package:flutter/material.dart';
import 'router.dart';
import 'src/widgets/responsive_theme_builder.dart';
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
    return ResponsiveThemeBuilder(
      builder: (context, lightTheme, darkTheme) {
        return MaterialApp.router(
          title: 'Nikko Digital Ink',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: ThemeMode.dark, // Force dark mode for better contrast
          routerConfig: AppRouter.createRouter(),
          debugShowCheckedModeBanner: false,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: _locale,
        );
      },
    );
  }
}
