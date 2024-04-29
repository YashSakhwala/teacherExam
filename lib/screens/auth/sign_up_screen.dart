// ignore_for_file: prefer_const_constructors

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teacherexam/screens/bottom_bar/bottom_bar_screen.dart';
import '../../config/app_colors.dart';
import '../../config/app_image.dart';
import '../../config/app_style.dart';
import '../../controller/auth_controller.dart';
import '../../widgets/common_widgets/button_view.dart';
import '../../widgets/common_widgets/text_field_view.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  AuthController authController = Get.put(AuthController());

  final TextEditingController email = TextEditingController();
  final TextEditingController phoneNo = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController verifyPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: ListView(
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              "Create Account As Teacher",
              style: AppTextStyle.largeTextStyle.copyWith(
                fontSize: 26,
              ),
            ),
            Text(
              "Create an account to continue",
              style: AppTextStyle.smallTextStyle.copyWith(
                fontSize: 14,
                color: AppColors.blackThemeBoxColor,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Stack(
              children: [
                Container(
                  height: 82,
                  width: 82,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.primaryColor),
                    color: AppColors.whiteColor,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: Image.asset(
                        AppImages.fillProfile,
                        color: AppColors.redColor,
                        scale: 12,
                      ).image,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 58,
                  child: Container(
                    height: 23,
                    width: 23,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primaryColor,
                    ),
                    child: Icon(
                      Icons.add,
                      size: 17,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            TextFieldView(
              labelText: "Email",
              controller: email,
            ),
            SizedBox(
              height: 5,
            ),
            TextFieldView(
              labelText: "Phone No",
              controller: phoneNo,
            ),
            SizedBox(
              height: 5,
            ),
            Obx(
              () => TextFieldView(
                labelText: "Password",
                controller: password,
                obscureText: authController.isSignUpPasswordShow.value,
                suffixIcon: GestureDetector(
                  onTap: () {
                    authController.isSignUpPasswordShow.value =
                        !authController.isSignUpPasswordShow.value;
                  },
                  child: Image.asset(
                    authController.isSignUpPasswordShow.value == true
                        ? AppImages.openEye
                        : AppImages.closeEye,
                    scale: 20,
                    color: AppColors.greyColor,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Obx(
              () => TextFieldView(
                labelText: "Verify Password",
                controller: verifyPassword,
                obscureText: authController.isVerifyPasswordShow.value,
                suffixIcon: GestureDetector(
                  onTap: () {
                    authController.isVerifyPasswordShow.value =
                        !authController.isVerifyPasswordShow.value;
                  },
                  child: Image.asset(
                    authController.isVerifyPasswordShow.value == true
                        ? AppImages.openEye
                        : AppImages.closeEye,
                    scale: 20,
                    color: AppColors.greyColor,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "You can make changes in the profile",
              style: AppTextStyle.smallTextStyle.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryColor,
              ),
            ),
            SizedBox(
              height: 80,
            ),
            ButtonView(
              title: "Continue",
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => BottomBarScreen(),
                ));
              },
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 10,
            ),
            Center(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Already have an account? ",
                      style: AppTextStyle.smallTextStyle.copyWith(
                        fontSize: 13,
                        color: AppColors.greyColor,
                      ),
                    ),
                    TextSpan(
                      text: "Sign In",
                      style: AppTextStyle.smallTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryColor,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()),
                          );
                        },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
