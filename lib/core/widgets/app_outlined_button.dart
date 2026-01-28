import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:knot/core/theme/app_colors.dart';
import 'package:knot/core/theme/app_text_styles.dart';
import 'package:knot/core/utils/constants.dart';

/// Reusable outlined button widget
class AppOutlinedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double? width;
  final double? height;

  const AppOutlinedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height ?? AppConstants.buttonHeight.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstants.radiusL.r),
        border: Border.all(
          color: AppColors.white.withValues(alpha: AppConstants.opacityMedium),
          width: AppConstants.borderWidthThin,
        ),
        color: AppColors.white.withValues(alpha: AppConstants.opacityLow),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(AppConstants.radiusL.r),
          child: Center(child: Text(text, style: AppTextStyles.button)),
        ),
      ),
    );
  }
}
