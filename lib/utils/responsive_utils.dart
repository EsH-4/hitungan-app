import 'package:flutter/material.dart';

/// Utility class untuk responsive design
class ResponsiveUtils {
  // Breakpoints untuk berbagai ukuran layar
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 900;
  static const double desktopBreakpoint = 1200;
  static const double largeDesktopBreakpoint = 1600;

  /// Mendapatkan ukuran layar saat ini
  static Size getScreenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  /// Mendapatkan lebar layar
  static double getScreenWidth(BuildContext context) {
    return getScreenSize(context).width;
  }

  /// Mendapatkan tinggi layar
  static double getScreenHeight(BuildContext context) {
    return getScreenSize(context).height;
  }

  /// Cek apakah layar mobile
  static bool isMobile(BuildContext context) {
    return getScreenWidth(context) < mobileBreakpoint;
  }

  /// Cek apakah layar tablet
  static bool isTablet(BuildContext context) {
    final width = getScreenWidth(context);
    return width >= mobileBreakpoint && width < tabletBreakpoint;
  }

  /// Cek apakah layar desktop
  static bool isDesktop(BuildContext context) {
    final width = getScreenWidth(context);
    return width >= tabletBreakpoint && width < desktopBreakpoint;
  }

  /// Cek apakah layar large desktop
  static bool isLargeDesktop(BuildContext context) {
    return getScreenWidth(context) >= desktopBreakpoint;
  }

  /// Cek apakah layar landscape
  static bool isLandscape(BuildContext context) {
    return getScreenWidth(context) > getScreenHeight(context);
  }

  /// Cek apakah layar portrait
  static bool isPortrait(BuildContext context) {
    return getScreenHeight(context) > getScreenWidth(context);
  }

  /// Mendapatkan padding responsif
  static EdgeInsets getResponsivePadding(BuildContext context) {
    if (isMobile(context)) {
      return const EdgeInsets.all(16);
    } else if (isTablet(context)) {
      return const EdgeInsets.all(24);
    } else {
      return const EdgeInsets.all(32);
    }
  }

  /// Mendapatkan margin responsif
  static EdgeInsets getResponsiveMargin(BuildContext context) {
    if (isMobile(context)) {
      return const EdgeInsets.symmetric(horizontal: 16, vertical: 8);
    } else if (isTablet(context)) {
      return const EdgeInsets.symmetric(horizontal: 24, vertical: 12);
    } else {
      return const EdgeInsets.symmetric(horizontal: 32, vertical: 16);
    }
  }

  /// Mendapatkan font size responsif
  static double getResponsiveFontSize(BuildContext context, double baseFontSize) {
    try {
      if (baseFontSize <= 0) return 14.0;
      
      if (isMobile(context)) {
        return baseFontSize;
      } else if (isTablet(context)) {
        return baseFontSize * 1.1;
      } else {
        return baseFontSize * 1.2;
      }
    } catch (e) {
      return baseFontSize > 0 ? baseFontSize : 14.0;
    }
  }

  /// Mendapatkan icon size responsif
  static double getResponsiveIconSize(BuildContext context, double baseIconSize) {
    try {
      if (baseIconSize <= 0) return 24.0;
      
      if (isMobile(context)) {
        return baseIconSize;
      } else if (isTablet(context)) {
        return baseIconSize * 1.1;
      } else {
        return baseIconSize * 1.2;
      }
    } catch (e) {
      return baseIconSize > 0 ? baseIconSize : 24.0;
    }
  }

  /// Mendapatkan max width untuk content
  static double getMaxContentWidth(BuildContext context) {
    if (isMobile(context)) {
      return double.infinity;
    } else if (isTablet(context)) {
      return 600;
    } else if (isDesktop(context)) {
      return 800;
    } else {
      return 1000;
    }
  }

  /// Mendapatkan jumlah kolom untuk grid
  static int getGridColumns(BuildContext context) {
    if (isMobile(context)) {
      return 2;
    } else if (isTablet(context)) {
      return 3;
    } else if (isDesktop(context)) {
      return 4;
    } else {
      return 5;
    }
  }

  /// Mendapatkan spacing responsif
  static double getResponsiveSpacing(BuildContext context, double baseSpacing) {
    if (isMobile(context)) {
      return baseSpacing;
    } else if (isTablet(context)) {
      return baseSpacing * 1.2;
    } else {
      return baseSpacing * 1.5;
    }
  }

  /// Mendapatkan border radius responsif
  static double getResponsiveBorderRadius(BuildContext context, double baseRadius) {
    if (isMobile(context)) {
      return baseRadius;
    } else if (isTablet(context)) {
      return baseRadius * 1.1;
    } else {
      return baseRadius * 1.2;
    }
  }

  /// Mendapatkan elevation responsif
  static double getResponsiveElevation(BuildContext context, double baseElevation) {
    if (isMobile(context)) {
      return baseElevation;
    } else if (isTablet(context)) {
      return baseElevation * 1.2;
    } else {
      return baseElevation * 1.5;
    }
  }

  /// Mendapatkan layout responsif
  static Widget getResponsiveLayout({
    required BuildContext context,
    required Widget mobile,
    Widget? tablet,
    Widget? desktop,
  }) {
    try {
      if (isMobile(context)) {
        return mobile;
      } else if (isTablet(context) && tablet != null) {
        return tablet;
      } else if (isDesktop(context) && desktop != null) {
        return desktop;
      } else {
        return mobile;
      }
    } catch (e) {
      // Fallback ke mobile layout jika ada error
      return mobile;
    }
  }

  /// Mendapatkan orientation layout
  static Widget getOrientationLayout({
    required BuildContext context,
    required Widget portrait,
    Widget? landscape,
  }) {
    if (isLandscape(context) && landscape != null) {
      return landscape;
    } else {
      return portrait;
    }
  }
}
