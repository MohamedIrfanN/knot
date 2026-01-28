import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:knot/core/theme/app_colors.dart';
import 'package:knot/core/utils/constants.dart';
import 'package:knot/features/welcome/presentation/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    // Initialize Animation Controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    // Scaling Animation (Heartbeat/Pulse effect)
    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.8, end: 1.1), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.1, end: 1.0), weight: 50),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // Fade In Animation
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
      ),
    );

    // Start Animation
    _controller.forward();

    // Navigate to Welcome Screen
    _navigateToWelcome();
  }

  _navigateToWelcome() async {
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const WelcomeScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 800),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: AppColors.backgroundDark,
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 1.2,
            colors: [AppColors.backgroundPurple, AppColors.backgroundDark],
            stops: [0.0, 1.0],
          ),
        ),
        child: Center(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Opacity(
                opacity: _fadeAnimation.value,
                child: Transform.scale(
                  scale: _scaleAnimation.value,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Glowing Logo with animated glow
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.glowBlue.withValues(
                                alpha:
                                    AppConstants.opacityMedium +
                                    (_controller.value *
                                        AppConstants.opacityMedium),
                              ),
                              blurRadius:
                                  AppConstants.glowBlurSmall.r +
                                  (_controller.value * 20.r),
                              spreadRadius:
                                  AppConstants.glowSpreadSmall.r +
                                  (_controller.value * 10.r),
                            ),
                          ],
                        ),
                        child: Image.asset(
                          'assets/images/knot_glow.png',
                          width: AppConstants.logoSizeMedium.w,
                          height: AppConstants.logoSizeMedium.h,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
