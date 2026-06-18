// lib/theme/app_theme.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // ── Palette ────────────────────────────────────────────────────────────────
  static const Color pink = Color(0xFFFF2D78);
  static const Color coral = Color(0xFFFF6B6B);
  static const Color lilac = Color(0xFFC77DFF);
  static const Color gold = Color(0xFFFFD166);
  static const Color bgPage = Color(0xFFFFF5F8);
  static const Color bgSection = Color(0xFFFFECF3);
  static const Color bgCard = Color(0xFFFFFFFF);
  static const Color textDark = Color(0xFF1A0A12);
  static const Color textMid = Color(0xFF7A4A60);
  static const Color textLight = Color(0xFFB07A90);

  // ── Gradients ──────────────────────────────────────────────────────────────
  static const LinearGradient brandGradient = LinearGradient(
    colors: [pink, lilac],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient heroGradient = LinearGradient(
    colors: [Color(0xFFFFECF3), Color(0xFFF3E6FF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [pink, lilac],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // ── Typography (Fixed for Build Stability) ─────────────────────────────────

  static TextStyle get displayLarge => GoogleFonts.playfairDisplay(
        fontSize: 64,
        fontWeight: FontWeight.w700,
        color: textDark,
        height: 1.1,
        letterSpacing: -1.0,
      );

  static TextStyle get displayMedium => GoogleFonts.playfairDisplay(
        fontSize: 44,
        fontWeight: FontWeight.w700,
        color: textDark,
        height: 1.2,
      );

  static TextStyle get headingMedium => GoogleFonts.playfairDisplay(
        fontSize: 26,
        fontWeight: FontWeight.w600,
        color: textDark,
      );

  static TextStyle get bodyLarge => GoogleFonts.dmSans(
        fontSize: 17,
        fontWeight: FontWeight.w400,
        color: textMid,
        height: 1.7,
      );

  static TextStyle get bodyMedium => GoogleFonts.dmSans(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: textMid,
        height: 1.6,
      );

  static TextStyle get labelTag => GoogleFonts.dmSans(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: pink,
        letterSpacing: 2.2,
      );
}
