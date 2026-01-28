import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:knot/core/theme/app_colors.dart';
import 'package:knot/core/theme/app_text_styles.dart';
import 'package:knot/core/utils/constants.dart';

/// Reusable gradient button widget
class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double? width;
  final double? height;

  const GradientButton({
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
        gradient: AppColors.primaryButtonGradient,
        borderRadius: BorderRadius.circular(AppConstants.radiusL.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.gradientViolet.withValues(
              alpha: AppConstants.opacityMedium * 2,
            ),
            blurRadius: 16.r,
            offset: Offset(0, 4.h),
          ),
        ],
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
