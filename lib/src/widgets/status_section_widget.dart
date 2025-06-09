import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

class StatusSectionWidget extends StatelessWidget {
  const StatusSectionWidget({
    super.key,
    required this.isDownloading,
    required this.isModelDownloaded,
    required this.downloadStatus,
  });

  final bool isDownloading;
  final bool isModelDownloaded;
  final String downloadStatus;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    return Column(
      children: [
        if (isDownloading) ...[
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 24),
        ],
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest.withValues(
              alpha: 0.5,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            _getStatusText(downloadStatus, l10n),
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: isModelDownloaded
                  ? theme.colorScheme.primary
                  : theme.colorScheme.onSurface.withValues(alpha: 0.8),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  String _getStatusText(String statusKey, AppLocalizations? l10n) {
    switch (statusKey) {
      case 'checkingModelStatus':
        return l10n?.checkingModelStatus ?? 'Checking model status...';
      case 'downloadingModel':
        return l10n?.downloadingModel ?? 'Downloading AI Model, please wait...';
      case 'modelReady':
        return l10n?.modelReady ?? 'Model ready! You can now proceed.';
      case 'downloadFailed':
        return l10n?.downloadFailed ??
            'Failed to download model. Please try again.';
      default:
        return statusKey; // Fallback to the key itself
    }
  }
}
