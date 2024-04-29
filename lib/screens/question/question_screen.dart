// ignore_for_file: prefer_const_constructors, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teacherexam/config/app_style.dart';
import 'package:teacherexam/controller/question_controller.dart';
import 'package:teacherexam/widgets/common_widgets/button_view.dart';
import 'package:teacherexam/widgets/common_widgets/text_field_view.dart';
import 'package:teacherexam/widgets/common_widgets/toast_view.dart';

class QuestionScreen extends StatefulWidget {
  final String mcq;

  const QuestionScreen({
    super.key,
    required this.mcq,
  });

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  final TextEditingController question = TextEditingController();
  final TextEditingController answer1 = TextEditingController();
  final TextEditingController answer2 = TextEditingController();
  final TextEditingController answer3 = TextEditingController();
  final TextEditingController answer4 = TextEditingController();

  final PageController pageController = PageController();

  QuestionController questionController = Get.put(QuestionController());

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
                        controller: answer1,
                      ),
                      TextFieldView(
                        labelText: 'Option 2',
                        controller: answer2,
                      ),
                      TextFieldView(
                        labelText: 'Option 3',
                        controller: answer3,
                      ),
                      TextFieldView(
                        labelText: 'Option 4',
                        controller: answer4,
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
                      Obx(
                        () => DropdownButton<dynamic>(
                          isExpanded: true,
                          value: questionController.country.value,
                          items: questionController.countryList.value
                              .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            questionController.country.value = value;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      ButtonView(
                        onTap: () {
                          if (question.text.isEmpty ||
                              answer1.text.isEmpty ||
                              answer2.text.isEmpty ||
                              answer3.text.isEmpty ||
                              answer4.text.isEmpty) {
                            toastView(msg: "Please fill all fields");
                          } else {
                            if (index < int.tryParse(widget.mcq)! - 1) {
                              pageController.nextPage(
                                duration: Duration(milliseconds: 400),
                                curve: Curves.easeInOut,
                              );
                              question.text = "";
                              answer1.text = "";
                              answer2.text = "";
                              answer3.text = "";
                              answer4.text = "";
                            }
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
