import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:knot/core/theme/app_colors.dart';
import 'package:knot/core/utils/constants.dart';

/// Reusable glowing logo widget
class GlowingLogo extends StatelessWidget {
  final double? size;
  final double? glowBlur;
  final double? glowSpread;
  final Color? glowColor;

  const GlowingLogo({
    super.key,
    this.size,
    this.glowBlur,
    this.glowSpread,
    this.glowColor,
  });

  @override
  Widget build(BuildContext context) {
    final logoSize = size ?? AppConstants.logoSizeLarge;

    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: (glowColor ?? AppColors.glowBlue).withValues(
              alpha: AppConstants.opacityMedium,
            ),
            blurRadius: glowBlur ?? AppConstants.glowBlurLarge.r,
            spreadRadius: glowSpread ?? AppConstants.glowSpreadLarge.r,
          ),
        ],
      ),
      child: Image.asset(
        'assets/images/knot_glow.png',
        width: logoSize.w,
        height: logoSize.h,
      ),
    );
  }
}
