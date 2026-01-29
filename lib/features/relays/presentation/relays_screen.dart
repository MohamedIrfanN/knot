import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:knot/core/providers/relay_provider.dart';
import 'package:knot/core/theme/app_colors.dart';
import 'package:knot/core/theme/app_text_styles.dart';
import 'package:knot/core/utils/constants.dart';
import 'package:knot/core/widgets/gradient_text.dart';
import 'package:knot/features/relays/presentation/widgets/add_relay_bottom_sheet.dart';
import 'package:knot/features/relays/presentation/widgets/relay_card.dart';

/// Relays management screen
class RelaysScreen extends ConsumerStatefulWidget {
  const RelaysScreen({super.key});

  @override
  ConsumerState<RelaysScreen> createState() => _RelaysScreenState();
}

class _RelaysScreenState extends ConsumerState<RelaysScreen>
    with SingleTickerProviderStateMixin {
  bool _isEditMode = false;
  late AnimationController _editModeController;

  @override
  void initState() {
    super.initState();
    _editModeController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _editModeController.dispose();
    super.dispose();
  }

  void _toggleEditMode() {
    setState(() {
      _isEditMode = !_isEditMode;
      if (_isEditMode) {
        _editModeController.forward();
      } else {
        _editModeController.reverse();
      }
    });
  }

  void _deleteRelay(String id) {
    ref.read(relaysProvider.notifier).removeRelay(id);
  }

  void _showAddRelaySheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AddRelayBottomSheet(
        onAddRelay: (url) {
          // Extract relay name from URL
          String name = _extractRelayName(url);

          // Create new relay
          final newRelay = Relay(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            name: name,
            url: url,
            status: RelayStatus.connecting,
          );

          // Add to provider
          ref.read(relaysProvider.notifier).addRelay(newRelay);

          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Relay "$name" added successfully'),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
      ),
    );
  }

  String _extractRelayName(String url) {
    // Remove protocol
    String name = url.replaceAll('wss://', '').replaceAll('ws://', '');

    // Remove path
    if (name.contains('/')) {
      name = name.split('/')[0];
    }

    // Remove 'relay.' prefix if exists
    if (name.startsWith('relay.')) {
      name = name.substring(6);
    }

    // Capitalize first letter
    if (name.isNotEmpty) {
      name = name[0].toUpperCase() + name.substring(1);
    }

    return name;
  }

  @override
  Widget build(BuildContext context) {
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
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) {
              return RotationTransition(
                turns: animation,
                child: FadeTransition(opacity: animation, child: child),
              );
            },
            child: IconButton(
              key: ValueKey(_isEditMode),
              icon: Icon(
                _isEditMode ? Icons.check : Icons.edit_outlined,
                color: _isEditMode ? Colors.green : AppColors.white,
              ),
              onPressed: _toggleEditMode,
            ),
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
                AnimatedOpacity(
                  opacity: _isEditMode ? 0.5 : 1.0,
                  duration: const Duration(milliseconds: 300),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryButtonGradient,
                      borderRadius: BorderRadius.circular(20.r),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.gradientViolet.withValues(
                            alpha: 0.3,
                          ),
                          blurRadius: 8,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: _isEditMode ? null : _showAddRelaySheet,
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
                return AnimatedSize(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  child: RelayCard(
                    key: ValueKey(relay.id),
                    relay: relay,
                    isEditMode: _isEditMode,
                    editModeAnimation: _editModeController,
                    onTap: () {
                      // TODO: Show relay details
                    },
                    onDelete: () => _deleteRelay(relay.id),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
