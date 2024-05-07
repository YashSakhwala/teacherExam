// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../config/app_style.dart';
import '../../controller/exam_detail_controller.dart';
import '../../widgets/common_widgets/button_view.dart';
import '../../widgets/common_widgets/text_field_view.dart';
import '../../widgets/common_widgets/toast_view.dart';

class EditQuestionScreen extends StatefulWidget {
  final String mcq;
  final String code;
  final List question;

  const EditQuestionScreen({
    super.key,
    required this.mcq,
    required this.code,
    required this.question,
  });

  @override
  State<EditQuestionScreen> createState() => _EditQuestionScreenState();
}

class _EditQuestionScreenState extends State<EditQuestionScreen> {
  final TextEditingController question = TextEditingController();
  final TextEditingController option1 = TextEditingController();
  final TextEditingController option2 = TextEditingController();
  final TextEditingController option3 = TextEditingController();
  final TextEditingController option4 = TextEditingController();
  final TextEditingController answer = TextEditingController();

  final PageController pageController = PageController();

  ExamDetailController examDetailController = Get.put(ExamDetailController());

  List questions = [];

  @override
  Widget build(BuildContext context) {
    print(widget.mcq);
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
                  question.text = index >= widget.question.length
                      ? ""
                      : widget.question[index]['question'];
                  option1.text = index >= widget.question.length
                      ? ""
                      : widget.question[index]['options'][0];
                  option2.text = index >= widget.question.length
                      ? ""
                      : widget.question[index]['options'][1];
                  option3.text = index >= widget.question.length
                      ? ""
                      : widget.question[index]['options'][2];
                  option4.text = index >= widget.question.length
                      ? ""
                      : widget.question[index]['options'][3];
                  answer.text = index >= widget.question.length
                      ? ""
                      : widget.question[index]['answer'];

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
                            Map questionMap = {
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
                            } else {
                              examDetailController.updateQuestionDetail(
                                code: widget.code,
                                questions: questions,
                                context: context,
                              );
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
