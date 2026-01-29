import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:knot/core/providers/relay_provider.dart';
import 'package:knot/core/theme/app_colors.dart';
import 'package:knot/core/theme/app_text_styles.dart';
import 'package:knot/core/utils/constants.dart';
import 'package:knot/core/widgets/gradient_text.dart';
import 'package:knot/features/relays/presentation/widgets/relay_card.dart';

/// Relays management screen
class RelaysScreen extends ConsumerWidget {
  const RelaysScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final relays = ref.watch(relaysProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundDark,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const GradientText(
          text: 'Knot',
          gradient: AppColors.primaryButtonGradient,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined, color: AppColors.white),
            onPressed: () {
              // TODO: Implement edit mode
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Section Header
          Padding(
            padding: EdgeInsets.all(AppConstants.spacingL.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Title
                Text(
                  'My Relays',
                  style: AppTextStyles.h2.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),

                // Add Button
                Container(
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryButtonGradient,
                    borderRadius: BorderRadius.circular(20.r),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.gradientViolet.withValues(alpha: 0.3),
                        blurRadius: 8,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        // TODO: Implement add relay
                      },
                      borderRadius: BorderRadius.circular(20.r),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 8.h,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.add,
                              size: 18.sp,
                              color: AppColors.white,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              'Add Relay',
                              style: AppTextStyles.bodyMedium.copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppColors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Relay List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(
                horizontal: AppConstants.spacingL.w,
              ),
              itemCount: relays.length,
              itemBuilder: (context, index) {
                final relay = relays[index];
                return RelayCard(
                  relay: relay,
                  onTap: () {
                    // TODO: Show relay details
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
