import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:knot/core/theme/app_colors.dart';
import 'package:knot/core/theme/app_text_styles.dart';
import 'package:knot/core/utils/constants.dart';
import 'package:knot/core/widgets/gradient_text.dart';
import 'package:knot/features/profile/presentation/profile_screen.dart';
import 'package:knot/features/relays/presentation/relays_screen.dart';

/// Reusable app drawer/sidebar
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.backgroundDark,
      child: Container(
        decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Padding(
                padding: EdgeInsets.all(AppConstants.paddingHorizontal.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: AppConstants.spacingL.h),
                    // Profile Avatar
                    Container(
                      width: 80.w,
                      height: 80.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.gradientViolet,
                          width: 2.w,
                        ),
                        gradient: AppColors.primaryButtonGradient,
                      ),
                      child: Icon(
                        Icons.person,
                        size: 40.sp,
                        color: AppColors.white,
                      ),
                    ),
                    SizedBox(height: AppConstants.spacingM.h),
                    // User Name
                    GradientText(text: 'User Name', style: AppTextStyles.h3),
                    SizedBox(height: AppConstants.spacingXS.h),
                    // User Handle
                    Text('@username', style: AppTextStyles.bodySmall),
                    SizedBox(height: AppConstants.spacingL.h),
                    Divider(
                      color: AppColors.white.withValues(alpha: 0.1),
                      thickness: 1,
                    ),
                  ],
                ),
              ),

              // Menu Items
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    _buildMenuItem(
                      icon: Icons.person_outline,
                      title: 'Profile',
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProfileScreen(),
                          ),
                        );
                      },
                    ),
                    _buildMenuItem(
                      icon: Icons.cell_tower_rounded,
                      title: 'Relays',
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RelaysScreen(),
                          ),
                        );
                      },
                    ),
                    _buildMenuItem(
                      icon: Icons.settings_outlined,
                      title: 'Settings',
                      onTap: () {
                        // TODO: Navigate to settings
                        Navigator.pop(context);
                      },
                    ),
                    _buildMenuItem(
                      icon: Icons.info_outline,
                      title: 'About',
                      onTap: () {
                        // TODO: Navigate to about
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),

              // Logout Button
              Padding(
                padding: EdgeInsets.all(AppConstants.paddingHorizontal.w),
                child: Column(
                  children: [
                    Divider(
                      color: AppColors.white.withValues(alpha: 0.1),
                      thickness: 1,
                    ),
                    SizedBox(height: AppConstants.spacingS.h),
                    _buildMenuItem(
                      icon: Icons.logout,
                      title: 'Logout',
                      onTap: () {
                        // TODO: Implement logout
                        Navigator.pop(context);
                      },
                      isDestructive: true,
                    ),
                    SizedBox(height: AppConstants.spacingM.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isDestructive
            ? Colors.red.withValues(alpha: 0.8)
            : AppColors.white.withValues(alpha: 0.7),
        size: 24.sp,
      ),
      title: Text(
        title,
        style: AppTextStyles.bodyMedium.copyWith(
          color: isDestructive
              ? Colors.red.withValues(alpha: 0.8)
              : AppColors.white,
        ),
      ),
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(
        horizontal: AppConstants.paddingHorizontal.w,
        vertical: 4.h,
      ),
    );
  }
}
