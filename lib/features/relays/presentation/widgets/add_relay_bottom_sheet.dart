import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:knot/core/theme/app_colors.dart';
import 'package:knot/core/theme/app_text_styles.dart';
import 'package:knot/core/utils/constants.dart';
import 'package:knot/core/widgets/custom_text_field.dart';
import 'package:knot/core/widgets/gradient_button.dart';
import 'package:knot/core/widgets/gradient_text.dart';

/// Bottom sheet for adding a new relay
class AddRelayBottomSheet extends StatefulWidget {
  final Function(String url) onAddRelay;

  const AddRelayBottomSheet({super.key, required this.onAddRelay});

  @override
  State<AddRelayBottomSheet> createState() => _AddRelayBottomSheetState();
}

class _AddRelayBottomSheetState extends State<AddRelayBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _urlController = TextEditingController();

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  void _handleAddRelay() {
    if (_formKey.currentState!.validate()) {
      widget.onAddRelay(_urlController.text.trim());
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: AppColors.backgroundGradient,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: AppConstants.spacingL.w,
          right: AppConstants.spacingL.w,
          top: AppConstants.spacingL.h,
          bottom:
              MediaQuery.of(context).viewInsets.bottom +
              AppConstants.spacingL.h,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GradientText(
                    text: 'Add Relay',
                    gradient: AppColors.primaryButtonGradient,
                    style: AppTextStyles.h2.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.close,
                      color: AppColors.white.withValues(alpha: 0.7),
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              SizedBox(height: AppConstants.spacingS.h),

              // Description
              Text(
                'Enter the WebSocket URL of the relay you want to connect to.',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.white.withValues(alpha: 0.6),
                ),
              ),
              SizedBox(height: AppConstants.spacingL.h),

              // URL Input
              CustomTextField(
                label: 'Relay URL',
                controller: _urlController,
                hintText: 'wss://relay.example.com',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a relay URL';
                  }
                  if (!value.startsWith('wss://') &&
                      !value.startsWith('ws://')) {
                    return 'URL must start with wss:// or ws://';
                  }
                  return null;
                },
              ),
              SizedBox(height: AppConstants.spacingXL.h),

              // Add Button
              GradientButton(text: 'Add Relay', onPressed: _handleAddRelay),
              SizedBox(height: AppConstants.spacingS.h),
            ],
          ),
        ),
      ),
    );
  }
}
