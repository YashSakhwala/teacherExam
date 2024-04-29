// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../config/app_colors.dart';
import '../../config/app_image.dart';
import '../../widgets/common_widgets/button_view.dart';
import '../../widgets/common_widgets/text_field_view.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phoneNo = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 70,
          ),
          Stack(
            children: [
              Container(
                height: 140,
                width: 140,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.primaryColor),
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: Image.asset(AppImages.boy).image,
                    fit: BoxFit.cover,
                  ),
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
                    controller: name,
                    labelText: "Name",
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFieldView(
                    controller: email,
                    labelText: "Email",
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFieldView(
                    controller: phoneNo,
                    labelText: "Phone no",
                  ),
                  SizedBox(
                    height: 70,
                  ),
                  ButtonView(
                    title: "Save changes",
                    onTap: () {},
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
