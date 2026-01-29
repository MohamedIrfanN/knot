import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:knot/core/providers/auth_provider.dart';
import 'package:knot/core/theme/app_colors.dart';
import 'package:knot/core/theme/app_text_styles.dart';
import 'package:knot/core/utils/constants.dart';
import 'package:knot/core/widgets/app_background.dart';
import 'package:knot/core/widgets/custom_text_field.dart';
import 'package:knot/core/widgets/glowing_logo.dart';
import 'package:knot/core/widgets/gradient_button.dart';
import 'package:knot/core/widgets/gradient_text.dart';
import 'package:knot/features/auth/presentation/signup_screen.dart';
import 'package:knot/features/home/presentation/home_screen.dart';

class SigninScreen extends ConsumerStatefulWidget {
  const SigninScreen({super.key});

  @override
  ConsumerState<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends ConsumerState<SigninScreen> {
  final _formKey = GlobalKey<FormState>();
  final _privateKeyController = TextEditingController();
  bool _obscureText = true;

  @override
  void dispose() {
    _privateKeyController.dispose();
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
              SizedBox(height: AppConstants.spacingXXL.h),

              // Logo
              Center(
                child: GlowingLogo(
                  size: AppConstants.logoSizeSmall,
                  glowBlur: AppConstants.glowBlurSmall,
                  glowSpread: AppConstants.glowSpreadSmall,
                ),
              ),
              SizedBox(height: AppConstants.spacingXXL.h),

              // Title
              Center(
                child: GradientText(
                  text: 'Welcome Back',
                  style: AppTextStyles.h2,
                ),
              ),
              SizedBox(height: AppConstants.spacingXS.h),
              Center(
                child: Text(
                  'Sign in with your private key',
                  style: AppTextStyles.bodyMedium,
                ),
              ),
              SizedBox(height: AppConstants.spacingXXL.h),

              // Private Key Field
              CustomTextField(
                label: 'Private Key',
                controller: _privateKeyController,
                hintText: 'nsec1...',
                obscureText: _obscureText,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: AppColors.white.withValues(
                      alpha: AppConstants.opacityHigh,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your private key';
                  }
                  if (!value.startsWith('nsec1')) {
                    return 'Private key must start with nsec1';
                  }
                  return null;
                },
              ),
              SizedBox(height: AppConstants.spacingXXL.h),

              // Sign In Button
              GradientButton(
                text: 'Sign In',
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await ref
                        .read(authProvider.notifier)
                        .signIn(privateKey: _privateKeyController.text);
                    if (mounted) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      );
                    }
                  }
                },
              ),
              SizedBox(height: AppConstants.spacingL.h),

              // Create Account Link
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('New to nostr? ', style: AppTextStyles.bodySmall),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignupScreen(),
                          ),
                        );
                      },
                      child: GradientText(
                        text: 'Create account',
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
