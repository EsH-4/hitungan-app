import 'package:flutter/material.dart';
import '../config/app_colors.dart';
import '../config/app_dimensions.dart';

/// Konfigurasi decorations aplikasi
class AppDecorations {
  // Card Decorations
  static BoxDecoration get card => const BoxDecoration(
    color: AppColors.cardBackground,
    borderRadius: BorderRadius.all(Radius.circular(AppDimensions.radiusL)),
    boxShadow: [
      BoxShadow(
        color: AppColors.shadow,
        blurRadius: AppDimensions.shadowBlur,
        offset: Offset(0, AppDimensions.shadowOffset),
      ),
    ],
  );
  
  static BoxDecoration get cardHover => BoxDecoration(
    color: AppColors.cardBackground,
    borderRadius: BorderRadius.circular(AppDimensions.radiusL),
    boxShadow: [
      BoxShadow(
        color: AppColors.shadow,
        blurRadius: AppDimensions.shadowBlurL,
        offset: const Offset(0, AppDimensions.shadowOffsetL),
      ),
    ],
  );
  
  // Primary Card
  static BoxDecoration get primaryCard => BoxDecoration(
    gradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: AppColors.primaryGradient,
    ),
    borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
    boxShadow: [
      BoxShadow(
        color: AppColors.shadowPrimary,
        blurRadius: AppDimensions.shadowBlurXL,
        offset: const Offset(0, AppDimensions.shadowOffsetL),
      ),
    ],
  );
  
  // Button Decorations
  static BoxDecoration get primaryButton => BoxDecoration(
    color: AppColors.primary,
    borderRadius: BorderRadius.circular(AppDimensions.radiusM),
    boxShadow: [
      BoxShadow(
        color: AppColors.primary.withOpacity(0.3),
        blurRadius: AppDimensions.shadowBlur,
        offset: const Offset(0, AppDimensions.shadowOffset),
      ),
    ],
  );
  
  static BoxDecoration get secondaryButton => BoxDecoration(
    color: AppColors.surface,
    borderRadius: BorderRadius.circular(AppDimensions.radiusM),
    border: Border.all(color: AppColors.border),
  );
  
  // Input Decorations
  static BoxDecoration get inputField => BoxDecoration(
    color: AppColors.surface,
    borderRadius: BorderRadius.circular(AppDimensions.radiusM),
    border: Border.all(color: AppColors.border),
  );
  
  static BoxDecoration get inputFieldFocused => BoxDecoration(
    color: AppColors.surface,
    borderRadius: BorderRadius.circular(AppDimensions.radiusM),
    border: Border.all(color: AppColors.borderFocused),
  );
  
  // Icon Container
  static BoxDecoration get iconContainer => BoxDecoration(
    color: AppColors.primary.withOpacity(0.1),
    borderRadius: BorderRadius.circular(AppDimensions.radiusM),
  );
  
  static BoxDecoration get iconContainerSuccess => BoxDecoration(
    color: AppColors.success.withOpacity(0.2),
    borderRadius: BorderRadius.circular(AppDimensions.radiusM),
  );
  
  static BoxDecoration get iconContainerError => BoxDecoration(
    color: AppColors.error.withOpacity(0.2),
    borderRadius: BorderRadius.circular(AppDimensions.radiusM),
  );
  
  // Avatar
  static BoxDecoration get avatar => BoxDecoration(
    color: AppColors.primary,
    borderRadius: BorderRadius.circular(AppDimensions.radiusCircle),
    boxShadow: [
      BoxShadow(
        color: AppColors.shadowPrimary,
        blurRadius: AppDimensions.shadowBlur,
        offset: const Offset(0, AppDimensions.shadowOffset),
      ),
    ],
  );
  
  // Bottom Sheet
  static BoxDecoration get bottomSheet => BoxDecoration(
    color: AppColors.surface,
    borderRadius: const BorderRadius.only(
      topLeft: Radius.circular(AppDimensions.radiusXXL),
      topRight: Radius.circular(AppDimensions.radiusXXL),
    ),
    boxShadow: [
      BoxShadow(
        color: AppColors.shadow,
        blurRadius: AppDimensions.shadowBlurL,
        offset: const Offset(0, -AppDimensions.shadowOffset),
      ),
    ],
  );
  
  // Transaction Card
  static BoxDecoration get transactionCard => BoxDecoration(
    color: AppColors.surface,
    borderRadius: BorderRadius.circular(AppDimensions.radiusL),
    border: Border.all(color: AppColors.border.withOpacity(0.5)),
  );
  
  // Category Card
  static BoxDecoration get categoryCard => BoxDecoration(
    color: AppColors.surface,
    borderRadius: BorderRadius.circular(AppDimensions.radiusL),
    boxShadow: [
      BoxShadow(
        color: AppColors.shadow,
        blurRadius: AppDimensions.shadowBlur,
        offset: const Offset(0, AppDimensions.shadowOffset),
      ),
    ],
  );
}
