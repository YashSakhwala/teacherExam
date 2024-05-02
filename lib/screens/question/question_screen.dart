// ignore_for_file: prefer_const_constructors, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:teacherexam/config/app_style.dart';
import 'package:teacherexam/controller/exam_detail_controller.dart';
import 'package:teacherexam/screens/bottom_bar/bottom_bar_screen.dart';
import 'package:teacherexam/widgets/common_widgets/button_view.dart';
import 'package:teacherexam/widgets/common_widgets/text_field_view.dart';
import 'package:teacherexam/widgets/common_widgets/toast_view.dart';

class QuestionScreen extends StatefulWidget {
  final String subject;
  final String mcq;
  final String date;
  final String time;

  const QuestionScreen({
    super.key,
    required this.mcq,
    required this.subject,
    required this.date,
    required this.time,
  });

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  final TextEditingController question = TextEditingController();
  final TextEditingController option1 = TextEditingController();
  final TextEditingController option2 = TextEditingController();
  final TextEditingController option3 = TextEditingController();
  final TextEditingController option4 = TextEditingController();
  final TextEditingController answer = TextEditingController();

  final PageController pageController = PageController();

  ExamDetailController examDetailController = Get.put(ExamDetailController());

  List<Map<String, dynamic>> questions = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: pageController,
                physics: NeverScrollableScrollPhysics(),
                itemCount: int.tryParse(widget.mcq),
                itemBuilder: (context, index) {
                  return ListView(
                    children: [
                      Text(
                        "Question ${index + 1}",
                        style:
                            AppTextStyle.largeTextStyle.copyWith(fontSize: 22),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFieldView(
                        labelText: 'Enter your question',
                        controller: question,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Options",
                        style: AppTextStyle.largeTextStyle,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFieldView(
                        labelText: 'Option 1',
                        controller: option1,
                      ),
                      TextFieldView(
                        labelText: 'Option 2',
                        controller: option2,
                      ),
                      TextFieldView(
                        labelText: 'Option 3',
                        controller: option3,
                      ),
                      TextFieldView(
                        labelText: 'Option 4',
                        controller: option4,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Answer",
                        style: AppTextStyle.largeTextStyle,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFieldView(
                        labelText: 'Answer',
                        controller: answer,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.allow(RegExp(r'[1-4]')),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      ButtonView(
                        onTap: () {
                          if (question.text.isEmpty ||
                              option1.text.isEmpty ||
                              option2.text.isEmpty ||
                              option3.text.isEmpty ||
                              option4.text.isEmpty ||
                              answer.text.isEmpty) {
                            toastView(msg: "Please fill all fields");
                          } else {
                            Map<String, dynamic> questionMap = {
                              "question": question.text,
                              "options": [
                                option1.text,
                                option2.text,
                                option3.text,
                                option4.text,
                              ],
                              "answer": answer.text,
                            };

                            questions.add(questionMap);

                            if (index < int.tryParse(widget.mcq)! - 1) {
                              pageController.nextPage(
                                duration: Duration(milliseconds: 400),
                                curve: Curves.easeInOut,
                              );

                              question.text = "";
                              option1.text = "";
                              option2.text = "";
                              option3.text = "";
                              option4.text = "";
                              answer.text = "";
                            }
                          }

                          if (index == int.tryParse(widget.mcq)! - 1) {
                            examDetailController.examDetail(
                              subject: widget.subject,
                              mcq: int.parse(widget.mcq),
                              date: widget.date,
                              time: widget.time,
                              questions: questions,
                              context: context,
                            );

                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (context) => BottomBarScreen(),
                                ),
                                (route) => false);
                          }
                        },
                        title: index == int.tryParse(widget.mcq)! - 1
                            ? "Finish"
                            : "Next",
                      ),
                    ],
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
