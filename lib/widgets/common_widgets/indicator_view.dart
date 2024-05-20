// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import '../../config/app_colors.dart';

void indicatorView(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Center(
        child: CircularProgressIndicator(
          color: AppColors.whiteColor,
          strokeWidth: 2,
        ),
      ),
    ),
  );
}
