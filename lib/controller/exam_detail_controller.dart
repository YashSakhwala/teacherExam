// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teacherexam/config/local_storage.dart';
import 'package:teacherexam/widgets/common_widgets/indicator_view.dart';
import 'package:teacherexam/widgets/common_widgets/toast_view.dart';

class ExamDetailController extends GetxController {
  Future<void> examDetail({
    required String subject,
    required int mcq,
    required String date,
    required String time,
    required List<Map<String, dynamic>> questions,
    required BuildContext context,
  }) async {
    try {
      indicatorView(context);

      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      int randomCode = DateTime.now().millisecondsSinceEpoch % 1000000;

      await firebaseFirestore
          .collection("Exams")
          .doc(randomCode.toString())
          .set({
        "subject": subject,
        "mcq": mcq,
        "date": date,
        "time": time,
        "code": randomCode,
        "questions": questions,
        "grpValue": -1,
      });

      await LocalStorage.sharedPreferences
          .setString(LocalStorage.randomCode, randomCode.toString());

      toastView(msg: "Exam added successfully");

      Navigator.of(context).pop();
    } catch (e) {
      toastView(msg: "Failed to save exam details.");

      Navigator.of(context).pop();
    }
  }

  Future<void> updateExamDetail({
    required String subject,
    required int mcq,
    required String date,
    required String time,
    required BuildContext context,
  }) async {
    try {
      indicatorView(context);

      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      String? randomCode =
          LocalStorage.sharedPreferences.getString(LocalStorage.randomCode);

      await firebaseFirestore.collection("Exam").doc(randomCode).update({
        "subject": subject,
        "mcq": mcq,
        "date": date,
        "time": time,
      });

      toastView(msg: "Details updated successfully");

      Navigator.of(context).pop();
    } catch (e) {
      toastView(msg: "Failed to save exam details.");

      Navigator.of(context).pop();
    }
  }
}
