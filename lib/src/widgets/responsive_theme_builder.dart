import 'package:flutter/material.dart';
import '../style/theme.dart';

class ResponsiveThemeBuilder extends StatelessWidget {
  final Widget Function(
    BuildContext context,
    ThemeData lightTheme,
    ThemeData darkTheme,
  )
  builder;

  const ResponsiveThemeBuilder({
    super.key,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Generate responsive themes based on current screen size
        final lightTheme = AppTheme.responsiveLightTheme(context);
        final darkTheme = AppTheme.responsiveDarkTheme(context);

        return builder(context, lightTheme, darkTheme);
      },
    );
  }
}
