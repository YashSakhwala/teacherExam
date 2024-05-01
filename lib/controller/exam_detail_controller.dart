import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teacherexam/widgets/common_widgets/indicator_view.dart';

class ExamDetailController extends GetxController {
  Future<void> examDetail({
    required String subject,
    required int mcq,
    required String date,
    required String time,
    required BuildContext context,
  }) async {
    try {
      indicatorView(context);

      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      await firebaseFirestore.collection("Exams").doc(subject).set({
        "mcq": mcq,
        "date": date,
        "time": time,
      });
      
    } catch (e) {}
  }
}
