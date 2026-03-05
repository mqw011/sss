import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle get heading1 => GoogleFonts.inter(
        fontSize: 32,
        fontWeight: FontWeight.w800,
        color: AppColors.textPrimary,
      );

  static TextStyle get heading2 => GoogleFonts.inter(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      );

  static TextStyle get heading3 => GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      );
      
  static TextStyle get bodyChat => GoogleFonts.roboto(
        fontSize: 15,
        fontWeight: FontWeight.normal,
        color: AppColors.textPrimary,
      );

  static TextStyle get bodyChatMine => GoogleFonts.roboto(
        fontSize: 15,
        fontWeight: FontWeight.normal,
        color: AppColors.background, // Since my message bubble will be accent colored
      );

  static TextStyle get polaroidMarker => GoogleFonts.permanentMarker(
        fontSize: 18,
        color: AppColors.textDark,
      );
      
  static TextStyle get bodyCaption => GoogleFonts.roboto(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
      );
}
