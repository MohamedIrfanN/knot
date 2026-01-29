import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:knot/core/providers/relay_provider.dart';
import 'package:knot/core/theme/app_colors.dart';
import 'package:knot/core/theme/app_text_styles.dart';
import 'package:knot/core/utils/constants.dart';

/// Relay card widget showing relay info and connection status
class RelayCard extends StatelessWidget {
  final Relay relay;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;
  final bool isEditMode;
  final AnimationController editModeAnimation;

  const RelayCard({
    super.key,
    required this.relay,
    this.onTap,
    this.onDelete,
    this.isEditMode = false,
    required this.editModeAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: AppConstants.spacingM.h),
      child: Stack(
        children: [
          // Main Card
          Container(
            decoration: BoxDecoration(
              color: AppColors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: AppColors.white.withValues(alpha: 0.1),
                width: 1,
              ),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: isEditMode ? null : onTap,
                borderRadius: BorderRadius.circular(12.r),
                child: Padding(
                  padding: EdgeInsets.all(AppConstants.spacingM.w),
                  child: Row(
                    children: [
                      // Relay Icon
                      Container(
                        width: 50.w,
                        height: 50.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: AppColors.primaryButtonGradient,
                          boxShadow: [
                            BoxShadow(
                              color: _getStatusColor().withValues(alpha: 0.3),
                              blurRadius: 8,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.cell_tower_rounded,
                          size: 24.sp,
                          color: AppColors.white,
                        ),
                      ),
                      SizedBox(width: AppConstants.spacingM.w),

                      // Relay Info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Relay Name
                            Text(
                              relay.name,
                              style: AppTextStyles.bodyLarge.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.white,
                              ),
                            ),
                            SizedBox(height: 4.h),

                            // Relay URL
                            Text(
                              relay.url,
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.white.withValues(alpha: 0.6),
                                fontFamily: 'monospace',
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: AppConstants.spacingS.w),

                      // Status Badge
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          color: _getStatusColor().withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(
                            color: _getStatusColor().withValues(alpha: 0.3),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 6.w,
                              height: 6.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _getStatusColor(),
                                boxShadow: [
                                  BoxShadow(
                                    color: _getStatusColor().withValues(
                                      alpha: 0.5,
                                    ),
                                    blurRadius: 4,
                                    spreadRadius: 1,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 6.w),
                            Text(
                              _getStatusText(),
                              style: AppTextStyles.bodySmall.copyWith(
                                color: _getStatusColor(),
                                fontWeight: FontWeight.w600,
                                fontSize: 11.sp,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Spacing for delete button
                      SizeTransition(
                        sizeFactor: editModeAnimation,
                        axis: Axis.horizontal,
                        child: SizedBox(width: 50.w),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Delete Button (Animated)
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: SlideTransition(
              position:
                  Tween<Offset>(
                    begin: const Offset(1.5, 0),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: editModeAnimation,
                      curve: Curves.easeOutBack,
                    ),
                  ),
              child: FadeTransition(
                opacity: editModeAnimation,
                child: ScaleTransition(
                  scale: editModeAnimation,
                  child: Container(
                    width: 50.w,
                    margin: EdgeInsets.only(right: AppConstants.spacingS.w),
                    child: Center(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: onDelete,
                          borderRadius: BorderRadius.circular(25.r),
                          child: Container(
                            width: 40.w,
                            height: 40.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.red.withValues(alpha: 0.2),
                              border: Border.all(
                                color: Colors.red.withValues(alpha: 0.5),
                                width: 1.5,
                              ),
                            ),
                            child: Icon(
                              Icons.delete_outline,
                              color: Colors.red,
                              size: 20.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor() {
    switch (relay.status) {
      case RelayStatus.online:
        return const Color(0xFF4CAF50); // Green
      case RelayStatus.connecting:
        return const Color(0xFFFFA726); // Orange
      case RelayStatus.disconnected:
        return const Color(0xFF9E9E9E); // Gray
      case RelayStatus.error:
        return const Color(0xFFF44336); // Red
    }
  }

  String _getStatusText() {
    switch (relay.status) {
      case RelayStatus.online:
        return 'Online';
      case RelayStatus.connecting:
        return 'Connecting';
      case RelayStatus.disconnected:
        return 'Offline';
      case RelayStatus.error:
        return 'Error';
    }
  }
}
