// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, avoid_print

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../config/local_storage.dart';
import '../screens/bottom_bar/bottom_bar_screen.dart';
import '../widgets/common_widgets/indicator_view.dart';
import '../widgets/common_widgets/toast_view.dart';

class AuthController extends GetxController {
  final RxBool isLoginPasswordShow = true.obs;
  final RxBool isSignUpPasswordShow = true.obs;
  final RxBool isVerifyPasswordShow = true.obs;
  final RxString imagePath = "".obs;
  final RxMap<String, dynamic> userData = <String, dynamic>{}.obs;

  Future<void> logIn({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      indicatorView(context);

      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

      final UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      await LocalStorage.sharedPreferences.setBool(LocalStorage.logIn, true);
      await LocalStorage.sharedPreferences
          .setString(LocalStorage.userId, userCredential.user!.uid);

      await getProfileData(context: context);

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => BottomBarScreen(),
          ),
          (route) => false);
    } catch (e) {
      toastView(msg: "Email or password is incorrect");
      Navigator.of(context).pop();
    }
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
    required String phoneNo,
    required BuildContext context,
  }) async {
    try {
      indicatorView(context);

      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

      final UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      print(userCredential.user!.uid);

      FirebaseStorage firebaseStorage = FirebaseStorage.instance;

      String url = "";

      String imageName = DateTime.now().millisecondsSinceEpoch.toString();
      String imageExt = imagePath.value.split("/").last.split(".").last;

      Reference reference = firebaseStorage.ref("$imageName.$imageExt");

      UploadTask uploadTask = reference.putFile(File(imagePath.value));

      TaskSnapshot taskSnapshot = await uploadTask;
      if (taskSnapshot.state == TaskState.success) {
        url = await reference.getDownloadURL();
      } else {
        toastView(msg: "File doesn't upload");
      }

      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      await firebaseFirestore
          .collection("Teacher")
          .doc(userCredential.user!.uid)
          .set({
        "name": name,
        "email": email,
        "phoneNo": phoneNo,
        "image": url,
      });

      await LocalStorage.sharedPreferences.setBool(LocalStorage.logIn, true);
      await LocalStorage.sharedPreferences
          .setString(LocalStorage.userId, userCredential.user!.uid);

      getProfileData(context: context);
    } catch (e) {
      toastView(msg: "User is already exist");
      Navigator.of(context).pop();
    }
  }

  Future<void> getProfileData({required BuildContext context}) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    String? userId =
        LocalStorage.sharedPreferences.getString(LocalStorage.userId);

    var data = await firebaseFirestore.collection("Teacher").doc(userId).get();

    userData.value = data.data() ?? {};

    print(data.data());

    Future.delayed(
      Duration(seconds: 4),
      () {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => BottomBarScreen(),
            ),
            (route) => false);
      },
    );
  }

  Future<void> updateProfile({
    required String name,
    required String email,
    required String phoneNo,
    required BuildContext context,
  }) async {
    try {
      indicatorView(context);

      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      String? userId =
          LocalStorage.sharedPreferences.getString(LocalStorage.userId);

      FirebaseStorage firebaseStorage = FirebaseStorage.instance;

      String url = "";
      if (imagePath.value.isNotEmpty) {
        String imageName = DateTime.now().millisecondsSinceEpoch.toString();
        String imageExt = imagePath.value.split("/").last.split(".").last;

        Reference reference = firebaseStorage.ref("$imageName.$imageExt");

        UploadTask uploadTask = reference.putFile(File(imagePath.value));

        TaskSnapshot taskSnapshot = await uploadTask;
        if (taskSnapshot.state == TaskState.success) {
          url = await reference.getDownloadURL();

          await firebaseFirestore.collection("Teacher").doc(userId).update({
            "image": url,
          });

          userData["image"] = url;
        } else {
          toastView(msg: "Failed to upload image");
        }
      }

      await firebaseFirestore.collection("Teacher").doc(userId).update({
        "name": name,
        "email": email,
        "phoneNo": phoneNo,
      });

      Map<String, dynamic> data = {
        "name": name,
        "email": email,
        "phoneNo": phoneNo,
        "image": imagePath.value.isNotEmpty ? url : userData["image"],
      };

      userData.value = data;

      toastView(msg: "Profile updated successfully");

      Navigator.of(context).pop();
    } catch (e) {
      toastView(msg: "Failed to update profile");

      Navigator.of(context).pop();
    }
  }
}
