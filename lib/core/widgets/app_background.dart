import 'package:flutter/material.dart';
import 'package:knot/core/theme/app_colors.dart';

/// Reusable app background container with gradient
class AppBackground extends StatelessWidget {
  final Widget child;
  final bool useSafeArea;

  const AppBackground({
    super.key,
    required this.child,
    this.useSafeArea = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: AppColors.backgroundDark,
          gradient: AppColors.backgroundGradient,
        ),
        child: useSafeArea ? SafeArea(child: child) : child,
      ),
    );
  }
}
