import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../utils/responsive_utils.dart';
import '../../l10n/app_localizations.dart';

class OnboardingContinueButton extends StatelessWidget {
  const OnboardingContinueButton({
    super.key,
    required this.isModelDownloaded,
  });

  final bool isModelDownloaded;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        onPressed: isModelDownloaded ? () => context.goNamed('home') : null,
        style: FilledButton.styleFrom(
          backgroundColor: isModelDownloaded
              ? const Color.fromARGB(255, 74, 135, 233)
              : theme.colorScheme.outline,
          foregroundColor: isModelDownloaded
              ? Colors.white
              : theme.colorScheme.onSurface.withValues(alpha: 0.6),
          padding: EdgeInsets.symmetric(
            vertical: ResponsiveUtils.scalePadding(context, 16),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              ResponsiveUtils.getResponsiveBorderRadius(context, 12.0),
            ),
          ),
        ),
        child: Text(
          isModelDownloaded
              ? (l10n?.getStarted ?? 'Get Started')
              : (l10n?.pleaseWait ?? 'Please Wait...'),
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: ResponsiveUtils.scaleFontSize(context, 16),
          ),
        ),
      ),
    );
  }
}
