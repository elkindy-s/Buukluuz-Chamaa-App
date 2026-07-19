import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Brand colours
  static const Color maroon     = Color(0xFF7B1A1A);
  static const Color maroonLight = Color(0xFF9B2020);
  static const Color maroonDark  = Color(0xFF5A1010);
  static const Color cream       = Color(0xFFFDF8F8);
  static const Color white       = Color(0xFFFFFFFF);
  static const Color grey100     = Color(0xFFF5F0F0);
  static const Color grey400     = Color(0xFFBBAAAA);
  static const Color grey700     = Color(0xFF555050);
  static const Color dark        = Color(0xFF1A1A1A);

  static ThemeData get light {
    final base = ThemeData.light(useMaterial3: true);
    return base.copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: maroon,
        primary: maroon,
        onPrimary: white,
        secondary: maroonLight,
        background: white,
        surface: cream,
      ),
      scaffoldBackgroundColor: white,
      textTheme: GoogleFonts.interTextTheme(base.textTheme).copyWith(
        displayLarge: GoogleFonts.playfairDisplay(
          fontSize: 42, fontWeight: FontWeight.w700, color: dark,
        ),
        displayMedium: GoogleFonts.playfairDisplay(
          fontSize: 32, fontWeight: FontWeight.w700, color: dark,
        ),
        headlineMedium: GoogleFonts.playfairDisplay(
          fontSize: 22, fontWeight: FontWeight.w700, color: dark,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: maroon,
        foregroundColor: white,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: maroon,
          foregroundColor: white,
          minimumSize: const Size(double.infinity, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFDDDDDD)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: maroon, width: 1.5),
        ),
      ),
    );
  }
}