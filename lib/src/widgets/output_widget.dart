import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/drawing_bloc.dart';
import '../utils/responsive_utils.dart';
import '../../l10n/app_localizations.dart';

class OutputWidget extends StatelessWidget {
  const OutputWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    return Card(
      elevation: ResponsiveUtils.getResponsiveElevation(context, 2.0),
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          ResponsiveUtils.getResponsiveBorderRadius(context, 12.0),
        ),
      ),
      child: Container(
        width: double.infinity,
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
        child: Padding(
          padding: EdgeInsets.all(ResponsiveUtils.scalePadding(context, 8.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.text_fields,
                    color: theme.colorScheme.primary,
                    size: ResponsiveUtils.scaleIconSize(context, 20),
                  ),
                  SizedBox(width: ResponsiveUtils.scalePadding(context, 8)),
                  Text(
                    l10n?.recognizedText ?? 'Recognized Text',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onSurface,
                      fontSize: ResponsiveUtils.scaleFontSize(context, 16),
                    ),
                  ),
                ],
              ),
              SizedBox(height: ResponsiveUtils.scalePadding(context, 16)),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(
                    ResponsiveUtils.scalePadding(context, 16.0),
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerHighest.withValues(
                      alpha: 0.1,
                    ),
                    borderRadius: BorderRadius.circular(
                      ResponsiveUtils.getResponsiveBorderRadius(context, 8.0),
                    ),
                    border: Border.all(
                      color: theme.colorScheme.outline.withValues(alpha: 0.05),
                    ),
                  ),
                  child: BlocBuilder<DrawingBloc, DrawingState>(
                    builder: (context, state) {
                      return SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (state.recognizedText.isEmpty)
                              Text(
                                l10n?.drawCharactersHint ??
                                    'Draw Japanese characters below to see recognition results...',
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  color: theme.colorScheme.onSurface.withValues(
                                    alpha: 0.6,
                                  ),
                                  fontStyle: FontStyle.italic,
                                  fontSize: ResponsiveUtils.scaleFontSize(
                                    context,
                                    16,
                                  ),
                                ),
                              )
                            else
                              SelectableText(
                                state.recognizedText,
                                style: theme.textTheme.headlineMedium?.copyWith(
                                  color: theme.colorScheme.onSurface,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.2,
                                  // Make the recognized text scale even more for better visibility on iPad
                                  fontSize: ResponsiveUtils.scaleFontSize(
                                    context,
                                    50,
                                  ),
                                ),
                              ),
                            if (state.errorMessage != null) ...[
                              SizedBox(
                                height: ResponsiveUtils.scalePadding(
                                  context,
                                  12,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(
                                  ResponsiveUtils.scalePadding(context, 12),
                                ),
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.errorContainer
                                      .withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(
                                    ResponsiveUtils.getResponsiveBorderRadius(
                                      context,
                                      6.0,
                                    ),
                                  ),
                                  border: Border.all(
                                    color: theme.colorScheme.error.withValues(
                                      alpha: 0.3,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.error_outline,
                                      color: theme.colorScheme.error,
                                      size: ResponsiveUtils.scaleIconSize(
                                        context,
                                        16,
                                      ),
                                    ),
                                    SizedBox(
                                      width: ResponsiveUtils.scalePadding(
                                        context,
                                        8,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        state.errorMessage!,
                                        style: theme.textTheme.bodySmall
                                            ?.copyWith(
                                              color: theme.colorScheme.error,
                                              fontSize:
                                                  ResponsiveUtils.scaleFontSize(
                                                    context,
                                                    12,
                                                  ),
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
