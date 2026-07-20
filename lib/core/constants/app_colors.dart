import 'package:flutter/material.dart';

abstract class AppColors {
  // Brand & Gradients
  static const Color primaryBlue = Color(0xFF2563EB); // Royal Blue
  static const Color primaryDarkBlue = Color(0xFF1D4ED8);
  static const Color primaryLightBlue = Color(0xFF3B82F6);

  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8), Color(0xFF1E40AF)],
  );

  // Backgrounds & Containers
  static const Color pageBackground = Color(0xFFF1F5F9); // Light Grayish Blue
  static const Color cardSurface = Colors.white;
  static const Color sidebarBackground = Color(0xFFF8FAFC);

  // Selector & Card states
  static const Color unansweredBg = Color(0xFFE2E8F0);
  static const Color unansweredText = Color(0xFF64748B);

  static const Color answeredBg = Color(0xFFDBEAFE);
  static const Color answeredBorder = Color(0xFF93C5FD);
  static const Color answeredText = Color(0xFF1E40AF);

  static const Color activeRing = Color(0xFF2563EB);

  // Answer Options
  static const Color optionBorder = Color(0xFFE2E8F0);
  static const Color optionHover = Color(0xFFF8FAFC);
  static const Color optionSelectedBorder = Color(0xFF2563EB);
  static const Color optionSelectedBg = Color(0xFFEFF6FF);

  // Status & Feedback Colors
  static const Color successGreen = Color(0xFF10B981);
  static const Color successBg = Color(0xFFECFDF5);
  static const Color successBorder = Color(0xFFA7F3D0);

  static const Color errorRed = Color(0xFFEF4444);
  static const Color errorBg = Color(0xFFFEF2F2);
  static const Color errorBorder = Color(0xFFFECACA);

  // Typography Colors
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color textMuted = Color(0xFF94A3B8);

  // Shadows
  static List<BoxShadow> softCardShadow = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.06),
      blurRadius: 20,
      offset: const Offset(0, 8),
    ),
  ];

  static List<BoxShadow> containerShadow = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.12),
      blurRadius: 30,
      offset: const Offset(0, 12),
    ),
  ];
}
