// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../config/local_storage.dart';
import '../controller/auth_controller.dart';
import 'welcome/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AuthController authController = Get.put(AuthController());
  bool? isLogIn;

  @override
  void initState() {
    isLogIn = LocalStorage.sharedPreferences.getBool(LocalStorage.logIn);

    if (isLogIn == true) {
      authController.getProfileData(context: context);
    } else {
      Future.delayed(
        Duration(seconds: 4),
        () {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => WelcomeScreen(),
              ),
              (route) => false);
        },
      );
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset("assets/lottie/splash.json"),
      ),
    );
  }
}
