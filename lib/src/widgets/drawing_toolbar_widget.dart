import 'package:flutter/material.dart';
import '../models/drawing_settings.dart';

class DrawingToolbarWidget extends StatelessWidget {
  final DrawingSettings settings;
  final ValueChanged<DrawingSettings> onSettingsChanged;

  const DrawingToolbarWidget({
    super.key,
    required this.settings,
    required this.onSettingsChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Stroke width controls
            _buildSection(
              context,
              title: 'Width',
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: DrawingSettings.availableStrokeWidths
                    .take(4) // Limit to 4 widths to save space
                    .map((width) => _buildStrokeWidthButton(context, width))
                    .toList(),
              ),
            ),
            const SizedBox(width: 24),

            // Color picker
            _buildSection(
              context,
              title: 'Color',
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: DrawingSettings.availableColors
                    .take(4) // Show 4 colors
                    .map((color) => _buildColorButton(context, color))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required Widget child,
  }) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.labelSmall?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
            fontSize: 10,
          ),
        ),
        const SizedBox(height: 4),
        child,
      ],
    );
  }

  Widget _buildStrokeWidthButton(BuildContext context, double width) {
    final theme = Theme.of(context);
    final isSelected = settings.strokeWidth == width;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1.5),
      child: InkWell(
        onTap: () => onSettingsChanged(settings.copyWith(strokeWidth: width)),
        borderRadius: BorderRadius.circular(6),
        child: Container(
          width: 26,
          height: 26,
          decoration: BoxDecoration(
            color: isSelected
                ? theme.colorScheme.primary.withValues(alpha: 0.1)
                : null,
            borderRadius: BorderRadius.circular(6),
            border: isSelected
                ? Border.all(
                    color: theme.colorScheme.primary,
                    width: 1.5,
                  )
                : null,
          ),
          child: Center(
            child: Container(
              width: width * 2, // Scale for visual representation
              height: width * 2,
              decoration: BoxDecoration(
                color: theme.colorScheme.onSurface,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildColorButton(BuildContext context, Color color) {
    final theme = Theme.of(context);
    final isSelected = settings.strokeColor == color;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1.5),
      child: InkWell(
        onTap: () => onSettingsChanged(settings.copyWith(strokeColor: color)),
        borderRadius: BorderRadius.circular(6),
        child: Container(
          width: 26,
          height: 26,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: isSelected
                ? Border.all(
                    color: theme.colorScheme.primary,
                    width: 2,
                  )
                : Border.all(
                    color: theme.colorScheme.outline.withValues(alpha: 0.3),
                    width: 1,
                  ),
          ),
          child: Center(
            child: Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 1,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
