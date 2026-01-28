import 'package:flutter/material.dart';

/// App color constants
class AppColors {
  AppColors._();

  // Base colors
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);

  // Background colors
  static const Color backgroundDark = Color(0xFF000000);
  static const Color backgroundPurple = Color(0xFF1A1A2E);

  // Gradient colors
  static const Color gradientBlue1 = Color(0xFF4FACFE);
  static const Color gradientCyan = Color(0xFF00F2FE);
  static const Color gradientOrchid = Color(0xFFD57EEB);

  static const Color gradientIndigo = Color(0xFF6366F1);
  static const Color gradientViolet = Color(0xFF8B5CF6);
  static const Color gradientFuchsia = Color(0xFFD946EF);

  // Glow colors
  static const Color glowBlue = Colors.blue;

  // Gradients
  static const LinearGradient primaryTextGradient = LinearGradient(
    colors: [gradientBlue1, gradientCyan, gradientOrchid],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient primaryButtonGradient = LinearGradient(
    colors: [gradientIndigo, gradientViolet, gradientFuchsia],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const RadialGradient backgroundGradient = RadialGradient(
    center: Alignment.topCenter,
    radius: 1.5,
    colors: [backgroundPurple, backgroundDark],
    stops: [0.0, 0.7],
  );
}
