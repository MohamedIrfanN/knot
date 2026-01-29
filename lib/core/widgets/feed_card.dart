import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:knot/core/theme/app_colors.dart';
import 'package:knot/core/theme/app_text_styles.dart';
import 'package:knot/core/utils/constants.dart';
import 'package:knot/core/utils/time_formatter.dart';

/// Reusable feed card widget for displaying posts
class FeedCard extends StatefulWidget {
  final String displayName;
  final String content;
  final DateTime timestamp;
  final List<String>? imageUrls;
  final int commentCount;
  final int likeCount;
  final int zapCount;
  final VoidCallback? onComment;
  final VoidCallback? onLike;
  final VoidCallback? onZap;

  const FeedCard({
    super.key,
    required this.displayName,
    required this.content,
    required this.timestamp,
    this.imageUrls,
    this.commentCount = 0,
    this.likeCount = 0,
    this.zapCount = 0,
    this.onComment,
    this.onLike,
    this.onZap,
  });

  @override
  State<FeedCard> createState() => _FeedCardState();
}

class _FeedCardState extends State<FeedCard> {
  int _currentImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: AppConstants.spacingXS.h),
      decoration: BoxDecoration(color: AppColors.white.withValues(alpha: 0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header and Content (with padding)
          Padding(
            padding: EdgeInsets.all(AppConstants.spacingM.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header: Profile pic, name, time
                Row(
                  children: [
                    // Profile Picture
                    Container(
                      width: 40.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: AppColors.primaryButtonGradient,
                      ),
                      child: Icon(
                        Icons.person,
                        size: 20.sp,
                        color: AppColors.white,
                      ),
                    ),
                    SizedBox(width: AppConstants.spacingS.w),
                    // Name and time
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.displayName,
                            style: AppTextStyles.bodyMedium.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.white,
                            ),
                          ),
                          Text(
                            TimeFormatter.formatRelativeTime(widget.timestamp),
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.white.withValues(alpha: 0.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppConstants.spacingM.h),
                // Content
                Text(widget.content, style: AppTextStyles.bodyMedium),
              ],
            ),
          ),

          // Images (full width, no padding)
          if (widget.imageUrls != null && widget.imageUrls!.isNotEmpty) ...[
            SizedBox(height: AppConstants.spacingM.h),
            SizedBox(
              height: 300.h,
              child: Stack(
                children: [
                  // PageView for images
                  PageView.builder(
                    itemCount: widget.imageUrls!.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentImageIndex = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return Image.asset(
                        widget.imageUrls![index],
                        width: double.infinity,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                  // Page indicators
                  if (widget.imageUrls!.length > 1)
                    Positioned(
                      bottom: 12.h,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          widget.imageUrls!.length,
                          (index) => Container(
                            margin: EdgeInsets.symmetric(horizontal: 3.w),
                            width: 6.w,
                            height: 6.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _currentImageIndex == index
                                  ? AppColors.white
                                  : AppColors.white.withValues(alpha: 0.4),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],

          // Action buttons (with padding)
          Padding(
            padding: EdgeInsets.all(AppConstants.spacingM.w),
            child: Row(
              children: [
                _buildActionButton(
                  icon: Icons.chat_bubble_outline,
                  count: widget.commentCount,
                  onTap: widget.onComment,
                ),
                SizedBox(width: AppConstants.spacingXL.w),
                _buildActionButton(
                  icon: Icons.favorite_border,
                  count: widget.likeCount,
                  onTap: widget.onLike,
                ),
                SizedBox(width: AppConstants.spacingXL.w),
                _buildActionButton(
                  icon: Icons.bolt_outlined,
                  count: widget.zapCount,
                  onTap: widget.onZap,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required int count,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap ?? () {},
      borderRadius: BorderRadius.circular(20.r),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppConstants.spacingXS.w,
          vertical: AppConstants.spacingXS.h,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20.sp,
              color: AppColors.white.withValues(alpha: 0.6),
            ),
            if (count > 0) ...[
              SizedBox(width: 4.w),
              Text(
                count.toString(),
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.white.withValues(alpha: 0.6),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
