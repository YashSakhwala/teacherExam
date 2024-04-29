import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyle {
  static TextStyle largeTextStyle = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    fontFamily: "popins-bold",
    color: AppColors.blackColor,
    letterSpacing: 0,
  );

  static TextStyle regularTextStyle = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    fontFamily: "popins-regular",
    color: AppColors.blackColor,
    letterSpacing: 0,
  );

  static TextStyle smallTextStyle = const TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.normal,
    fontFamily: "popins-regular",
    color: AppColors.blackColor,
    letterSpacing: 0,
  );
}
