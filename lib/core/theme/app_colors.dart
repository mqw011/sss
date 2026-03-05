import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color background = Color(0xFF0D0D0D);
  static const Color surface = Color(0xFF141415); // Slightly lighter than background for depth
  static const Color surfaceLight = Color(0xFF1F1F20); // For list items

  static const Color accentNeonPurple = Color(0xFFBB86FC);
  static const Color accentCyan = Color(0xFF03DAC6);

  static const Color error = Color(0xFFCF6679);

  // Polaroid paper is rarely pure white, usually slightly warm/grey
  static const Color polaroidWhite = Color(0xFFF5F5F3);

  // Text Colors
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xFFA0A0A0); // Softer gray
  static const Color textDark = Color(0xFF1A1A1B); // For polaroid text
}
