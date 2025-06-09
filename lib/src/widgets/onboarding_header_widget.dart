import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

class OnboardingHeaderWidget extends StatelessWidget {
  const OnboardingHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    return Column(
      children: [
        Icon(
          Icons.brush,
          size: 80,
          color: theme.colorScheme.primary,
        ),
        const SizedBox(height: 32),
        Text(
          l10n?.appTitle ?? 'Nikko Digital Ink',
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          l10n?.appSubtitle ?? 'Japanese Character Recognition',
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }
}
