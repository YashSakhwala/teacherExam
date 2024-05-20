// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../config/app_colors.dart';
import '../../config/app_style.dart';
import '../../utils/validation.dart';

class TextFieldView extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final Widget? suffixIcon;
  final bool? obscureText;
  final TextEditingController controller;
  final bool? fullTextView;
  final TextStyle? labelStyle;
  final TextInputType? keyboardType;
  final bool? enabled;
  final bool needValidator;
  final bool nameValidator;
  final bool emailValidator;
  final bool phoneNoValidator;
  final bool passwordValidator;
  final List<TextInputFormatter>? inputFormatters;

  const TextFieldView({
    super.key,
    this.labelText,
    this.suffixIcon,
    this.obscureText = false,
    required this.controller,
    this.fullTextView,
    this.hintText,
    this.labelStyle,
    this.keyboardType,
    this.enabled,
    this.needValidator = false,
    this.nameValidator = false,
    this.emailValidator = false,
    this.phoneNoValidator = false,
    this.passwordValidator = false,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: AppTextStyle.regularTextStyle.copyWith(fontSize: 18),
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
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
        suffixIconColor: AppColors.primaryColor,
      ),
      validator: needValidator
          ? (value) => TextFieldValidation.validation(
                isEmailValidator: emailValidator,
                isPasswordValidator: passwordValidator,
                isPhoneNumberValidator: phoneNoValidator,
                message: labelText,
                value: value,
              )
          : null,
    );
  }
}
