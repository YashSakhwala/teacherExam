// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:teacherexam/screens/edit_question/edit_question_screen.dart';
import 'package:teacherexam/screens/exam_detail/exam_detail_screen.dart';
import 'package:teacherexam/screens/setting/setting_screen.dart';
import '../../config/app_colors.dart';
import '../../config/app_image.dart';
import '../../config/app_style.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController search = TextEditingController();

  List examList = [
    {"examName": "Math"},
    {"examName": "English"},
    {"examName": "Physical"},
    {"examName": "Chemistry"},
  ];

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
          title: Row(
            children: [
              CircleAvatar(
                maxRadius: 38,
                backgroundColor: AppColors.whiteColor,
                backgroundImage: Image.asset(AppImages.boy).image,
              ),
              SizedBox(
                width: 20,
              ),
              Column(
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
                    "Lukasz",
                    style: AppTextStyle.largeTextStyle.copyWith(
                      fontSize: 25,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SettingScreen(),
                  ));
                },
                child: Image.asset(
                  AppImages.fillProfile,
                  height: 23,
                  color: AppColors.whiteColor,
                ),
              ),
            ),
          ],
        ),
        body: ListView(
          children: [
            SizedBox(
              height: 30,
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 8),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 250,
              ),
              itemCount: examList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => EditQuestionScreen(),
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
                        colorFilter: ColorFilter.srgbToLinearGamma(),
                      ),
                    ),
                    child: Column(
                      children: [
                        ClipRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                            child: Container(
                              width: 120,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                ),
                                color: AppColors.whiteColor.withOpacity(0.5),
                              ),
                              child: Center(
                                child: Text(
                                  examList[index]["examName"],
                                  style: AppTextStyle.largeTextStyle.copyWith(
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
