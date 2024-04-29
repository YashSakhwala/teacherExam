// ignore_for_file: sized_box_for_whitespace, non_constant_identifier_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teacherexam/screens/history/history_screen.dart';
import 'package:teacherexam/screens/home/home_screen.dart';
import '../../config/app_colors.dart';
import '../../config/app_image.dart';
import '../../controller/bottom_bar_controller.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({super.key});

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  List BottomBarScreens = [
    HomeScreen(),
    HistoryScreen(),
  ];

  BottomBarController bottomBarController = Get.put(BottomBarController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Material(
        elevation: 25,
        child: Container(
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {
                  bottomBarController.index.value = 0;
                },
                icon: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Obx(
                      () => Image.asset(
                        bottomBarController.index.value == 0
                            ? AppImages.fillHome
                            : AppImages.blankHome,
                        height: 25,
                        color: bottomBarController.index.value == 0
                            ? AppColors.primaryColor
                            : AppColors.blackColor,
                      ),
                    ),
                    Obx(
                      () => Text(
                        "Home",
                        style: TextStyle(
                          fontSize: 12,
                          color: bottomBarController.index.value == 0
                              ? AppColors.primaryColor
                              : AppColors.blackColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  bottomBarController.index.value = 1;
                },
                icon: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Obx(
                      () => Image.asset(
                        bottomBarController.index.value == 1
                            ? AppImages.fillHistory
                            : AppImages.blankHistory,
                        height: 25,
                        color: bottomBarController.index.value == 1
                            ? AppColors.primaryColor
                            : AppColors.blackColor,
                      ),
                    ),
                    Obx(
                      () => Text(
                        "History",
                        style: TextStyle(
                          fontSize: 12,
                          color: bottomBarController.index.value == 1
                              ? AppColors.primaryColor
                              : AppColors.blackColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Obx(() => BottomBarScreens[bottomBarController.index.value]),
    );
  }
}
