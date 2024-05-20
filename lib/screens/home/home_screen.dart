// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:teacherexam/controller/auth_controller.dart';
import 'package:teacherexam/controller/exam_detail_controller.dart';
import 'package:teacherexam/screens/setting/setting_screen.dart';
import '../../config/app_colors.dart';
import '../../config/app_image.dart';
import '../../config/app_style.dart';
import '../edit_exam_detail/edit_exam_detail_screen.dart';
import '../exam_detail/exam_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AuthController authController = Get.put(AuthController());

  ExamDetailController examDetailController = Get.put(ExamDetailController());

  @override
  void initState() {
    Future.microtask(() async {
      await examDetailController.getExam();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.primaryColor,
          toolbarHeight: 100,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
          title: Obx(
            () => Row(
              children: [
                CircleAvatar(
                  maxRadius: 38,
                  backgroundColor: AppColors.whiteColor,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircularProgressIndicator(
                        color: AppColors.primaryColor,
                        strokeWidth: 2,
                      ),
                      CircleAvatar(
                        maxRadius: 38,
                        backgroundColor: AppColors.transparentColor,
                        backgroundImage: Image.network(
                          authController.userData["image"],
                        ).image,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hello,",
                        style: AppTextStyle.regularTextStyle.copyWith(
                          fontSize: 15,
                          color: AppColors.whiteColor,
                        ),
                      ),
                      Text(
                        authController.userData["name"],
                        style: AppTextStyle.largeTextStyle.copyWith(
                          fontSize: 25,
                          color: AppColors.whiteColor,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(5),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SettingScreen(),
                  ));
                },
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: Center(
                    child: Image.asset(
                      AppImages.fillProfile,
                      height: 23,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: Obx(
          () => examDetailController.isLoader.value == true
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                    strokeWidth: 2,
                  ),
                )
              : examDetailController.homeScreenExam.isEmpty
                  ? Center(
                      child: Lottie.asset(
                        "assets/lottie/empty.json",
                      ),
                    )
                  : ListView(
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisExtent: 250,
                          ),
                          itemCount: examDetailController.homeScreenExam.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => EditExamDetailScreen(
                                    index: index,
                                  ),
                                ));
                              },
                              child: Container(
                                margin: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  image: DecorationImage(
                                    image: Image.asset(
                                      AppImages.exam,
                                    ).image,
                                    fit: BoxFit.cover,
                                    colorFilter:
                                        ColorFilter.srgbToLinearGamma(),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    ClipRect(
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(
                                            sigmaX: 3, sigmaY: 3),
                                        child: Container(
                                          width: 120,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(20),
                                              bottomRight: Radius.circular(20),
                                            ),
                                            color: AppColors.whiteColor
                                                .withOpacity(0.5),
                                          ),
                                          child: Center(
                                            child: Text(
                                              examDetailController
                                                      .homeScreenExam[index]
                                                  ["subject"],
                                              style: AppTextStyle.largeTextStyle
                                                  .copyWith(
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ExamDetailScreen(),
            ));
          },
          child: Icon(
            Icons.add,
            size: 35,
            color: AppColors.whiteColor,
          ),
          backgroundColor: AppColors.primaryColor,
          elevation: 0,
        ),
      ),
    );
  }
}
