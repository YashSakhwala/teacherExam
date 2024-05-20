
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:teacherexam/controller/exam_detail_controller.dart';
import 'package:teacherexam/screens/marks/marks_screen.dart';
import '../../config/app_colors.dart';
import '../../config/app_style.dart';

class LeaderboardScreen extends StatefulWidget {
  final List studentData;

  const LeaderboardScreen({
    super.key,
    required this.studentData,
  });

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  ExamDetailController examDetailController = Get.put(ExamDetailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Center(
              child: Text(
                "Leaderboard",
                style: AppTextStyle.largeTextStyle.copyWith(fontSize: 20),
              ),
            ),
            widget.studentData.isEmpty
                ? Expanded(
                    child: Center(
                      child: Lottie.asset(
                        "assets/lottie/empty.json",
                      ),
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: widget.studentData.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => MarksScreen(
                                  studentData: widget.studentData[index],
                                ),
                              ));
                            },
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
                                    Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        CircularProgressIndicator(
                                          color: AppColors.primaryColor,
                                          strokeWidth: 2,
                                        ),
                                        Container(
                                          height: 70,
                                          width: 70,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: AppColors.primaryColor),
                                            image: DecorationImage(
                                              image: Image.network(
                                                      widget.studentData[index]
                                                          ["image"])
                                                  .image,
                                              scale: 9,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.studentData[index]["name"],
                                          style: AppTextStyle.largeTextStyle
                                              .copyWith(
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          "${widget.studentData[index]["percentage"]} %",
                                          style: AppTextStyle.smallTextStyle
                                              .copyWith(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: AppColors.primaryColor),
                                        color: index == 0
                                            ? AppColors.yellowColor
                                            : index == 1
                                                ? AppColors.brownColor
                                                    .withOpacity(0.3)
                                                : index == 2
                                                    ? AppColors.pinkColor
                                                        .withOpacity(0.4)
                                                    : AppColors.primaryColor
                                                        .withOpacity(0.07),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "${index + 1}",
                                          style: AppTextStyle.regularTextStyle
                                              .copyWith(
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
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
