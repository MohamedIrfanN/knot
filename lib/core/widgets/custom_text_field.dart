import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:knot/core/theme/app_colors.dart';
import 'package:knot/core/theme/app_text_styles.dart';
import 'package:knot/core/utils/constants.dart';

/// Reusable custom text field widget
class CustomTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final int maxLines;
  final bool obscureText;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.maxLines = 1,
    this.obscureText = false,
    this.suffixIcon,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.label),
        SizedBox(height: AppConstants.spacingXS.h),
        TextFormField(
          controller: controller,
          maxLines: obscureText ? 1 : maxLines,
          obscureText: obscureText,
          style: TextStyle(color: AppColors.white, fontSize: 16.sp),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: AppTextStyles.hint,
            filled: true,
            fillColor: AppColors.white.withValues(
              alpha: AppConstants.opacityLow,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppConstants.radiusS.r),
              borderSide: BorderSide(
                color: AppColors.white.withValues(
                  alpha: AppConstants.opacityMedium,
                ),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppConstants.radiusS.r),
              borderSide: BorderSide(
                color: AppColors.white.withValues(
                  alpha: AppConstants.opacityMedium,
                ),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppConstants.radiusS.r),
              borderSide: BorderSide(
                color: AppColors.gradientViolet,
                width: AppConstants.borderWidthMedium,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 16.h,
            ),
            suffixIcon: suffixIcon,
          ),
          validator: validator,
        ),
      ],
    );
  }
}
