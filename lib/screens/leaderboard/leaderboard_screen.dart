// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../config/app_colors.dart';
import '../../config/app_image.dart';
import '../../config/app_style.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  List studentDetails = [
    {"name": "Lukasz", "marks": 70},
    {"name": "Long", "marks": 80},
    {"name": "Tom", "marks": 76},
    {"name": "Hiddleston", "marks": 65},
    {"name": "Acacia", "marks": 77},
    {"name": "Paul", "marks": 45},
    {"name": "Agnes", "marks": 56},
    {"name": "Andrew", "marks": 81},
    {"name": "Jecika", "marks": 93},
    {"name": "John", "marks": 67},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Center(
              child: Text(
                "Leaderboard",
                style: AppTextStyle.largeTextStyle.copyWith(fontSize: 20),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: studentDetails.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Container(
                    height: 75,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: index.isEven
                          ? AppColors.whiteColor
                          : AppColors.primaryColor.withOpacity(0.1),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.greyColor.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 6,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColors.primaryColor),
                              image: DecorationImage(
                                image: Image.asset(AppImages.boy).image,
                                scale: 9,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                studentDetails[index]["name"],
                                style: AppTextStyle.regularTextStyle,
                              ),
                              Text(
                                "${studentDetails[index]["marks"]}%",
                                style: AppTextStyle.smallTextStyle
                                    .copyWith(fontSize: 13),
                              ),
                            ],
                          ),
                          Spacer(),
                          Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColors.primaryColor),
                              color: index == 0
                                  ? AppColors.yellowColor
                                  : index == 1
                                      ? AppColors.brownColor.withOpacity(0.3)
                                      : index == 2
                                          ? AppColors.pinkColor.withOpacity(0.4)
                                          : AppColors.primaryColor
                                              .withOpacity(0.07),
                            ),
                            child: Center(
                              child: Text(
                                "${index + 1}",
                                style: AppTextStyle.regularTextStyle.copyWith(
                                  color: index == 0
                                      ? AppColors.redColor
                                      : AppColors.primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
