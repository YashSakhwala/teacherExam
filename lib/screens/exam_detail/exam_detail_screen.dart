// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:teacherexam/config/app_colors.dart';
import 'package:teacherexam/controller/exam_detail_controller.dart';
import 'package:teacherexam/screens/question/question_screen.dart';
import 'package:teacherexam/widgets/common_widgets/text_field_view.dart';
import 'package:teacherexam/widgets/common_widgets/toast_view.dart';
import '../../config/app_style.dart';
import '../../widgets/common_widgets/button_view.dart';

class ExamDetailScreen extends StatefulWidget {
  const ExamDetailScreen({super.key});

  @override
  State<ExamDetailScreen> createState() => _ExamDetailScreenState();
}

class _ExamDetailScreenState extends State<ExamDetailScreen> {
  ExamDetailController examDetailController = Get.put(ExamDetailController());

  final TextEditingController subject = TextEditingController();
  final TextEditingController mcq = TextEditingController();
  final TextEditingController examDuration = TextEditingController();
  final TextEditingController date = TextEditingController();
  final TextEditingController time = TextEditingController();

  bool isTimeAtLeastOneHourLater(String selectedTime) {
    final now = DateTime.now();

    var timeOfDay = TimeOfDay(
      hour: int.parse(selectedTime.split(":")[0]),
      minute: int.parse(selectedTime.split(":")[1].split(" ")[0]),
    );

    if (selectedTime.contains("PM") && timeOfDay.hour < 12) {
      timeOfDay = timeOfDay.replacing(hour: timeOfDay.hour + 12);
    } else if (selectedTime.contains("AM") && timeOfDay.hour == 12) {
      timeOfDay = timeOfDay.replacing(hour: 0);
    }

    final selectedDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      timeOfDay.hour,
      timeOfDay.minute,
    );

    if (selectedDateTime.isBefore(now)) {
      return false;
    }

    final difference = selectedDateTime.difference(now).inMinutes;
    return difference >= 60;
  }

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
            TextFieldView(
              labelText: "Exam duration",
              hintText: "hh:mm",
              labelStyle: AppTextStyle.regularTextStyle.copyWith(fontSize: 18),
              controller: examDuration,
              keyboardType: TextInputType.datetime,
              inputFormatters: [
                LengthLimitingTextInputFormatter(5),
              ],
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
                        firstDate: DateTime.now(),
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
              title: "Add questions",
              onTap: () async {
                if (subject.text.isEmpty ||
                    mcq.text.isEmpty ||
                    date.text.isEmpty ||
                    time.text.isEmpty ||
                    examDuration.text.isEmpty) {
                  toastView(msg: "Please fill all fields");

                  return;
                } else if (!RegExp(
                  r'^([01]?[0-9]|2[0-3]):[0-5][0-9]$',
                ).hasMatch(examDuration.text)) {
                  toastView(msg: "Please enter valid time format");
                  return;
                } else if (mcq.text == "0") {
                  toastView(msg: "Please enter a valid total mcq");
                } else if (!isTimeAtLeastOneHourLater(time.text)) {
                  toastView(
                      msg:
                          "Please select a time at least 1 hour later than the current time");
                  return;
                } else {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => QuestionScreen(
                      subject: subject.text,
                      mcq: mcq.text,
                      date: date.text,
                      time: time.text,
                      examDuration: examDuration.text,
                    ),
                  ));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
