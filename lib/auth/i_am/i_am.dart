import 'package:dating_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../authcontrollers/profileController.dart';

class GenderScreen extends GetView<ProfileController> {
  const GenderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black54, size: 20),
          onPressed: () => Get.back(),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.toNamed(AppRoutes.interest);
            },
            child: const Text(
              'Skip',
              style: TextStyle(color: Color(0xFFE94057), fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              const Text(
                'I am a',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 80),

              Obx(() => Column(
                children: [
                  _buildGenderCard(
                    title: 'Woman',
                    isSelected: controller.selectedGender.value == 'Woman',
                    onTap: () => controller.selectGender('Woman'),
                  ),
                  const SizedBox(height: 20),
                  _buildGenderCard(
                    title: 'Man',
                    isSelected: controller.selectedGender.value == 'Man',
                    onTap: () => controller.selectGender('Man'),
                  ),
                  const SizedBox(height: 20),
                  _buildGenderCard(
                    title: 'Choose another',
                    isSelected: !['Woman', 'Man', ''].contains(controller.selectedGender.value),
                    isTrailingArrow: true,
                    onTap: () {
                      // Handle custom options if required
                      controller.selectGender('Other');
                    },
                  ),
                ],
              )),

              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE94057),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 0,
                  ),
                  onPressed: () => controller.processGenderSelection(),
                  child: const Text(
                    'Continue',
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGenderCard({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
    bool isTrailingArrow = false,
  }) {
    final baseColor = const Color(0xFFE94057);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: isSelected ? baseColor : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? Colors.transparent : Colors.grey.shade300,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
            if (isTrailingArrow)
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: isSelected ? Colors.white : Colors.grey.shade400,
              )
            else if (isSelected)
              const Icon(
                Icons.check,
                color: Colors.white,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }
}
