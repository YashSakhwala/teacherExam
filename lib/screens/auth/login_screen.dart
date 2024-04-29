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
import 'sign_up_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthController authController = Get.put(AuthController());

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: ListView(
          children: [
            SizedBox(
              height: 90,
            ),
            Text(
              "Welcome Back Teacher",
              style: AppTextStyle.largeTextStyle.copyWith(
                fontSize: 30,
              ),
            ),
            Text(
              "Sign in to continue",
              style: AppTextStyle.smallTextStyle.copyWith(
                color: AppColors.blackThemeBoxColor,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            TextFieldView(
              labelText: "Email",
              controller: email,
            ),
            SizedBox(
              height: 5,
            ),
            Obx(
              () => TextFieldView(
                labelText: "Password",
                controller: password,
                obscureText: authController.isLoginPasswordShow.value,
                suffixIcon: GestureDetector(
                  onTap: () {
                    authController.isLoginPasswordShow.value =
                        !authController.isLoginPasswordShow.value;
                  },
                  child: Image.asset(
                    authController.isLoginPasswordShow.value == true
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
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                "Forgot password?",
                style: AppTextStyle.smallTextStyle.copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            SizedBox(
              height: 80,
            ),
            ButtonView(
              title: "Sign in",
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => BottomBarScreen(),
                ));
              },
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 4,
            ),
            Center(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Don't have an account? ",
                      style: AppTextStyle.smallTextStyle.copyWith(
                        fontSize: 13,
                        color: AppColors.greyColor,
                      ),
                    ),
                    TextSpan(
                      text: "Create Now",
                      style: AppTextStyle.smallTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryColor,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => SignUpScreen()),
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
