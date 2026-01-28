import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:knot/core/theme/app_text_styles.dart';
import 'package:knot/core/utils/constants.dart';
import 'package:knot/core/widgets/app_background.dart';
import 'package:knot/core/widgets/app_outlined_button.dart';
import 'package:knot/core/widgets/glowing_logo.dart';
import 'package:knot/core/widgets/gradient_button.dart';
import 'package:knot/core/widgets/gradient_text.dart';
import 'package:knot/features/auth/presentation/signin_screen.dart';
import 'package:knot/features/auth/presentation/signup_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppConstants.paddingHorizontal.w,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),

            // Glowing Logo
            const GlowingLogo(),
            SizedBox(height: AppConstants.spacingXXL.h),

            // Welcome Text with Gradient
            GradientText(
              text: 'Welcome to Knot',
              style: AppTextStyles.h1,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppConstants.spacingM.h),

            // Subtitle
            Text(
              'The social network you control',
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium,
            ),
            const Spacer(),

            // Buttons
            GradientButton(
              text: 'Create Account',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignupScreen()),
                );
              },
            ),
            SizedBox(height: AppConstants.spacingM.h),
            AppOutlinedButton(
              text: 'Sign In',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SigninScreen()),
                );
              },
            ),
            SizedBox(height: AppConstants.spacingXXL.h),
          ],
        ),
      ),
    );
  }
}
