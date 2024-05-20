// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, library_private_types_in_public_api

import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import '../../config/app_style.dart';
import '../../controller/auth_controller.dart';
import '../../widgets/common_widgets/button_view.dart';
import '../../widgets/common_widgets/toast_view.dart';

class OTPVerificationScreen extends StatefulWidget {
  final String name;
  final String email;
  final String phoneNo;
  final String password;
  final EmailOTP myAuth;

  const OTPVerificationScreen({
    super.key,
    required this.name,
    required this.email,
    required this.phoneNo,
    required this.password,
    required this.myAuth,
  });

  @override
  _OTPVerificationScreenState createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  AuthController authController = Get.put(AuthController());

  final TextEditingController pinPutController = TextEditingController();
  final FocusNode pinPutFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Verification",
          style: AppTextStyle.regularTextStyle.copyWith(fontSize: 20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                "Please enter the 6-digit OTP sent to your registered email address",
                style: AppTextStyle.regularTextStyle,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Pinput(
                controller: pinPutController,
                focusNode: pinPutFocusNode,
                length: 6,
                autofocus: true,
                closeKeyboardWhenCompleted: true,
              ),
            ),
            SizedBox(
              height: 100,
            ),
            ButtonView(
              title: "Continue",
              onTap: () async {
                var inputOTP = pinPutController.text;

                var temp = await widget.myAuth.verifyOTP(
                  otp: inputOTP,
                );

                if (temp == true) {
                  authController.signUp(
                    name: widget.name,
                    email: widget.email,
                    password: widget.password,
                    phoneNo: widget.phoneNo,
                    context: context,
                  );
                } else {
                  toastView(msg: "Please enter valid OTP");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
