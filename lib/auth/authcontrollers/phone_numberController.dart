import 'package:dating_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhoneNumberController extends GetxController {
  var completePhoneNumber = ''.obs;
  var isValidNumber = false.obs;
  var isLoading = false.obs;

  final phoneTextController = TextEditingController();

  void updateValidationStatus(bool isValid, String completeNumber) {
    isValidNumber.value = isValid;
    completePhoneNumber.value = completeNumber;
  }

  void handleContinue() {
    if (!isValidNumber.value) {
      Get.snackbar(
        'Invalid Number',
        'Please enter a valid phone number for the selected country.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
      );
      return;
    }

    isLoading.value = true;
    Future.delayed(const Duration(seconds: 2), () {
      isLoading.value = false;
      Get.toNamed(AppRoutes.code);
    });
  }

  @override
  void onClose() {
    phoneTextController.dispose();
    super.onClose();
  }
}
