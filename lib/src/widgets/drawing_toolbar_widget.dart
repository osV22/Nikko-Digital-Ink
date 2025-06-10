import 'package:flutter/material.dart';
import 'package:hand_signature/signature.dart';
import '../models/drawing_settings.dart';
import '../utils/responsive_utils.dart';

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
      height: ResponsiveUtils.scaleButtonSize(context, 70),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(
          ResponsiveUtils.getResponsiveBorderRadius(context, 12.0),
        ),
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
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveUtils.scalePadding(context, 2.0),
        ),
        child: Row(
          children: [
            // Stroke width controls - show ALL on every device (4 items, reduced from 6)
            Expanded(
              flex: 4, // 4 items now instead of 6
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: DrawingSettings.availableStrokeWidths
                    .map((width) => _buildStrokeWidthButton(context, width))
                    .toList(),
              ),
            ),

            _buildVerticalDivider(context),

            // Color picker - show ALL 4 colors on every device (4 items)
            Expanded(
              flex: 4, // 4 items
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: DrawingSettings.availableColors
                    .map((color) => _buildColorButton(context, color))
                    .toList(),
              ),
            ),

            _buildVerticalDivider(context),

            // Draw Type/Quality controls - all 3 types (3 items)
            Expanded(
              flex: 3, // 3 items
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: DrawingSettings.availableDrawTypes
                    .map((drawType) => _buildDrawTypeButton(context, drawType))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVerticalDivider(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 1,
      height: ResponsiveUtils.scaleButtonSize(
        context,
        24,
      ), // Taller to match bigger buttons
      margin: EdgeInsets.symmetric(
        horizontal: ResponsiveUtils.scalePadding(context, 1),
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.outline.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(0.5),
      ),
    );
  }

  Widget _buildStrokeWidthButton(BuildContext context, double width) {
    final theme = Theme.of(context);
    final isSelected = settings.strokeWidth == width;
    final buttonSize = ResponsiveUtils.scaleButtonSize(
      context,
      28,
    );

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveUtils.scalePadding(context, 0.1),
      ),
      child: InkWell(
        onTap: () => onSettingsChanged(settings.copyWith(strokeWidth: width)),
        borderRadius: BorderRadius.circular(
          ResponsiveUtils.getResponsiveBorderRadius(context, 4.0),
        ),
        child: Container(
          width: buttonSize,
          height: buttonSize,
          decoration: BoxDecoration(
            color: isSelected
                ? theme.colorScheme.primary.withValues(alpha: 0.1)
                : null,
            borderRadius: BorderRadius.circular(
              ResponsiveUtils.getResponsiveBorderRadius(context, 4.0),
            ),
            border: isSelected
                ? Border.all(
                    color: theme.colorScheme.primary,
                    width: 1.5,
                  )
                : null,
          ),
          child: Center(
            child: Container(
              width:
                  (width * 1.4) *
                  ResponsiveUtils.getScaleFactor(
                    context,
                  ), // Even smaller visual
              height: (width * 1.4) * ResponsiveUtils.getScaleFactor(context),
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
    final buttonSize = ResponsiveUtils.scaleButtonSize(
      context,
      28,
    );
    final colorSize = ResponsiveUtils.scaleButtonSize(
      context,
      14,
    );

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveUtils.scalePadding(context, 0.1),
      ),
      child: InkWell(
        onTap: () => onSettingsChanged(settings.copyWith(strokeColor: color)),
        borderRadius: BorderRadius.circular(
          ResponsiveUtils.getResponsiveBorderRadius(context, 4.0),
        ),
        child: Container(
          width: buttonSize,
          height: buttonSize,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              ResponsiveUtils.getResponsiveBorderRadius(context, 4.0),
            ),
            border: isSelected
                ? Border.all(
                    color: theme.colorScheme.primary,
                    width: 1.5, // Thinner border
                  )
                : Border.all(
                    color: theme.colorScheme.outline.withValues(alpha: 0.3),
                    width: 0.5, // Very thin border
                  ),
          ),
          child: Center(
            child: Container(
              width: colorSize,
              height: colorSize,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 0.5, // Thinner white border
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDrawTypeButton(
    BuildContext context,
    SignatureDrawType drawType,
  ) {
    final theme = Theme.of(context);
    final isSelected = settings.drawType == drawType;
    final buttonSize = ResponsiveUtils.scaleButtonSize(
      context,
      28,
    );

    // Define icons and tooltips for each draw type
    IconData icon;
    String tooltip;

    switch (drawType) {
      case SignatureDrawType.line:
        icon = Icons.timeline; // Simple line icon
        tooltip = 'Line (Fast)';
        break;
      case SignatureDrawType.shape:
        icon = Icons.gesture; // Balanced drawing icon
        tooltip = 'Shape (Balanced)';
        break;
      case SignatureDrawType.arc:
        icon = Icons.brush; // High quality brush icon
        tooltip = 'Arc (Best Quality)';
        break;
    }

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveUtils.scalePadding(context, 0.1),
      ),
      child: Tooltip(
        message: tooltip,
        child: InkWell(
          onTap: () => onSettingsChanged(settings.copyWith(drawType: drawType)),
          borderRadius: BorderRadius.circular(
            ResponsiveUtils.getResponsiveBorderRadius(context, 4.0),
          ),
          child: Container(
            width: buttonSize,
            height: buttonSize,
            decoration: BoxDecoration(
              color: isSelected
                  ? theme.colorScheme.primary.withValues(alpha: 0.1)
                  : null,
              borderRadius: BorderRadius.circular(
                ResponsiveUtils.getResponsiveBorderRadius(context, 4.0),
              ),
              border: isSelected
                  ? Border.all(
                      color: theme.colorScheme.primary,
                      width: 1.5,
                    )
                  : null,
            ),
            child: Icon(
              icon,
              size: ResponsiveUtils.scaleIconSize(context, 14), // Larger icon
              color: isSelected
                  ? theme.colorScheme.primary
                  : theme.colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
        ),
      ),
    );
  }
}
