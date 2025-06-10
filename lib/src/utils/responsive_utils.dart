import 'package:flutter/material.dart';

class ResponsiveUtils {
  static const double _phoneBreakpoint = 600.0;
  static const double _tabletBreakpoint = 900.0;

  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static bool isPhone(BuildContext context) {
    return getScreenWidth(context) < _phoneBreakpoint;
  }

  static bool isTablet(BuildContext context) {
    final width = getScreenWidth(context);
    return width >= _phoneBreakpoint && width < _tabletBreakpoint;
  }

  static bool isDesktop(BuildContext context) {
    return getScreenWidth(context) >= _tabletBreakpoint;
  }

  /// Detects if we're on iPhone in landscape mode (constrained height)
  static bool isPhoneLandscape(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isPhoneSize =
        size.width < _phoneBreakpoint || size.height < _phoneBreakpoint;
    final isLandscape = size.width > size.height;
    final hasConstrainedHeight =
        size.height < 500; // iPhone landscape height constraint

    return isPhoneSize && isLandscape && hasConstrainedHeight;
  }

  /// Returns a scaling factor based on screen size
  /// Phone: 1.0, Phone Landscape: 0.85 (smaller to prevent overflow), Tablet: 1.3-1.5, Desktop: 1.6-2.0
  static double getScaleFactor(BuildContext context) {
    final width = getScreenWidth(context);

    // Special handling for iPhone landscape - use smaller scale to prevent overflow
    if (isPhoneLandscape(context)) {
      return 0.85; // Slightly smaller than normal phone to fit constrained height
    }

    if (width < _phoneBreakpoint) {
      return 1.0; // Phone
    } else if (width < _tabletBreakpoint) {
      // Tablet: scale between 1.3 and 1.5 based on screen size
      final tabletProgress =
          (width - _phoneBreakpoint) / (_tabletBreakpoint - _phoneBreakpoint);
      return 1.3 + (tabletProgress * 0.2);
    } else {
      // Desktop: scale between 1.6 and 2.0
      final desktopProgress = ((width - _tabletBreakpoint) / 600).clamp(
        0.0,
        1.0,
      );
      return 1.6 + (desktopProgress * 0.4);
    }
  }

  /// Scale font size based on device
  static double scaleFontSize(BuildContext context, double baseFontSize) {
    return baseFontSize * getScaleFactor(context);
  }

  /// Scale padding/margins based on device
  static double scalePadding(BuildContext context, double basePadding) {
    return basePadding * getScaleFactor(context);
  }

  /// Scale icon size based on device
  static double scaleIconSize(BuildContext context, double baseIconSize) {
    return baseIconSize * getScaleFactor(context);
  }

  /// Scale button size based on device
  static double scaleButtonSize(BuildContext context, double baseButtonSize) {
    return baseButtonSize * getScaleFactor(context);
  }

  /// Get responsive EdgeInsets
  static EdgeInsets getResponsivePadding(
    BuildContext context, {
    double horizontal = 16.0,
    double vertical = 12.0,
  }) {
    final scaleFactor = getScaleFactor(context);
    return EdgeInsets.symmetric(
      horizontal: horizontal * scaleFactor,
      vertical: vertical * scaleFactor,
    );
  }

  /// Get responsive border radius
  static double getResponsiveBorderRadius(
    BuildContext context,
    double baseRadius,
  ) {
    return baseRadius * getScaleFactor(context);
  }

  /// Get responsive elevation
  static double getResponsiveElevation(
    BuildContext context,
    double baseElevation,
  ) {
    return baseElevation * getScaleFactor(context);
  }
}
