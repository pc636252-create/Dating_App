import 'package:dating_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../authcontrollers/profileController.dart';

class InterestsScreen extends GetView<ProfileController> {
  const InterestsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 8.0),
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.zero,
              side: BorderSide(color: Colors.grey.shade200),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            onPressed: () => Get.back(),
            child: const Icon(Icons.arrow_back_ios_new, color: Color(0xFFE94057), size: 16),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.toNamed(AppRoutes.searchfriends);
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
              const SizedBox(height: 30),
              const Text(
                'Your interests',
                style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const SizedBox(height: 12),
              Text(
                'Select a few of your interests and let everyone know what you\'re passionate about.',
                style: TextStyle(fontSize: 14, color: Colors.grey.shade600, height: 1.4),
              ),
              const SizedBox(height: 32),
              Expanded(
                child: SingleChildScrollView(
                  child: Obx(() => Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            _buildInterestChip('Photography', Icons.camera_alt_outlined, controller),
                            _buildInterestChip('Karaoke', Icons.mic_none_outlined, controller),
                            _buildInterestChip('Cooking', Icons.cookie_outlined, controller),
                            _buildInterestChip('Run', Icons.directions_run_outlined, controller),
                            _buildInterestChip('Art', Icons.palette_outlined, controller),
                            _buildInterestChip('Extreme', Icons.paragliding_outlined, controller),
                            _buildInterestChip('Drink', Icons.wine_bar, controller),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Right Column
                      Expanded(
                        child: Column(
                          children: [
                            _buildInterestChip('Shopping', Icons.shopping_bag_outlined, controller),
                            _buildInterestChip('Yoga', Icons.spa_outlined, controller),
                            _buildInterestChip('Tennis', Icons.sports_tennis_outlined, controller),
                            _buildInterestChip('Swimming', Icons.pool_outlined, controller),
                            _buildInterestChip('Traveling', Icons.landscape_outlined, controller),
                            _buildInterestChip('Music', Icons.music_note_outlined, controller),
                            _buildInterestChip('Video games', Icons.videogame_asset_outlined, controller),
                          ],
                        ),
                      ),
                    ],
                  )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE94057),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      elevation: 0,
                    ),
                    onPressed: () => controller.processInterestsSelection(),
                    child: const Text(
                      'Continue',
                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInterestChip(String label, IconData icon, ProfileController controller) {
    final bool isSelected = controller.selectedInterests.contains(label);
    final themeColor = const Color(0xFFE94057);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: GestureDetector(
        onTap: () => controller.toggleInterest(label),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: isSelected ? themeColor : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected ? Colors.transparent : Colors.grey.shade200,
            ),
            boxShadow: isSelected
                ? [BoxShadow(color: themeColor.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 4))]
                : null,
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: 20,
                color: isSelected ? Colors.white : themeColor,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  label,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
