// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:teacherexam/controller/auth_controller.dart';
import '../../config/app_colors.dart';
import '../../widgets/common_widgets/button_view.dart';
import '../../widgets/common_widgets/text_field_view.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  AuthController authController = Get.put(AuthController());

  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phoneNo = TextEditingController();

  @override
  void initState() {
    name.text = authController.userData["name"];
    email.text = authController.userData["email"];
    phoneNo.text = authController.userData["phoneNo"];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 70,
          ),
          InkWell(
            onTap: () async {
              ImagePicker imagePicker = ImagePicker();

              XFile? xFile =
                  await imagePicker.pickImage(source: ImageSource.gallery);

              authController.imagePath.value = xFile!.path;
            },
            child: Stack(
              children: [
                Obx(
                  () => Stack(
                    alignment: Alignment.center,
                    children: [
                      CircularProgressIndicator(
                        color: AppColors.primaryColor,
                        strokeWidth: 2,
                      ),
                      Container(
                        height: 140,
                        width: 140,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.primaryColor),
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: authController.imagePath.value.isNotEmpty
                                ? FileImage(
                                    File(authController.imagePath.value))
                                : Image.network(
                                        authController.userData["image"])
                                    .image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primaryColor,
                    ),
                    child: Icon(
                      Icons.add,
                      size: 25,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Divider(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: ListView(
                shrinkWrap: true,
                children: [
                  TextFieldView(
                    labelText: "Name",
                    controller: name,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFieldView(
                    labelText: "Email",
                    controller: email,
                    enabled: false,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFieldView(
                    labelText: "Phone no",
                    controller: phoneNo,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10),
                    ],
                  ),
                  SizedBox(
                    height: 70,
                  ),
                  ButtonView(
                    title: "Save changes",
                    onTap: () {
                      authController.updateProfile(
                        name: name.text,
                        email: email.text,
                        phoneNo: phoneNo.text,
                        context: context,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
