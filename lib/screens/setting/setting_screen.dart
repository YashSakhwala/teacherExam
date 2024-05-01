// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teacherexam/controller/auth_controller.dart';
import 'package:teacherexam/screens/splash_screen.dart';
import 'package:teacherexam/widgets/common_widgets/indicator_view.dart';
import '../../config/app_colors.dart';
import '../../config/app_image.dart';
import '../../config/app_style.dart';
import '../../config/local_storage.dart';
import '../../widgets/common_widgets/alert_dialog_box_view.dart';
import '../../widgets/common_widgets/button_view.dart';
import '../profile/profile_screen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  AuthController authController = Get.put(AuthController());

  void logOut() {
    showAlertDialogBox(
      context: context,
      yesOnTap: () async {
        indicatorView(context);

        LocalStorage.sharedPreferences.clear();

        FirebaseAuth firebaseAuth = FirebaseAuth.instance;

        await firebaseAuth.signOut();

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => SplashScreen(),
            ),
            (route) => false);
      },
      noOnTap: () {
        Navigator.of(context).pop();
      },
      title: "Log Out",
      subTitle: "Are you sure you want to log out?",
    );
  }

  List profileItems = [
    {
      "icon": AppImages.torch,
      "name": "Dark light Mode",
      "isSwitch": true,
      "value": false
    },
    {"icon": AppImages.terms, "name": "Privacy & terms", "isSwitch": false},
    {"icon": AppImages.contactUs, "name": "Contact us", "isSwitch": false},
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              height: 230,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(60)),
                color: AppColors.primaryColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  children: [
                    Obx(
                      () => Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                authController.userData["name"],
                                style: AppTextStyle.largeTextStyle.copyWith(
                                  fontSize: 35,
                                  color: AppColors.whiteColor,
                                ),
                              ),
                              Text(
                                authController.userData["email"],
                                style: AppTextStyle.smallTextStyle.copyWith(
                                  fontSize: 12,
                                  color: AppColors.whiteColor,
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Container(
                            height: 75,
                            width: 75,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.whiteColor,
                              image: DecorationImage(
                                image: Image.network(
                                  authController.userData["image"],
                                ).image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "4",
                              style: AppTextStyle.largeTextStyle.copyWith(
                                fontSize: 16,
                                color: AppColors.whiteColor,
                              ),
                            ),
                            Text(
                              "Exam taken",
                              style: AppTextStyle.smallTextStyle.copyWith(
                                fontSize: 14,
                                color: AppColors.whiteColor,
                              ),
                            ),
                          ],
                        ),
                        ButtonView(
                          title: "Edit Profile",
                          height: 42,
                          width: 100,
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ProfileScreen(),
                            ));
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: profileItems.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 1,
                  ),
                  child: ListTile(
                    leading: Image.asset(
                      profileItems[index]["icon"],
                      color: AppColors.primaryColor,
                      scale: 19,
                    ),
                    title: Text(profileItems[index]["name"]),
                    trailing: profileItems[index]["isSwitch"]
                        ? CupertinoSwitch(
                            activeColor:
                                AppColors.primaryColor.withOpacity(0.6),
                            thumbColor: AppColors.primaryColor,
                            trackColor: AppColors.blackColor.withOpacity(0.2),
                            value: profileItems[index]["value"],
                            onChanged: (bool value) {
                              setState(() {
                                profileItems[index]["value"] = value;
                              });
                            },
                          )
                        : Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: AppColors.greyColor,
                            size: 17,
                          ),
                    shape: Border(
                      bottom: BorderSide(
                          color: AppColors.greyColor.withOpacity(0.4)),
                    ),
                  ),
                );
              },
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(25),
              child: ButtonView(
                title: "Log Out",
                onTap: () {
                  logOut();
                },
                containerColor: AppColors.primaryColor.withOpacity(0.3),
                titleColor: AppColors.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
