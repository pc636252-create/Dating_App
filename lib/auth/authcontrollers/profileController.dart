import 'dart:io';

import 'package:dating_app/routes/app_routes.dart';
import 'package:dating_app/shared_pref/Shared_Prefrence.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';


class ProfileController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final SharedPrefService _prefService = Get.find<SharedPrefService>();
  final RxString selectedImagePath = ''.obs;

  final firstNameController = TextEditingController(text: 'David');
  final lastNameController = TextEditingController(text: 'Peterson');

  var selectedDateStr = 'Choose birthday date'.obs;
  DateTime? selectedDateTime;

  @override
  void onInit() {
    super.onInit();
    loadSavedImage();
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      selectedImagePath.value = image.path;

      await _prefService.saveImagePath(image.path);
    }
  }
 /// Loading image
  void loadSavedImage() {
    final String savedPath = _prefService.getImagePath();

    if (savedPath.isNotEmpty && File(savedPath).existsSync()) {
      selectedImagePath.value = savedPath;
    }
  }

  /// Remove saved image
  Future<void> removeImage() async {
    selectedImagePath.value = '';
    await _prefService.remover(
      SharedPrefService.keyProfileImage,
    );
  }

  Future<void> handleConfirm() async {
    if (formKey.currentState!.validate()) {

      if (selectedDateTime == null) {
        Get.snackbar(
          'Required',
          'Please select your birthday',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFFC35252),
          colorText: const Color(0xFFD5CECF),
        );
        return;
      }

      try {
        Get.dialog(
          const Center(child: CircularProgressIndicator(color: Color(0xFFE94057))),
          barrierDismissible: false,
        );
        // print("Valid Form! Ready to save data...");
        // print("Name: ${firstNameController.text} ${lastNameController.text}");
        // print("DOB: ${selectedDateStr.value}");
        // print("Image: ${selectedImagePath.value}");

        Get.toNamed(AppRoutes.iam);
        // Get.offAll(() => const HomeScreen());

      } catch (e) {
        Get.back();
        Get.snackbar('Error', 'Something went wrong: $e');
      }
    }
  }

  Future<void> chooseBirthday(BuildContext context) async {
    var activeDate = (selectedDateTime ?? DateTime(1995, 7, 11)).obs;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.7,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Obx(() {
            final current = activeDate.value;
            final totalDays = DateUtils.getDaysInMonth(current.year, current.month);
            final firstDayOffset = DateTime(current.year, current.month, 1).weekday % 7;

            return Column(
              children: [
                Container(
                  width: 50,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const Text(
                  'Birthday',
                  style: TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.chevron_left, color: Colors.black),
                      onPressed: () => activeDate.value = DateTime(current.year, current.month - 1),
                    ),
                    Column(
                      children: [
                        Text(
                          '${current.year}',
                          style: const TextStyle(
                            fontSize: 32,
                            color: Color(0xFFE94057),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          DateFormat('MMMM').format(current),
                          style: const TextStyle(fontSize: 14, color: Color(0xFFE94057)),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.chevron_right, color: Colors.black),
                      onPressed: () => activeDate.value = DateTime(current.year, current.month + 1),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                Expanded(
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: totalDays + firstDayOffset,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 7,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                    ),
                    itemBuilder: (context, index) {
                      if (index < firstDayOffset) return const SizedBox.shrink();
                      final day = index - firstDayOffset + 1;
                      final isSelected = current.day == day;

                      return GestureDetector(
                        onTap: () => activeDate.value = DateTime(current.year, current.month, day),
                        child: Container(
                          decoration: BoxDecoration(
                            color: isSelected ? const Color(0xFFE94057) : Colors.transparent,
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '$day',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE94057),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      elevation: 0,
                    ),
                    onPressed: () {
                      selectedDateTime = activeDate.value;
                      selectedDateStr.value = DateFormat('dd/MM/yyyy').format(activeDate.value);
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Save',
                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            );
          }),
        );
      },
    );
  }
/// Gender
  var selectedGender = ''.obs;
  void selectGender(String gender) {
    selectedGender.value = gender;
  }
  void processGenderSelection() {
    if (selectedGender.isEmpty) {
      Get.snackbar(
        'Selection Required',
        'Please select an option to continue.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }else{
       Get.toNamed(AppRoutes.interest);
    }
}

/// interest
  var selectedInterests = <String>[].obs;

  void toggleInterest(String interest) {
    if (selectedInterests.contains(interest)) {
      selectedInterests.remove(interest);
    } else {
      selectedInterests.add(interest);
    }
  }

  void processInterestsSelection() {
    if (selectedInterests.isEmpty) {
      Get.snackbar(
        'Selection Required',
        'Please select at least one interest to continue.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    } else {
      // print("Selected Interests: ${selectedInterests.toList()}");
      Get.toNamed(AppRoutes.searchfriends);
    }
  }

/// Friend contexts.
  var isLoading = false.obs;
  void requestContactAccess() async {
    try {
      isLoading.value = true;

      await Future.delayed(const Duration(seconds: 1));
      // print("Contact access granted/processed");
      Get.toNamed(AppRoutes.notification);
    } catch (e) {
      Get.snackbar("Error", "Could not access contacts: $e");
    } finally {
      isLoading.value = false;
    }
  }

///  Notifications
//   var isLoading = false.obs;

  void requestNotificationPermission() async {
    try {
      isLoading.value = true;
      await Future.delayed(const Duration(seconds: 1));
      // Get.snackbar(
      //   "Hello User ",
      //   "Work in progress......",
      //   snackPosition: SnackPosition.TOP,
      //   backgroundColor: Colors.green,
      //   colorText: Colors.white,
      // );
      Get.toNamed(AppRoutes.home);
      // Get.offNamed('/next_screen');

    } catch (e) {
      Get.snackbar("Error", "Could not request notifications permission: $e");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    super.onClose();
  }
}
