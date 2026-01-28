import 'package:flutter/material.dart';
import 'package:knot/core/theme/app_colors.dart';

/// App theme configuration
class AppTheme {
  AppTheme._();

  static ThemeData get darkTheme => ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.gradientViolet,
      brightness: Brightness.dark,
    ),
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.backgroundDark,
  );
}
