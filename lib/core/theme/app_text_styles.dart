import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:knot/core/theme/app_colors.dart';
import 'package:knot/core/utils/constants.dart';

/// App text styles with responsive sizing
class AppTextStyles {
  AppTextStyles._();

  // Headings
  static TextStyle get h1 => TextStyle(
    fontSize: 32.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
    height: 1.2,
  );

  static TextStyle get h2 => TextStyle(
    fontSize: 28.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );

  static TextStyle get h3 => TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );

  // Body text
  static TextStyle get bodyLarge => TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
    letterSpacing: 0.5,
  );

  static TextStyle get bodyMedium => TextStyle(
    fontSize: 14.sp,
    color: AppColors.white.withValues(alpha: AppConstants.opacityHigh),
  );

  static TextStyle get bodySmall => TextStyle(
    fontSize: 13.sp,
    color: AppColors.white.withValues(alpha: AppConstants.opacityHigh),
  );

  // Labels
  static TextStyle get label => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );

  // Hints
  static TextStyle get hint =>
      TextStyle(fontSize: 14.sp, color: AppColors.white.withValues(alpha: 0.3));

  // Button text
  static TextStyle get button => TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
    letterSpacing: 0.5,
  );
}
