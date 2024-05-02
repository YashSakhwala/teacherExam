// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teacherexam/controller/exam_detail_controller.dart';
import '../../config/app_colors.dart';
import '../../config/app_style.dart';
import '../../widgets/common_widgets/button_view.dart';
import '../../widgets/common_widgets/text_field_view.dart';

class EditQuestionScreen extends StatefulWidget {
  const EditQuestionScreen({super.key});

  @override
  State<EditQuestionScreen> createState() => _EditQuestionScreenState();
}

class _EditQuestionScreenState extends State<EditQuestionScreen> {
  ExamDetailController examDetailController = Get.put(ExamDetailController());

  final TextEditingController subject = TextEditingController();
  final TextEditingController mcq = TextEditingController();
  final TextEditingController date = TextEditingController();
  final TextEditingController time = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Center(
              child: Text(
                "Exam details",
                style: AppTextStyle.regularTextStyle.copyWith(fontSize: 20),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            TextFieldView(
              labelText: "Subject name",
              labelStyle: AppTextStyle.regularTextStyle.copyWith(fontSize: 18),
              controller: subject,
            ),
            SizedBox(
              height: 10,
            ),
            TextFieldView(
              labelText: "Total MCQ",
              labelStyle: AppTextStyle.regularTextStyle.copyWith(fontSize: 18),
              controller: mcq,
              keyboardType: TextInputType.number,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      DateTime? dateTime = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1990),
                        lastDate: DateTime(2040),
                        builder: (BuildContext context, Widget? child) {
                          return Theme(
                            data: ThemeData.light().copyWith(
                              colorScheme:
                                  ColorScheme.light(primary: Colors.blue),
                            ),
                            child: child!,
                          );
                        },
                      );
                      if (dateTime != null) {
                        setState(() {
                          date.text = dateTime.toString().split(' ').first;
                        });
                      }
                    },
                    child: TextFieldView(
                      labelText: "Date",
                      labelStyle:
                          AppTextStyle.regularTextStyle.copyWith(fontSize: 18),
                      controller: date,
                      suffixIcon: Icon(
                        Icons.calendar_month_outlined,
                        color: AppColors.greyColor,
                      ),
                      enabled: false,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      TimeOfDay? timeOfDay = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                        builder: (BuildContext context, Widget? child) {
                          return Theme(
                            data: ThemeData.light().copyWith(
                              colorScheme:
                                  ColorScheme.light(primary: Colors.blue),
                            ),
                            child: child!,
                          );
                        },
                      );
                      if (timeOfDay != null) {
                        time.text = timeOfDay.format(context);
                      }
                    },
                    child: TextFieldView(
                      labelText: "Time",
                      labelStyle:
                          AppTextStyle.regularTextStyle.copyWith(fontSize: 18),
                      controller: time,
                      suffixIcon: Icon(
                        Icons.watch_later_outlined,
                        color: AppColors.greyColor,
                      ),
                      enabled: false,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 80,
            ),
            ButtonView(
              title: "Save changes",
              onTap: () {
                examDetailController.updateExamDetail(
                  subject: subject.text,
                  mcq: int.parse(mcq.text),
                  date: date.text,
                  time: time.text,
                  context: context,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
