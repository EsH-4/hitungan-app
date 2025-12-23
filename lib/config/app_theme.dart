import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';
import 'app_dimensions.dart';
import '../styles/app_text_styles.dart';

/// Konfigurasi theme aplikasi
class AppTheme {
  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    
    // Color Scheme
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      primaryContainer: AppColors.primaryLight,
      secondary: AppColors.primaryDark,
      surface: AppColors.surface,
      error: AppColors.error,
      onPrimary: AppColors.textWhite,
      onSecondary: AppColors.textWhite,
      onSurface: AppColors.textPrimary,
      onError: AppColors.textWhite,
    ),
    
    // Scaffold
    scaffoldBackgroundColor: AppColors.background,
    
    // App Bar Theme
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.surface,
      foregroundColor: AppColors.textPrimary,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: AppTextStyles.header3,
      iconTheme: const IconThemeData(
        color: AppColors.iconPrimary,
        size: AppDimensions.iconM,
      ),
    ),
    
    // Text Theme
    textTheme: GoogleFonts.poppinsTextTheme().copyWith(
      displayLarge: AppTextStyles.header1,
      displayMedium: AppTextStyles.header2,
      displaySmall: AppTextStyles.header3,
      headlineLarge: AppTextStyles.header4,
      headlineMedium: AppTextStyles.header4,
      headlineSmall: AppTextStyles.header4,
      titleLarge: AppTextStyles.labelLarge,
      titleMedium: AppTextStyles.labelMedium,
      titleSmall: AppTextStyles.labelSmall,
      bodyLarge: AppTextStyles.bodyLarge,
      bodyMedium: AppTextStyles.bodyMedium,
      bodySmall: AppTextStyles.bodySmall,
      labelLarge: AppTextStyles.labelLarge,
      labelMedium: AppTextStyles.labelMedium,
      labelSmall: AppTextStyles.labelSmall,
    ),
    
    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surface,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingL,
        vertical: AppDimensions.paddingM,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        borderSide: const BorderSide(color: AppColors.borderFocused, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        borderSide: const BorderSide(color: AppColors.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        borderSide: const BorderSide(color: AppColors.error, width: 2),
      ),
      labelStyle: AppTextStyles.labelMedium.copyWith(
        color: AppColors.textSecondary,
      ),
      hintStyle: AppTextStyles.bodyMedium.copyWith(
        color: AppColors.textTertiary,
      ),
    ),
    
    // Card Theme
    cardTheme: CardThemeData(
      color: AppColors.cardBackground,
      elevation: AppDimensions.cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
      ),
    ),
    
    // Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textWhite,
        elevation: AppDimensions.cardElevation,
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingXXL,
          vertical: AppDimensions.paddingL,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        ),
        textStyle: AppTextStyles.buttonMedium,
      ),
    ),
    
    // Text Button Theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingL,
          vertical: AppDimensions.paddingM,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        ),
        textStyle: AppTextStyles.buttonMedium,
      ),
    ),
    
    // Outlined Button Theme
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        side: const BorderSide(color: AppColors.border),
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingXXL,
          vertical: AppDimensions.paddingL,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        ),
        textStyle: AppTextStyles.buttonMedium,
      ),
    ),
    
    // Floating Action Button Theme
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.textWhite,
    ),
    
    // Bottom Navigation Bar Theme
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.surface,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.textTertiary,
      type: BottomNavigationBarType.fixed,
      elevation: AppDimensions.cardElevation,
    ),
    
    // Divider Theme
    dividerTheme: const DividerThemeData(
      color: AppColors.border,
      thickness: 1,
      space: 1,
    ),
    
    // Icon Theme
    iconTheme: const IconThemeData(
      color: AppColors.iconPrimary,
      size: AppDimensions.iconM,
    ),
    
    // Primary Icon Theme
    primaryIconTheme: const IconThemeData(
      color: AppColors.iconWhite,
      size: AppDimensions.iconM,
    ),
  );

  static ThemeData get darkTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    
    // Color Scheme
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary,
      primaryContainer: AppColors.primaryLight,
      secondary: AppColors.primaryDark,
      surface: Color(0xFF1E1E1E),
      error: AppColors.error,
      onPrimary: AppColors.textWhite,
      onSecondary: AppColors.textWhite,
      onSurface: Color(0xFFE0E0E0),
      onError: AppColors.textWhite,
    ),
    
    // Scaffold
    scaffoldBackgroundColor: const Color(0xFF121212),
    
    // App Bar Theme
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1E1E1E),
      foregroundColor: Color(0xFFE0E0E0),
      elevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Color(0xFFE0E0E0),
      ),
      iconTheme: IconThemeData(
        color: Color(0xFFE0E0E0),
        size: AppDimensions.iconM,
      ),
    ),
    
    // Text Theme
    textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme).copyWith(
      displayLarge: AppTextStyles.header1.copyWith(color: const Color(0xFFE0E0E0)),
      displayMedium: AppTextStyles.header2.copyWith(color: const Color(0xFFE0E0E0)),
      displaySmall: AppTextStyles.header3.copyWith(color: const Color(0xFFE0E0E0)),
      headlineLarge: AppTextStyles.header4.copyWith(color: const Color(0xFFE0E0E0)),
      headlineMedium: AppTextStyles.header4.copyWith(color: const Color(0xFFE0E0E0)),
      headlineSmall: AppTextStyles.header4.copyWith(color: const Color(0xFFE0E0E0)),
      titleLarge: AppTextStyles.labelLarge.copyWith(color: const Color(0xFFE0E0E0)),
      titleMedium: AppTextStyles.labelMedium.copyWith(color: const Color(0xFFE0E0E0)),
      titleSmall: AppTextStyles.labelSmall.copyWith(color: const Color(0xFFE0E0E0)),
      bodyLarge: AppTextStyles.bodyLarge.copyWith(color: const Color(0xFFE0E0E0)),
      bodyMedium: AppTextStyles.bodyMedium.copyWith(color: const Color(0xFFB0B0B0)),
      bodySmall: AppTextStyles.bodySmall.copyWith(color: const Color(0xFFB0B0B0)),
      labelLarge: AppTextStyles.labelLarge.copyWith(color: const Color(0xFFE0E0E0)),
      labelMedium: AppTextStyles.labelMedium.copyWith(color: const Color(0xFFB0B0B0)),
      labelSmall: AppTextStyles.labelSmall.copyWith(color: const Color(0xFFB0B0B0)),
    ),
    
    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF2C2C2C),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingL,
        vertical: AppDimensions.paddingM,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        borderSide: const BorderSide(color: Color(0xFF404040)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        borderSide: const BorderSide(color: Color(0xFF404040)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        borderSide: const BorderSide(color: AppColors.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        borderSide: const BorderSide(color: AppColors.error, width: 2),
      ),
      labelStyle: AppTextStyles.labelMedium.copyWith(
        color: const Color(0xFFB0B0B0),
      ),
      hintStyle: AppTextStyles.bodyMedium.copyWith(
        color: const Color(0xFF808080),
      ),
    ),
    
    // Card Theme
    cardTheme: CardThemeData(
      color: const Color(0xFF1E1E1E),
      elevation: AppDimensions.cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
      ),
    ),
    
    // Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textWhite,
        elevation: AppDimensions.cardElevation,
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingXXL,
          vertical: AppDimensions.paddingL,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        ),
        textStyle: AppTextStyles.buttonMedium,
      ),
    ),
    
    // Text Button Theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingL,
          vertical: AppDimensions.paddingM,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        ),
        textStyle: AppTextStyles.buttonMedium,
      ),
    ),
    
    // Outlined Button Theme
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        side: const BorderSide(color: Color(0xFF404040)),
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingXXL,
          vertical: AppDimensions.paddingL,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        ),
        textStyle: AppTextStyles.buttonMedium,
      ),
    ),
    
    // Floating Action Button Theme
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.textWhite,
    ),
    
    // Bottom Navigation Bar Theme
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF1E1E1E),
      selectedItemColor: AppColors.primary,
      unselectedItemColor: Color(0xFF808080),
      type: BottomNavigationBarType.fixed,
    ),
    
    // Divider Theme
    dividerTheme: const DividerThemeData(
      color: Color(0xFF404040),
      thickness: 1,
      space: 1,
    ),
    
    // Icon Theme
    iconTheme: const IconThemeData(
      color: Color(0xFFE0E0E0),
      size: AppDimensions.iconM,
    ),
    
    // Primary Icon Theme
    primaryIconTheme: const IconThemeData(
      color: AppColors.iconWhite,
      size: AppDimensions.iconM,
    ),
  );
}
