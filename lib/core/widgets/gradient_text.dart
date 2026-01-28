import 'package:flutter/material.dart';
import 'package:knot/core/theme/app_colors.dart';

/// Reusable gradient text widget
class GradientText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final LinearGradient? gradient;
  final TextAlign? textAlign;

  const GradientText({
    super.key,
    required this.text,
    required this.style,
    this.gradient,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) =>
          (gradient ?? AppColors.primaryTextGradient).createShader(bounds),
      child: Text(
        text,
        textAlign: textAlign,
        style: style.copyWith(color: AppColors.white),
      ),
    );
  }
}
