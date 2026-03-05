import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle get headerTitle => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w800,
        letterSpacing: 3.0,
        color: AppColors.textPrimary,
      );

  static TextStyle get heading1 => GoogleFonts.inter(
        fontSize: 30,
        fontWeight: FontWeight.w800,
        letterSpacing: -1.0,
        color: AppColors.textPrimary,
      );

  static TextStyle get heading2 => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        letterSpacing: 2.0,
        color: AppColors.textSecondary,
      );

  static TextStyle get bodyChat => GoogleFonts.publicSans(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: AppColors.textPrimary,
      );

  static TextStyle get monoChat => GoogleFonts.robotoMono(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        color: AppColors.neonCyan,
      );

  static TextStyle get polaroidMarker => GoogleFonts.permanentMarker(
        fontSize: 14,
        color: AppColors.textDark,
      );

  static TextStyle get polaroidCaveat => GoogleFonts.caveat(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: AppColors.textDark,
      );
      
  static TextStyle get bodyCaption => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
      );

  // Added aliases to match archive styling
  static TextStyle get metaStyle => GoogleFonts.inter(
        fontSize: 10,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.5,
        color: AppColors.textSecondary,
      );

  static TextStyle get codeStyle => GoogleFonts.robotoMono(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColors.neonCyan,
      );

  static TextStyle get bodyStyle => GoogleFonts.publicSans(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: AppColors.textPrimary,
      );
}
