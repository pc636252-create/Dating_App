import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../authcontrollers/phone_numberController.dart';

class PhoneNumber extends StatelessWidget {
  const PhoneNumber({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PhoneNumberController controller = Get.put(PhoneNumberController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'My mobile',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Please enter your valid phone number. We will send you a 4-digit code to verify your account.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 36),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade200),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.04),
                      spreadRadius: 1,
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: IntlPhoneField(
                  controller: controller.phoneTextController,
                  decoration: const InputDecoration(
                    hintText: '331 623 8413',
                    hintStyle: TextStyle(color: Colors.black26),
                    border: InputBorder.none,
                    counterText: '',
                    contentPadding: EdgeInsets.symmetric(vertical: 16),
                  ),
                  initialCountryCode: 'US',
                  dropdownIconPosition: IconPosition.trailing,
                  dropdownIcon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                  flagsButtonMargin: const EdgeInsets.symmetric(horizontal: 12),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    letterSpacing: 0.5,
                  ),
                  onChanged: (phone) {
                    try {
                      controller.updateValidationStatus(
                          phone.isValidNumber(),
                          phone.completeNumber
                      );
                    } catch (_) {
                      controller.updateValidationStatus(false, '');
                    }
                  },
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: Obx(() {
                  bool canClick = controller.isValidNumber.value && !controller.isLoading.value;
                  return ElevatedButton(
                    onPressed: canClick ? () => controller.handleContinue() : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFE94057),
                      disabledBackgroundColor:Color(0xFFE94057).withOpacity(0.5),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: controller.isLoading.value
                        ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5),
                    )
                        : const Text(
                      'Continue',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
