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

  // Create router once to prevent recreation during rebuilds
  late final _router = AppRouter.createRouter();

  // Add a global key to maintain app state across rebuilds
  static final GlobalKey<NavigatorState> _navigatorKey =
      GlobalKey<NavigatorState>();

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
          key: const ValueKey('nikko_ink_app'), // Stable key to maintain state
          title: 'Nikko Digital Ink',
          // Use responsive themes instead of static ones
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: ThemeMode.dark, // Force dark mode for better contrast
          routerConfig: _router, // Use the stable router instance
          debugShowCheckedModeBanner: false,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: _locale,
        );
      },
    );
  }
}
