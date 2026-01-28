import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:knot/core/theme/app_theme.dart';
import 'package:knot/features/splash/presentation/splash_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), // iPhone 11 Pro size as base
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Knot',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.darkTheme,
          home: child,
        );
      },
      child: const SplashScreen(),
    );
  }
}
