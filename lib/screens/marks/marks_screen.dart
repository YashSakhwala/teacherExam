// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../../config/app_colors.dart';
import '../../config/app_image.dart';
import '../../config/app_style.dart';
import '../checking/checking_screen.dart';

class MarksScreen extends StatefulWidget {
  final Map studentData;

  const MarksScreen({
    super.key,
    required this.studentData,
  });

  @override
  State<MarksScreen> createState() => _MarksScreenState();
}

class _MarksScreenState extends State<MarksScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
        child: ListView(
          children: [
            Center(
              child: Text(
                "Review",
                style: AppTextStyle.largeTextStyle
                    .copyWith(fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${widget.studentData["right"]}/${widget.studentData["total"]}",
                  style: AppTextStyle.regularTextStyle,
                ),
                Text(
                  "You are right",
                  style: AppTextStyle.largeTextStyle.copyWith(fontSize: 20),
                ),
                Text(
                  "${widget.studentData["percentage"]} %",
                  style: AppTextStyle.regularTextStyle
                      .copyWith(color: AppColors.primaryColor),
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
              ),
              itemCount: widget.studentData["answer"].length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CheckingScreen(
                        index: index,
                        studentData: widget.studentData["answer"],
                      ),
                    ));
                  },
                  child: Container(
                    margin: EdgeInsets.all(4),
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.whiteColor,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.greyColor.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 53,
                          width: 53,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.primaryColor),
                            color: widget.studentData["answer"][index]
                                            ["grpValue"]
                                        .toString() ==
                                    "-1"
                                ? AppColors.redColor
                                : widget.studentData["answer"][index]
                                                ["grpValue"]
                                            .toString() ==
                                        widget.studentData["answer"][index]
                                                ["answer"]
                                            .toString()
                                    ? AppColors.greenColor
                                    : AppColors.redColor,
                          ),
                          child: Center(
                            child: Image.asset(
                              widget.studentData["answer"][index]["grpValue"]
                                          .toString() ==
                                      "-1"
                                  ? AppImages.wrong
                                  : widget.studentData["answer"][index]
                                                  ["grpValue"]
                                              .toString() ==
                                          widget.studentData["answer"][index]
                                                  ["answer"]
                                              .toString()
                                      ? AppImages.right
                                      : AppImages.wrong,
                              height: 30,
                              color: AppColors.whiteColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Question ${index + 1}",
                          style: AppTextStyle.smallTextStyle
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                      ],
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
