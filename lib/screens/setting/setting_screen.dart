// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teacherexam/controller/auth_controller.dart';
import 'package:teacherexam/controller/exam_detail_controller.dart';
import 'package:teacherexam/screens/splash_screen.dart';
import 'package:teacherexam/widgets/common_widgets/indicator_view.dart';
import 'package:url_launcher/url_launcher.dart';
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
  ExamDetailController examDetailController = Get.put(ExamDetailController());

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

  List settingItems = [
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
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  authController.userData["name"],
                                  style: AppTextStyle.largeTextStyle.copyWith(
                                    fontSize: 35,
                                    color: AppColors.whiteColor,
                                  ),
                                  overflow: TextOverflow.ellipsis,
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
                          ),
                          Container(
                            height: 75,
                            width: 75,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.whiteColor,
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                CircularProgressIndicator(
                                  color: AppColors.primaryColor,
                                  strokeWidth: 2,
                                ),
                                Container(
                                  height: 75,
                                  width: 75,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
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
                              examDetailController.historyScreenExam.length
                                  .toString(),
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
              itemCount: settingItems.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 1,
                  ),
                  child: InkWell(
                    onTap: () async {
                      if (index == 0) {
                        final Uri _url = Uri.parse(
                            "https://doc-hosting.flycricket.io/quiz-up-privacy-policy/9b5208c7-80bc-4e74-8d1f-796fd7ae4d4b/privacy");

                        if (!await launchUrl(_url)) {
                          throw Exception("Could not launch $_url");
                        }
                      } else {
                        final Uri emailLaunchUri = Uri(
                          scheme: "mailto",
                          path: "yashsakhwala@gmail.com",
                        );

                        await launchUrl(emailLaunchUri);
                      }
                    },
                    child: ListTile(
                      leading: Image.asset(
                        settingItems[index]["icon"],
                        color: AppColors.primaryColor,
                        scale: 19,
                      ),
                      title: Text(settingItems[index]["name"]),
                      trailing: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: AppColors.greyColor,
                        size: 17,
                      ),
                      shape: Border(
                        bottom: BorderSide(
                            color: AppColors.greyColor.withOpacity(0.4)),
                      ),
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
