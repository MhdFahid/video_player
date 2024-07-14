import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_timer_button/otp_timer_button.dart';
import 'package:pinput/pinput.dart';

import '../controller/auth_controller.dart';
import '../widgets/pin_text_field.dart';
import '../widgets/square_button.dart';

class VerifyScreen extends StatelessWidget {
  VerifyScreen({super.key});
  final AuthController authController = Get.put(AuthController());
  final OTPController otpController = Get.put(OTPController());
  @override
  Widget build(BuildContext context) {
    final OtpTimerButtonController otpTimerButtonController =
        OtpTimerButtonController();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Phone Verification",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Enter the Verification Code Sent to Your Phone to Proceed with Registration or Login",
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              PinTextField(controller: authController.otpController),
              const SizedBox(
                height: 20,
              ),
              Obx(
                () => SquareButton(
                  title: 'Verify Phone Number',
                  onTap: authController.verifyOTP,
                  loading: authController.isLoading.value,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                      authController.otpController.clear();
                    },
                    child: const Text(
                      "Edit Phone Number ?",
                    ),
                  ),
                  Spacer(),
                  OtpTimerButton(
                    buttonType: ButtonType.text_button,
                    onPressed: () {
                      otpController.reSendOTP();
                      otpTimerButtonController.startTimer();
                    },
                    controller: otpTimerButtonController,
                    text: Text('Resend OTP'),
                    duration: 120,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
