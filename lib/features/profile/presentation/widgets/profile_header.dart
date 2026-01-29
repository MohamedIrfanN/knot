import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:knot/core/theme/app_colors.dart';
import 'package:knot/core/theme/app_text_styles.dart';
import 'package:knot/core/utils/constants.dart';

/// Profile header widget with profile picture, name, public key, and bio
class ProfileHeader extends StatefulWidget {
  final String displayName;
  final String publicKey;
  final String? bio;

  const ProfileHeader({
    super.key,
    required this.displayName,
    required this.publicKey,
    this.bio,
  });

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  bool _isCopied = false;

  Future<void> _copyToClipboard() async {
    await Clipboard.setData(ClipboardData(text: widget.publicKey));
    setState(() {
      _isCopied = true;
    });

    // Reset after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isCopied = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppConstants.spacingL.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Picture and Name in Row
          Row(
            children: [
              // Profile Picture (smaller)
              Container(
                width: 70.w,
                height: 70.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: AppColors.primaryButtonGradient,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.gradientViolet.withValues(alpha: 0.3),
                      blurRadius: 12,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Icon(Icons.person, size: 35.sp, color: AppColors.white),
              ),
              SizedBox(width: AppConstants.spacingM.w),

              // Display Name
              Expanded(
                child: Text(
                  widget.displayName,
                  style: AppTextStyles.h3.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: AppConstants.spacingM.h),

          // Public Key (left-aligned with copy icon)
          GestureDetector(
            onTap: _copyToClipboard,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppConstants.spacingS.w,
                vertical: AppConstants.spacingXS.h,
              ),
              decoration: BoxDecoration(
                color: AppColors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(
                  color: AppColors.white.withValues(alpha: 0.1),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.key,
                    size: 14.sp,
                    color: AppColors.white.withValues(alpha: 0.5),
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    _truncatePublicKey(widget.publicKey),
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.white.withValues(alpha: 0.6),
                      fontFamily: 'monospace',
                    ),
                  ),
                  SizedBox(width: 8.w),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (child, animation) {
                      return ScaleTransition(scale: animation, child: child);
                    },
                    child: Icon(
                      _isCopied ? Icons.check_circle : Icons.copy,
                      key: ValueKey(_isCopied),
                      size: 14.sp,
                      color: _isCopied
                          ? Colors.green
                          : AppColors.white.withValues(alpha: 0.5),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bio (if available, left-aligned)
          if (widget.bio != null && widget.bio!.isNotEmpty) ...[
            SizedBox(height: AppConstants.spacingM.h),
            Text(
              widget.bio!,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.white.withValues(alpha: 0.8),
                height: 1.4,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ],
      ),
    );
  }

  String _truncatePublicKey(String key) {
    if (key.length <= 16) return key;
    return '${key.substring(0, 8)}...${key.substring(key.length - 8)}';
  }
}
