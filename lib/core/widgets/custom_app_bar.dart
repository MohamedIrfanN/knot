import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:knot/core/theme/app_colors.dart';
import 'package:knot/core/theme/app_text_styles.dart';
import 'package:knot/core/widgets/gradient_text.dart';

/// Reusable custom app bar for the app
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onProfileTap;
  final bool showProfileIcon;

  const CustomAppBar({
    super.key,
    this.onProfileTap,
    this.showProfileIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.backgroundDark,
      elevation: 0,
      centerTitle: true,
      leading: showProfileIcon
          ? IconButton(
              icon: Icon(
                Icons.person_outline,
                color: AppColors.white,
                size: 24.sp,
              ),
              onPressed:
                  onProfileTap ?? () => Scaffold.of(context).openDrawer(),
            )
          : null,
      title: GradientText(text: 'Knot', style: AppTextStyles.h3),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.h);
}
