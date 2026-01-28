import 'package:flutter/material.dart';
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
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF000000), // Deep black background
          gradient: RadialGradient(
            center: Alignment.center, // Center gradient for splash
            radius: 1.2,
            colors: [
              Color(0xFF1A1A2E), // Deep purple/blue hint
              Color(0xFF000000), // Black outer
            ],
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
                      // Glowing Logo
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.withValues(
                                alpha: 0.2 + (_controller.value * 0.2),
                              ), // Pulse glow intensity
                              blurRadius:
                                  80 + (_controller.value * 20), // Pulse blur
                              spreadRadius:
                                  10 + (_controller.value * 10), // Pulse spread
                            ),
                          ],
                        ),
                        child: Image.asset(
                          'assets/images/knot_glow.png',
                          width: 160,
                          height: 160,
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
