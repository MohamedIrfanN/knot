import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:knot/core/theme/app_colors.dart';
import 'package:knot/core/theme/app_text_styles.dart';
import 'package:knot/core/utils/constants.dart';

/// Stats row widget showing following, followers, and relays count
class StatsRow extends StatelessWidget {
  final int followingCount;
  final int followersCount;
  final int relaysCount;

  const StatsRow({
    super.key,
    required this.followingCount,
    required this.followersCount,
    required this.relaysCount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppConstants.spacingL.w,
            vertical: AppConstants.spacingM.h,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem(followingCount, 'Following'),
              _buildStatItem(followersCount, 'Followers'),
              _buildStatItem(relaysCount, 'Relays'),
            ],
          ),
        ),
        // Horizontal divider
        Container(height: 1.h, color: AppColors.white.withValues(alpha: 0.1)),
      ],
    );
  }

  Widget _buildStatItem(int count, String label) {
    return Column(
      children: [
        Text(
          count.toString(),
          style: AppTextStyles.bodyLarge.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.white,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.white.withValues(alpha: 0.6),
          ),
        ),
      ],
    );
  }
}
