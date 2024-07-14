import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../view/verify_screen.dart';
import '../view/video_screen.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController otpController = TextEditingController();
  final TextEditingController countryController =
      TextEditingController(text: "+91");
  final TextEditingController phoneController = TextEditingController();
  RxString verificationId = ''.obs;
  RxBool isLoading = false.obs; // Add a loading state

  Future<void> sendOTP() async {
    final phoneNumber =
        '${countryController.text}${phoneController.text.trim()}';
    isLoading.value = true; // Start loading
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 120),
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
          Get.snackbar('Success', 'Successfully logged in!');
          isLoading.value = false; // Stop loading
        },
        verificationFailed: (FirebaseAuthException e) {
          Get.snackbar('Error', 'Verification failed: ${e.message}');
          isLoading.value = false; // Stop loading
        },
        codeSent: (String verificationId, int? resendToken) {
          this.verificationId.value = verificationId;
          Get.snackbar('Info', 'OTP sent to $phoneNumber');
          Get.to(() => VerifyScreen());

          isLoading.value = false; // Stop loading
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          this.verificationId.value = verificationId;
          isLoading.value = false; // Stop loading
        },
      );
    } catch (e) {
      Get.snackbar('Error', 'Failed to send OTP: $e');
      isLoading.value = false; // Stop loading
    }
  }

  Future<void> verifyOTP() async {
    final otp = otpController.text.trim();
    final credential = PhoneAuthProvider.credential(
        verificationId: verificationId.value, smsCode: otp);
    isLoading.value = true; // Start loading
    try {
      await _auth.signInWithCredential(credential);
      Get.snackbar('Success', 'Successfully logged in!');
      Get.offAll(() => VideoScreen());
      isLoading.value = false; // Stop loading
      otpController.clear();
      phoneController.clear();
    } catch (e) {
      Get.snackbar('Error', 'Failed to verify OTP: $e');
      isLoading.value = false; // Stop loading
    }
  }
}

class OTPController extends GetxController {
  // List of TextEditingControllers for OTP fields
  var controllers = List.generate(6, (_) => TextEditingController()).obs;
  var focusNodes = List.generate(6, (_) => FocusNode()).obs;

  // Resend OTP functionality
  var isButtonDisabled = false.obs;
  var countdown = 60.obs;
  Timer? timer;

  @override
  void onInit() {
    timer?.cancel();
    super.onInit();
    // Initialize the controller if needed
  }

  @override
  void onClose() {
    // Dispose controllers and focus nodes
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    timer?.cancel();
    super.onClose();
  }

  void onOTPChanged(String value, int index) {
    if (value.isNotEmpty) {
      if (index < 5) {
        FocusScope.of(Get.context!).requestFocus(focusNodes[index + 1]);
      } else {
        FocusScope.of(Get.context!)
            .unfocus(); // Close keyboard when last field is filled
      }
    } else if (index > 0) {
      FocusScope.of(Get.context!).requestFocus(focusNodes[index - 1]);
    }
  }

  RxString verificationId = ''.obs;
  RxBool isLoading = false.obs;

  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> reSendOTP() async {
    AuthController authController = Get.put(AuthController());
    final phoneNumber =
        '${authController.countryController.text}${authController.phoneController.text.trim()}';
    isLoading.value = true; // Start loading
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 120),
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential);
          Get.snackbar('Success', 'Successfully logged in!');
          isLoading.value = false; // Stop loading
        },
        verificationFailed: (FirebaseAuthException e) {
          Get.snackbar('Error', 'Verification failed: ${e.message}');
          isLoading.value = false; // Stop loading
        },
        codeSent: (String verificationId, int? resendToken) {
          this.verificationId.value = verificationId;
          Get.snackbar('Info', 'OTP sent to $phoneNumber');
          Get.to(() => VerifyScreen());
          isLoading.value = false; // Stop loading
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          this.verificationId.value = verificationId;
          isLoading.value = false; // Stop loading
        },
      );
    } catch (e) {
      Get.snackbar('Error', 'Failed to send OTP: $e');
      isLoading.value = false; // Stop loading
    }
  }
}
