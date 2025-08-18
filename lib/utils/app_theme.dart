import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Color Palette - Blue to Teal Gradient
  static const Color primaryBlue = Color(0xFF1E40AF);
  static const Color primaryTeal = Color(0xFF0891B2);
  static const Color lightBlue = Color(0xFF3B82F6);
  static const Color lightTeal = Color(0xFF06B6D4);
  static const Color white = Color(0xFFFFFFFF);
  static const Color lightGray = Color(0xFFF8FAFC);
  static const Color darkGray = Color(0xFF64748B);
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color glassWhite = Color(0x40FFFFFF);
  static const Color glassBlue = Color(0x20FFFFFF);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryBlue, primaryTeal],
  );

  static const LinearGradient lightGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [lightBlue, lightTeal],
  );

  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFE0F2FE), Color(0xFFBAE6FD)],
  );

  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0x30FFFFFF), Color(0x10FFFFFF)],
  );

  // Text Styles
  static TextStyle get headingLarge => GoogleFonts.inter(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: primaryBlue,
    height: 1.2,
  );

  static TextStyle get headingMedium => GoogleFonts.inter(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: primaryBlue,
    height: 1.3,
  );

  static TextStyle get headingSmall => GoogleFonts.inter(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: primaryBlue,
    height: 1.3,
  );

  static TextStyle get bodyLarge => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: darkGray,
    height: 1.5,
  );

  static TextStyle get bodyMedium => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: darkGray,
    height: 1.5,
  );

  static TextStyle get bodySmall => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: darkGray,
    height: 1.4,
  );

  static TextStyle get buttonText => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: white,
  );

  // Theme Data
  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryBlue,
      brightness: Brightness.light,
    ),
    textTheme: TextTheme(
      headlineLarge: headingLarge,
      headlineMedium: headingMedium,
      headlineSmall: headingSmall,
      bodyLarge: bodyLarge,
      bodyMedium: bodyMedium,
      bodySmall: bodySmall,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryBlue,
        foregroundColor: white,
        textStyle: buttonText,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      titleTextStyle: headingMedium,
      iconTheme: const IconThemeData(color: primaryBlue),
    ),
  );

  // Glass Card Decoration
  static BoxDecoration get glassCard => BoxDecoration(
    gradient: cardGradient,
    borderRadius: BorderRadius.circular(20),
    border: Border.all(
      color: Colors.white.withOpacity(0.2),
      width: 1,
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 20,
        offset: const Offset(0, 10),
      ),
    ],
  );

  // Button Decoration
  static BoxDecoration get primaryButton => BoxDecoration(
    gradient: primaryGradient,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: primaryBlue.withOpacity(0.3),
        blurRadius: 20,
        offset: const Offset(0, 10),
      ),
    ],
  );
}