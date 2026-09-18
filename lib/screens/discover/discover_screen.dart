
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '../../controllers/discover_controller.dart';
import '../../routes/app_routes.dart';
import '../../utils/app_colors.dart';
import '../../widgets/action_buttons_row.dart';
import '../../widgets/swipe_card.dart';
import '../../widgets/swipe_stamp.dart';
import '../filters/filters_screen.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DiscoverController controller = Get.put(DiscoverController());

    return Column(
      children: [
        _buildHeader(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
            child: Obx(() {
              if (controller.deck.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }
              return Stack(
                alignment: Alignment.center,
                children: [
                  if (controller.nextUser != null)
                    Transform.scale(
                      scale: 0.95,
                      child: SwipeCard(user: controller.nextUser!),
                    ),
                  GestureDetector(
                    onPanStart: controller.onPanStart,
                    onPanUpdate: controller.onPanUpdate,
                    onPanEnd: controller.onPanEnd,
                    child: Transform.translate(
                      offset: controller.dragOffset.value,
                      child: Transform.rotate(
                        angle: controller.angle.value,
                        child: Stack(
                          children: [
                            SwipeCard(
                              user: controller.topUser!,
                              onInfoTap: () => Get.toNamed(AppRoutes.userdetaile, arguments: controller.topUser),
                            ),
                            SwipeStamp(direction: controller.overlayDirection.value),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16, top: 4),
          child: ActionButtonsRow(
            onReject: controller.onRejectPressed,
            onLike: controller.onLikePressed,
            onStar: controller.onStarPressed,
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: Get.back,
            child: Container(
              padding: const EdgeInsets.all(12),
               decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 8)],
              ),
              child: const Icon(Icons.arrow_back, color: Colors.red, size: 20),
            ),
          ),
          Column(
            children: [
              Center(
                child: const Text(
                  'Discover',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.textDark),
                ),
              ),
              Text("Chicago,II",style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: AppColors.textDark),)
            ],
          ),
          GestureDetector(
            onTap: () {
              Get.bottomSheet(
                const FiltersScreen(),
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
              );
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 8)],
              ),
              child: const Icon(Icons.tune, color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
