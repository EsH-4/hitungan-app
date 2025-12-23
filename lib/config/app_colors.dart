import 'package:flutter/material.dart';

/// Konfigurasi warna aplikasi
class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF2E7D32);
  static const Color primaryDark = Color(0xFF1B5E20);
  static const Color primaryLight = Color(0xFF4CAF50);
  
  // Background Colors
  static const Color background = Color(0xFFF8F9FA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color cardBackground = Color(0xFFFFFFFF);
  
  // Text Colors
  static const Color textPrimary = Color(0xFF1B5E20);
  static const Color textSecondary = Color(0xFF666666);
  static const Color textTertiary = Color(0xFF999999);
  static const Color textDisabled = Color(0xFFCCCCCC);
  static const Color textWhite = Color(0xFFFFFFFF);
  
  // Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFF44336);
  static const Color warning = Color(0xFFFF9800);
  static const Color info = Color(0xFF2196F3);
  
  // Income/Expense Colors
  static const Color income = Color(0xFF4CAF50);
  static const Color expense = Color(0xFFF44336);
  
  // Border Colors
  static const Color border = Color(0xFFE0E0E0);
  static const Color borderFocused = Color(0xFF2E7D32);
  
  // Shadow Colors
  static const Color shadow = Color(0x1A000000);
  static const Color shadowPrimary = Color(0x662E7D32);
  
  // Icon Colors
  static const Color iconPrimary = Color(0xFF1B5E20);
  static const Color iconSecondary = Color(0xFF666666);
  static const Color iconWhite = Color(0xFFFFFFFF);
  
  // Gradient Colors
  static const List<Color> primaryGradient = [
    Color(0xFF2E7D32),
    Color(0xFF1B5E20),
  ];
  
  static const List<Color> successGradient = [
    Color(0xFF4CAF50),
    Color(0xFF2E7D32),
  ];
  
  static const List<Color> errorGradient = [
    Color(0xFFF44336),
    Color(0xFFD32F2F),
  ];
}
