import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Brand Colors
  static const Color primaryGreen = Color(0xFF05190E);
  static const Color primaryContainer = Color(0xFF1A2E22);
  static const Color petalPink = Color(0xFF6F5959);
  static const Color pinkContainer = Color(0xFFF6D9D9);
  static const Color richGold = Color(0xFF211300);
  static const Color goldContainer = Color(0xFF3B2600);
  static const Color alabaster = Color(0xFFFBF9F6);
  static const Color onSurface = Color(0xFF1B1C1A);
  static const Color outline = Color(0xFF737873);

  // Added textSecondary color
  static const Color textSecondary = Color(0xFF8A8E89);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: primaryGreen,
        onPrimary: Colors.white,
        primaryContainer: primaryContainer,
        onPrimaryContainer: Colors.white,
        secondary: petalPink,
        onSecondary: Colors.white,
        secondaryContainer: pinkContainer,
        onSecondaryContainer: onSurface,
        tertiary: richGold,
        onTertiary: Colors.white,
        tertiaryContainer: goldContainer,
        onTertiaryContainer: Colors.white,
        error: Colors.red,
        onError: Colors.white,
        surface: alabaster,
        onSurface: onSurface,
        outline: outline,
      ),
      scaffoldBackgroundColor: alabaster,
      textTheme: TextTheme(
        displayLarge: GoogleFonts.notoSerif(
          fontSize: 64,
          fontWeight: FontWeight.w400,
          height: 1.1,
          letterSpacing: -1.28,
          color: primaryGreen,
        ),
        displayMedium: GoogleFonts.notoSerif(
          fontSize: 48,
          fontWeight: FontWeight.w400,
          height: 1.2,
          color: primaryGreen,
        ),
        displaySmall: GoogleFonts.notoSerif(
          fontSize: 32,
          fontWeight: FontWeight.w400,
          height: 1.3,
          color: primaryGreen,
        ),
        headlineLarge: GoogleFonts.notoSerif(
          fontSize: 28,
          fontWeight: FontWeight.w500,
          height: 1.3,
          color: primaryGreen,
        ),
        headlineMedium: GoogleFonts.notoSerif(
          fontSize: 24,
          fontWeight: FontWeight.w500,
          height: 1.4,
          color: primaryGreen,
        ),
        headlineSmall: GoogleFonts.notoSerif(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          height: 1.4,
          color: primaryGreen,
        ),
        titleLarge: GoogleFonts.manrope(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          height: 1.4,
          color: onSurface,
        ),
        titleMedium: GoogleFonts.manrope(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          height: 1.4,
          color: onSurface,
        ),
        titleSmall: GoogleFonts.manrope(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          height: 1.4,
          color: onSurface,
        ),
        bodyLarge: GoogleFonts.manrope(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          height: 1.6,
          color: onSurface,
        ),
        bodyMedium: GoogleFonts.manrope(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          height: 1.6,
          color: onSurface,
        ),
        bodySmall: GoogleFonts.manrope(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          height: 1.5,
          color: textSecondary,
        ),
        labelLarge: GoogleFonts.manrope(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          height: 1.0,
          letterSpacing: 1.8,
          color: onSurface,
        ),
        labelMedium: GoogleFonts.manrope(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          color: textSecondary,
        ),
        labelSmall: GoogleFonts.manrope(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          color: textSecondary,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: alabaster,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: primaryGreen),
        titleTextStyle: TextStyle(
          color: primaryGreen,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          letterSpacing: 4,
        ),
      ),
      buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryGreen,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryGreen,
          side: const BorderSide(color: richGold, width: 1),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: false,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: primaryGreen),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: primaryGreen, width: 2),
        ),
        labelStyle: GoogleFonts.manrope(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.8,
          color: primaryGreen,
        ),
        hintStyle: GoogleFonts.manrope(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: textSecondary,
        ),
      ),
      hintColor: textSecondary,
      disabledColor: textSecondary.withOpacity(0.5),
    );
  }
}
