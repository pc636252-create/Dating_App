import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '../../controllers/discover_controller.dart';
import '../../utils/app_colors.dart';

class FiltersScreen extends StatelessWidget {
  const FiltersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DiscoverController>();

    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.12),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Container(
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new, size: 20, color: AppColors.textDark),
                    onPressed: () => Get.back(),
                  ),
                  const Text(
                    'Filters',
                    style: TextStyle(color: AppColors.textDark, fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  TextButton(
                    onPressed: () {
                      controller.interestedIn.value = 'Girls';
                      controller.maxDistance.value = 40;
                      controller.minAge.value = 20;
                      controller.maxAge.value = 28;
                    },
                    child: const Text('Clear', style: TextStyle(color: AppColors.primary, fontSize: 16)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Interested in', style: TextStyle( fontWeight: FontWeight.bold, fontSize: 18, color: AppColors.textDark)),
                    const SizedBox(height: 12),
                    Obx(() => Row(
                      children: ['Girls', 'Boys', 'Both'].map((option) {
                        final selected = controller.interestedIn.value == option;
                        return Expanded(
                          child: GestureDetector(
                            onTap: () => controller.interestedIn.value = option,
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: selected ? AppColors.primary : Colors.white,
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(color: selected ? AppColors.primary : Colors.grey.shade200),
                              ),
                              child: Text(
                                option,
                                style: TextStyle(
                                  color: selected ? Colors.white : AppColors.textDark.withOpacity(0.6),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    )),
                    const SizedBox(height: 32),

                    TextFormField(
                      controller: controller.location,
                      decoration: InputDecoration(
                        labelText: 'Location',
                        labelStyle: TextStyle(color: Colors.grey[400]),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.grey[200]!),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.grey[200]!),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Distance', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppColors.textDark)),
                        Obx(() => Text('${controller.maxDistance.value.round()}km', style: TextStyle(color: Colors.grey.shade600, fontSize: 16))),
                      ],
                    ),
                    Obx(() => Slider(
                      value: controller.maxDistance.value,
                      min: 1,
                      max: 100,
                      activeColor: AppColors.primary,
                      inactiveColor: Colors.grey.shade200,
                      onChanged: (v) => controller.maxDistance.value = v,
                    )),
                    const SizedBox(height: 32),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Age', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppColors.textDark)),
                        Obx(() => Text('${controller.minAge.value.round()}-${controller.maxAge.value.round()}', style: TextStyle(color: Colors.grey.shade600, fontSize: 16))),
                      ],
                    ),
                    Obx(() => RangeSlider(
                      values: RangeValues(controller.minAge.value, controller.maxAge.value),
                      min: 18,
                      max: 60,
                      activeColor: AppColors.primary,
                      inactiveColor: Colors.grey.shade200,
                      onChanged: (values) {
                        controller.minAge.value = values.start;
                        controller.maxAge.value = values.end;
                      },
                    )),
                    const SizedBox(height: 32),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        ),
                        onPressed: () {
                          controller.resetDeck();
                          Get.back();
                        },
                        child: const Text('Continue', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
