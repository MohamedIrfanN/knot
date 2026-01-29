import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:knot/core/theme/app_colors.dart';
import 'package:knot/core/theme/app_text_styles.dart';
import 'package:knot/core/utils/constants.dart';
import 'package:knot/core/widgets/app_drawer.dart';
import 'package:knot/core/widgets/custom_app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: const CustomAppBar(),
      drawer: const AppDrawer(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black,
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(AppConstants.paddingHorizontal.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.feed_outlined,
                    size: 80.sp,
                    color: AppColors.white.withValues(alpha: 0.3),
                  ),
                  SizedBox(height: AppConstants.spacingL.h),
                  Text(
                    'Welcome to Knot!',
                    style: AppTextStyles.h2,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: AppConstants.spacingM.h),
                  Text(
                    'Your feed will appear here',
                    style: AppTextStyles.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
