// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, non_constant_identifier_names, avoid_print

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

      print(userCredential.user!.uid);

      await LocalStorage.sharedPreferences.setBool(LocalStorage.logIn, true);

      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => BottomBarScreen(),
      ));
    } catch (e) {
      toastView(msg: "Email or password is incorrect");
      Navigator.of(context).pop();
    }
  }

  Future<void> signUp({
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

      String name = DateTime.now().millisecondsSinceEpoch.toString();
      String ext = imagePath.value.split("/").last.split(".").last;
  
      Reference reference = firebaseStorage.ref("$name.$ext");

      reference.putFile(File(imagePath.value));

      String url = await reference.getDownloadURL();

      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      await firebaseFirestore
          .collection("Teacher")
          .doc(userCredential.user!.uid)
          .set({
        "email": email,
        "phoneNo": phoneNo,
        "image": url,
      });

      LocalStorage.sharedPreferences.setBool(LocalStorage.logIn, true);

      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => BottomBarScreen(),
      ));
    } catch (e) {
      toastView(msg: "User is already exist");
      Navigator.of(context).pop();
    }
  }
}
