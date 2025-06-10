import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/drawing_bloc.dart';
import '../utils/responsive_utils.dart';
import '../../l10n/app_localizations.dart';

class ToolbarWidget extends StatelessWidget {
  const ToolbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final scaleFactor = ResponsiveUtils.getScaleFactor(context);

    // iPhone landscape specific smaller sizes to fit in constrained height
    final iconSize = ResponsiveUtils.isPhoneLandscape(context)
        ? ResponsiveUtils.scaleIconSize(
            context,
            16,
          ) // Smaller icons for iPhone landscape
        : ResponsiveUtils.scaleIconSize(
            context,
            18,
          ); // Normal size for other devices

    final fontSize = ResponsiveUtils.isPhoneLandscape(context)
        ? ResponsiveUtils.scaleFontSize(
            context,
            12,
          ) // Smaller font for iPhone landscape
        : ResponsiveUtils.scaleFontSize(
            context,
            14,
          ); // Normal size for other devices

    final verticalPadding = ResponsiveUtils.isPhoneLandscape(context)
        ? ResponsiveUtils.scalePadding(
            context,
            4.0,
          ) // Less vertical padding for iPhone landscape
        : ResponsiveUtils.scalePadding(
            context,
            8.0,
          ); // Normal padding for other devices

    return Card(
      elevation: ResponsiveUtils.getResponsiveElevation(context, 1.0),
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          ResponsiveUtils.getResponsiveBorderRadius(context, 12.0),
        ),
      ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveUtils.scalePadding(context, 8.0),
          vertical: verticalPadding,
        ),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(
            ResponsiveUtils.getResponsiveBorderRadius(context, 12.0),
          ),
          border: Border.all(
            color: theme.colorScheme.outline.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FilledButton.icon(
              onPressed: () {
                context.read<DrawingBloc>().add(
                  const DrawingEvent.processRequested(),
                );
              },
              icon: Icon(
                Icons.auto_awesome,
                size: iconSize,
              ),
              label: Text(
                l10n?.process ?? 'Process',
                style: TextStyle(
                  fontSize: fontSize,
                ),
              ),
              style: FilledButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: theme.colorScheme.onPrimary,
                padding: ResponsiveUtils.getResponsivePadding(context),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    ResponsiveUtils.getResponsiveBorderRadius(context, 8.0),
                  ),
                ),
              ),
            ),
            SizedBox(width: ResponsiveUtils.scalePadding(context, 12)),
            OutlinedButton.icon(
              onPressed: () {
                context.read<DrawingBloc>().add(
                  const DrawingEvent.clearRequested(),
                );
              },
              icon: Icon(
                Icons.clear_all,
                size: iconSize,
              ),
              label: Text(
                l10n?.clear ?? 'Clear',
                style: TextStyle(
                  fontSize: fontSize,
                ),
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: theme.colorScheme.error,
                side: BorderSide(
                  color: theme.colorScheme.error.withValues(alpha: 0.5),
                ),
                padding: ResponsiveUtils.getResponsivePadding(context),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    ResponsiveUtils.getResponsiveBorderRadius(context, 8.0),
                  ),
                ),
              ),
            ),
            SizedBox(width: ResponsiveUtils.scalePadding(context, 12)),
            Flexible(
              child: BlocBuilder<DrawingBloc, DrawingState>(
                builder: (context, state) {
                  return Container(
                    width: ResponsiveUtils.scaleButtonSize(context, 140),
                    padding: EdgeInsets.symmetric(
                      horizontal: ResponsiveUtils.scalePadding(context, 12),
                      vertical: verticalPadding,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: ResponsiveUtils.scaleIconSize(context, 16),
                          height: ResponsiveUtils.scaleIconSize(context, 16),
                          child: state.isRecognizing
                              ? CircularProgressIndicator(
                                  strokeWidth: 2 * scaleFactor,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    theme.colorScheme.primary,
                                  ),
                                )
                              : Icon(
                                  Icons.gesture,
                                  color: theme.colorScheme.onSurfaceVariant,
                                  size: ResponsiveUtils.scaleIconSize(
                                    context,
                                    16,
                                  ),
                                ),
                        ),
                        SizedBox(
                          width: ResponsiveUtils.scalePadding(context, 6),
                        ),
                        Flexible(
                          child: Text(
                            state.isRecognizing
                                ? (l10n?.processing ?? 'Processing...')
                                : (l10n?.strokes(state.strokes.length) ??
                                      'Strokes: ${state.strokes.length}'),
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                              fontWeight: FontWeight.w500,
                              fontSize: ResponsiveUtils.scaleFontSize(
                                context,
                                12,
                              ),
                            ),
                          ),
                        ),
                        if (state.errorMessage != null) ...[
                          SizedBox(
                            width: ResponsiveUtils.scalePadding(context, 12),
                          ),
                          Container(
                            padding: EdgeInsets.all(
                              ResponsiveUtils.scalePadding(context, 4),
                            ),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.errorContainer
                                  .withValues(
                                    alpha: 0.3,
                                  ),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.error_outline,
                              color: theme.colorScheme.error,
                              size: ResponsiveUtils.scaleIconSize(context, 14),
                            ),
                          ),
                        ],
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
