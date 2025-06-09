import 'package:flutter/material.dart';
import 'router.dart';
import 'src/style/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Nikko Digital Ink',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: AppRouter.createRouter(),
      debugShowCheckedModeBanner: false,
    );
  }
}
