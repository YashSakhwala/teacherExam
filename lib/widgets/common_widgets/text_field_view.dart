// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../../config/app_colors.dart';
import '../../config/app_style.dart';

class TextFieldView extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? obscureText;
  final TextEditingController controller;
  final bool? fullTextView;
  final TextStyle? labelStyle;
  final int? maxLines;
  final TextInputType? keyboardType;
  final bool? enabled;
  const TextFieldView({
    super.key,
    this.labelText,
    this.suffixIcon,
    this.obscureText = false,
    required this.controller,
    this.fullTextView,
    this.hintText,
    this.prefixIcon,
    this.labelStyle,
    this.maxLines,
    this.keyboardType,
    this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      // maxLines: maxLines,
      enabled: enabled,
      cursorColor: AppColors.primaryColor,
      obscureText: obscureText!,
      decoration: InputDecoration(
        filled: fullTextView,
        fillColor: AppColors.whiteColor,
        contentPadding: EdgeInsets.symmetric(
          vertical: fullTextView == true ? 10 : 12,
          horizontal: fullTextView == true ? 17 : 5,
        ),
        enabledBorder: fullTextView == true
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: AppColors.whiteColor),
              )
            : UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.greyColor),
              ),
        focusedBorder: fullTextView == true
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: AppColors.whiteColor),
              )
            : UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.greyColor),
              ),
        labelText: labelText,
        labelStyle: labelStyle ??
            AppTextStyle.smallTextStyle.copyWith(
              fontSize: 16,
              color: AppColors.greyColor,
            ),
        hintText: hintText,
        hintStyle: AppTextStyle.smallTextStyle.copyWith(
          fontSize: 16,
          color: AppColors.greyColor,
        ),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
      ),
    );
  }
}
