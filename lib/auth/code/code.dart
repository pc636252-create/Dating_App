import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/app_colors.dart';
import '../authcontrollers/VerificationController.dart';

class VerificationPage extends GetView<VerificationController>{
  const VerificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final controller = Get.find<VerificationController>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColors.primary),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Obx(() => Text(
                  controller.formattedTime,
                  style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                )),
                const SizedBox(height: 10),
                const Text(
                  "Type the verification code\nwe've sent you",
                  style: TextStyle(fontSize: 16, color: Colors.black87, height: 1.5),
                ),
                const SizedBox(height: 40),
                Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(controller.maxDigits, (index) {
                    bool hasValue = controller.otp.length > index;
                    String text = hasValue ? controller.otp[index] : "0";
          
                    return Container(
                      width: 65,
                      height: 65,
                      decoration: BoxDecoration(
                        color: hasValue ? Colors.redAccent : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: hasValue ? Colors.redAccent : Colors.red.shade100,
                          width: 1,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        text,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: hasValue ? Colors.white : Colors.red.shade100,
                        ),
                      ),
                    );
                  }),
                )),
                // const SizedBox(height: 40),

                _buildKeypad(controller),
                const SizedBox(height: 30),
                Obx(() => TextButton(
                  onPressed: controller.isTimerRunning.value ? null : controller.resendCode,
                  child: Text(
                    "Send again",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: controller.isTimerRunning.value ? Colors.grey : Colors.red,
                    ),
                  ),
                )),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildKeypad(VerificationController controller) {
    List<List<String>> keys = [
      ['1', '2', '3'],
      ['4', '5', '6'],
      ['7', '8', '9'],
      ['', '0', 'delete']
    ];

    return Column(
      children: keys.map((row) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: row.map((key) {
              if (key == '') {
                return const SizedBox(width: 80);
              } else if (key == 'delete') {
                return InkWell(
                  onTap: controller.deleteDigit,
                  borderRadius: BorderRadius.circular(40),
                  child: const SizedBox(
                    width: 80,
                    height: 50,
                    child: Icon(Icons.backspace_outlined, color: Colors.black87),
                  ),
                );
              } else {
                return InkWell(
                  onTap: () => controller.inputDigit(key),
                  borderRadius: BorderRadius.circular(40),
                  child: SizedBox(
                    width: 80,
                    height: 50,
                    child: Center(
                      child: Text(
                        key,
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.normal, color: Colors.black87),
                      ),
                    ),
                  ),
                );
              }
            }).toList(),
          ),
        );
      }).toList(),
    );
  }
}
