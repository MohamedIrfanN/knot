import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:knot/core/theme/app_colors.dart';
import 'package:knot/core/theme/app_text_styles.dart';
import 'package:knot/core/utils/constants.dart';
import 'package:knot/core/widgets/app_background.dart';
import 'package:knot/core/widgets/custom_text_field.dart';
import 'package:knot/core/widgets/gradient_button.dart';
import 'package:knot/core/widgets/gradient_text.dart';
import 'package:knot/features/auth/presentation/signin_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _bioController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: AppConstants.paddingHorizontal.w,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),

              // Back Button
              IconButton(
                icon: const Icon(Icons.arrow_back, color: AppColors.white),
                onPressed: () => Navigator.pop(context),
              ),
              SizedBox(height: 20.h),

              // Title
              GradientText(text: 'Create Account', style: AppTextStyles.h2),
              SizedBox(height: AppConstants.spacingXS.h),
              Text(
                'Join the decentralized social network',
                style: AppTextStyles.bodyMedium,
              ),
              SizedBox(height: AppConstants.spacingXXL.h),

              // Name Field
              CustomTextField(
                label: 'Name',
                controller: _nameController,
                hintText: 'Enter your name',
                maxLines: 1,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              SizedBox(height: AppConstants.spacingL.h),

              // Bio Field
              CustomTextField(
                label: 'Bio',
                controller: _bioController,
                hintText: 'Tell us about yourself...',
                maxLines: 4,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your bio';
                  }
                  return null;
                },
              ),
              SizedBox(height: AppConstants.spacingXXL.h),

              // Signup Button
              GradientButton(
                text: 'Sign Up',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // TODO: Implement signup logic
                  }
                },
              ),
              SizedBox(height: AppConstants.spacingL.h),

              // Login Link
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: AppTextStyles.bodySmall,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SigninScreen(),
                          ),
                        );
                      },
                      child: GradientText(
                        text: 'Login',
                        style: AppTextStyles.bodySmall.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: AppConstants.spacingXXL.h),
            ],
          ),
        ),
      ),
    );
  }
}
