// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:teacherexam/controller/exam_detail_controller.dart';
import 'package:teacherexam/screens/edit_question/edit_question_screen.dart';
import '../../config/app_colors.dart';
import '../../config/app_style.dart';
import '../../widgets/common_widgets/button_view.dart';
import '../../widgets/common_widgets/text_field_view.dart';

class EditExamDetailScreen extends StatefulWidget {
  final int index;
  const EditExamDetailScreen({
    super.key,
    required this.index,
  });

  @override
  State<EditExamDetailScreen> createState() => _EditExamDetailScreenState();
}

class _EditExamDetailScreenState extends State<EditExamDetailScreen> {
  ExamDetailController examDetailController = Get.put(ExamDetailController());

  final TextEditingController subject = TextEditingController();
  final TextEditingController mcq = TextEditingController();
  final TextEditingController examDuration = TextEditingController();
  final TextEditingController date = TextEditingController();
  final TextEditingController time = TextEditingController();
  final TextEditingController code = TextEditingController();

  @override
  void initState() {
    subject.text = examDetailController.homeScreenExam[widget.index]["subject"];
    mcq.text =
        examDetailController.homeScreenExam[widget.index]["mcq"].toString();
    examDuration.text =
        examDetailController.homeScreenExam[widget.index]["examDuration"];
    date.text = examDetailController.homeScreenExam[widget.index]["date"];
    time.text = examDetailController.homeScreenExam[widget.index]["time"];
    code.text =
        examDetailController.homeScreenExam[widget.index]["code"].toString();
    super.initState();
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
              controller: subject,
            ),
            SizedBox(
              height: 10,
            ),
            TextFieldView(
              labelText: "Total MCQ",
              controller: mcq,
              keyboardType: TextInputType.number,
            ),
            SizedBox(
              height: 10,
            ),
            TextFieldView(
              labelText: "Exam duration",
              hintText: "hh:mm",
              controller: examDuration,
              keyboardType: TextInputType.datetime,
              inputFormatters: [
                LengthLimitingTextInputFormatter(5),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            TextFieldView(
              labelText: "Exam code",
              controller: code,
              enabled: false,
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
            Row(
              children: [
                ButtonView(
                  width: MediaQuery.of(context).size.width / 2.2,
                  title: "Preview of question",
                  onTap: () {
                    examDetailController.getQuestionDetail(
                      code: int.parse(code.text),
                    );

                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => EditQuestionScreen(
                        mcq: mcq.text,
                        code: code.text,
                      ),
                    ));
                  },
                ),
                SizedBox(
                  width: 10,
                ),
                ButtonView(
                  title: "Save changes",
                  width: MediaQuery.of(context).size.width / 2.3,
                  onTap: () {
                    examDetailController.updateExamDetail(
                      subject: subject.text,
                      mcq: int.parse(mcq.text),
                      examDuration: examDuration.text,
                      date: date.text,
                      time: time.text,
                      code: int.parse(code.text),
                      context: context,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
