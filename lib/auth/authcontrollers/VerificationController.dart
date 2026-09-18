import 'dart:async';
import 'package:dating_app/auth/profile/profile.dart';
import 'package:dating_app/routes/app_routes.dart';
import 'package:get/get.dart';

class VerificationController extends GetxController {
  var otp = <String>[].obs;
  final int maxDigits = 4;

  var secondsRemaining = 42.obs;
  Timer? _timer;
  var isTimerRunning = true.obs;

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  void startTimer() {
    secondsRemaining.value = 42;
    isTimerRunning.value = true;
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining.value > 0) {
        secondsRemaining.value--;
      } else {
        isTimerRunning.value = false;
        _timer?.cancel();
      }
    });
  }

  void inputDigit(String digit) {
    if (otp.length < maxDigits) {
      otp.add(digit);

      if (otp.length == maxDigits) {
        verifyOtp();
      }
    }
  }

  void deleteDigit() {
    if (otp.isNotEmpty) {
      otp.removeLast();
    }
  }

  void verifyOtp() {
    String enteredOtp = otp.join();
    print("Entered OTP: $enteredOtp");
    if (enteredOtp.length == maxDigits) {
      Get.toNamed(AppRoutes.profile);
    }
  }

  void resendCode() {
    if (!isTimerRunning.value) {
      otp.clear();
      startTimer();
      Get.snackbar(
        "Success",
        "Verification code resent successfully!",
      );
    }
  }

  String get formattedTime {
    String seconds =
    secondsRemaining.value.toString().padLeft(2, '0');
    return "00:$seconds";
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
