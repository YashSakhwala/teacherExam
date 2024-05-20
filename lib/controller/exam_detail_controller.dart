// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:teacherexam/config/local_storage.dart';
import 'package:teacherexam/widgets/common_widgets/indicator_view.dart';
import 'package:teacherexam/widgets/common_widgets/toast_view.dart';
import '../config/app_colors.dart';
import '../config/app_style.dart';
import '../screens/bottom_bar/bottom_bar_screen.dart';
import '../screens/leaderboard/leaderboard_screen.dart';
import '../widgets/common_widgets/button_view.dart';

class ExamDetailController extends GetxController {
  RxList homeScreenExam = [].obs;
  RxList historyScreenExam = [].obs;
  RxBool isLoader = false.obs;
  RxMap editExamData = {}.obs;

  RxList studentData = [].obs;

  Future<void> examDetail({
    required String subject,
    required int mcq,
    required String examDuration,
    required String date,
    required String time,
    required List questions,
    required BuildContext context,
  }) async {
    indicatorView(context);

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    String? userId =
        LocalStorage.sharedPreferences.getString(LocalStorage.userId);

    String generateRandomCode() {
      Random random = Random();
      int firstCharCode = random.nextInt(26) + 'A'.codeUnitAt(0);
      int lastCharCode = random.nextInt(26) + 'a'.codeUnitAt(0);
      String middleDigits = '';
      for (int i = 0; i < 6; i++) {
        middleDigits += random.nextInt(10).toString();
      }
      String code = String.fromCharCode(firstCharCode) +
          middleDigits +
          String.fromCharCode(lastCharCode);
      return code;
    }

    String randomCode = generateRandomCode();

    var teacherData =
        await firebaseFirestore.collection("Teacher").doc(userId).get();

    await firebaseFirestore.collection("Exams").doc(randomCode).set({
      "subject": subject,
      "mcq": mcq,
      "examDuration": examDuration,
      "date": date,
      "time": time,
      "code": randomCode,
      "questions": questions,
      "teacherId": userId,
      "teacherName": teacherData["name"],
    });

    showExamDetailDialog(
      code: randomCode,
      teacherName: teacherData["name"],
      subjectName: subject,
      date: date,
      time: time,
      context: context,
    );
  }

  void showExamDetailDialog({
    required String code,
    required String teacherName,
    required String subjectName,
    required String date,
    required String time,
    required BuildContext context,
  }) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.whiteColor,
                  border: Border.all(
                      color: AppColors.primaryColor.withOpacity(0.5)),
                ),
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Exam code:",
                          style: AppTextStyle.smallTextStyle.copyWith(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          code.toString(),
                          style: AppTextStyle.largeTextStyle
                              .copyWith(color: AppColors.primaryColor),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Exam has been added successfully.",
                style: AppTextStyle.regularTextStyle,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ButtonView(
                    title: "Copy",
                    height: 48,
                    width: 100,
                    borderRadius: BorderRadius.circular(18),
                    onTap: () {
                      String examDetails = '''
Exam Code: $code\n
Teacher Name: $teacherName\n
Subject Name: $subjectName\n
Date: $date\n
Time: $time\n
''';
                      Clipboard.setData(ClipboardData(text: examDetails))
                          .then((_) {
                        toastView(msg: "Code successfully copied");
                      });

                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => BottomBarScreen(),
                          ),
                          (route) => false);
                    },
                  ),
                  ButtonView(
                    title: "Share",
                    height: 48,
                    width: 100,
                    borderRadius: BorderRadius.circular(18),
                    onTap: () {
                      String examDetails = '''
Exam Code: $code\n
Teacher Name: $teacherName\n
Subject Name: $subjectName\n
Date: $date\n
Time: $time\n
''';

                      Share.share(examDetails);

                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => BottomBarScreen(),
                          ),
                          (route) => false);
                    },
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => BottomBarScreen(),
                    ),
                    (route) => false);
              },
              child: Text(
                "Close",
                style: AppTextStyle.smallTextStyle,
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> getExam() async {
    isLoader.value = true;

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    homeScreenExam.clear();
    historyScreenExam.clear();

    String? userId =
        LocalStorage.sharedPreferences.getString(LocalStorage.userId);

    var data = await firebaseFirestore
        .collection("Exams")
        .where("teacherId", isEqualTo: userId)
        .get();

    List temp = [];

    for (var doc in data.docs) {
      Map<String, dynamic> docData = doc.data();
      temp.add(docData);
    }
    for (int i = 0; i < temp.length; i++) {
      bool isFuture = checkDateAndTime(temp[i]['date'], temp[i]['time']);
      if (isFuture) {
        homeScreenExam.add(temp[i]);
      } else {
        historyScreenExam.add(temp[i]);
      }
    }
    isLoader.value = false;
  }

  bool checkDateAndTime(String givenDate, String givenTime) {
    DateTime currentDateTime = DateTime.now();

    List<String> dateParts = givenDate.split('-');
    int year = int.parse(dateParts[0]);
    int month = int.parse(dateParts[1]);
    int day = int.parse(dateParts[2]);

    List<String> timeParts = givenTime.split(':');
    int hour = int.parse(timeParts[0]);
    int minute = int.parse(timeParts[1].split(' ')[0]);
    String period = timeParts[1].split(' ')[1];

    if (period == 'PM' && hour != 12) {
      hour += 12;
    } else if (period == 'AM' && hour == 12) {
      hour = 0;
    }

    DateTime givenDateTime = DateTime(year, month, day, hour, minute);

    if (givenDateTime.isBefore(currentDateTime)) {
      return false;
    } else if (givenDateTime.isAfter(currentDateTime)) {
      return true;
    } else {
      return true;
    }
  }

  Future<void> updateQuestionDetail({
    required String code,
    required List questions,
    required BuildContext context,
  }) async {
    indicatorView(context);

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    await firebaseFirestore.collection("Exams").doc(code).update({
      "subject": editExamData["subject"],
      "mcq": editExamData["mcq"],
      "examDuration": editExamData["examDuration"],
      "date": editExamData["date"],
      "time": editExamData["time"],
      "questions": questions,
    });

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => BottomBarScreen(),
        ),
        (route) => false);
  }

  Future<void> getStudentData({
    required String code,
    required BuildContext context,
  }) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    var data = await firebaseFirestore
        .collection("Exams")
        .doc(code)
        .collection("Answer")
        .get();

    studentData.value = data.docs.map((doc) => doc.data()).toList();

    studentData.value = studentData.toList()
      ..sort((a, b) => b["percentage"].compareTo(a["percentage"]));

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => LeaderboardScreen(
        studentData: studentData,
      ),
    ));
  }
}
