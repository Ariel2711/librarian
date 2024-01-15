// ignore_for_file: unused_catch_clause

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:librarian/app/data/database.dart';
import 'package:librarian/app/data/models/user_model.dart';
import 'package:librarian/app/routes/app_pages.dart';
import 'package:librarian/app/utils/color.dart';

class AuthController extends GetxController {
  RxBool hidden = true.obs;
  FirebaseAuth _auth = FirebaseAuth.instance;
  Stream<User?> streamAuth() => _auth.authStateChanges();

  var currUser = UserModel().obs;
  UserModel get user => currUser.value;
  set user(UserModel value) => currUser.value = value;

  var _isRegis = false.obs;
  bool get isRegis => _isRegis.value;
  set isRegis(value) => _isRegis.value = value;

  var _isSaving = false.obs;
  bool get isSaving => _isSaving.value;
  set isSaving(value) => _isSaving.value = value;

  var _selectedGender = 0.obs;
  int get selectedGender => _selectedGender.value;
  set selectedGender(int value) => _selectedGender.value = value;

  Rx<DateTime?> _selectedDate = DateTime(2000).obs;
  DateTime? get selectedDate => _selectedDate.value;
  set selectedDate(DateTime? value) => _selectedDate.value = value;

  handleBirthDate(dynamic context) async {
    selectedDate = await showDatePicker(
            context: context,
            initialDate: selectedDate ?? DateTime.now(),
            initialDatePickerMode: DatePickerMode.year,
            firstDate:
                DateTime(selectedDate?.year ?? DateTime.now().year - 100),
            lastDate: DateTime.now()) ??
        selectedDate;
  }

  late Rx<User?> firebaseUser;
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  TextEditingController nameC = TextEditingController();

  login() async {
    try {
      await _auth
          .signInWithEmailAndPassword(
              email: emailC.text, password: passwordC.text)
          .then((value) => Get.toNamed(Routes.HOME));
    } on FirebaseAuthException catch (e) {
      Get.defaultDialog(
          title: "Error",
          titleStyle: TextStyle(color: primary),
          middleText: "Login failed",
          middleTextStyle: TextStyle(color: primary),
          textConfirm: "Okay",
          onConfirm: () => Get.back(),
          confirmTextColor: clr_white,
          buttonColor: primary);
    } catch (e) {
      Get.defaultDialog(
          title: "Error",
          titleStyle: TextStyle(color: primary),
          middleText: "Login failed",
          middleTextStyle: TextStyle(color: primary),
          textConfirm: "Okay",
          onConfirm: () => Get.back(),
          confirmTextColor: clr_white,
          buttonColor: primary);
    }
  }

  register() async {
    try {
      isSaving = true;
      UserModel user = UserModel(
        username: nameC.text,
        email: emailC.text,
        password: passwordC.text,
        birth: selectedDate,
        gender: selectedGender,
        time: DateTime.now(),
      );

      _auth
          .createUserWithEmailAndPassword(
        email: emailC.text,
        password: passwordC.text,
      )
          .then((value) {
        user.id = value.user?.uid;
        if (user.id != null) {
          firestore
              .collection(userCollection)
              .doc(user.id)
              .set(user.toJson)
              .then((value) {
            Get.defaultDialog(
                title: "Succeed",
                titleStyle: TextStyle(color: primary),
                middleText: "Registration completed",
                middleTextStyle: TextStyle(color: primary),
                textConfirm: "Okay",
                onConfirm: () {
                  Get.toNamed(Routes.HOME);
                  nameC.clear();
                  passwordC.clear();
                  emailC.clear();
                  selectedGender = 0;
                  selectedDate = DateTime.now();
                },
                confirmTextColor: clr_white,
                buttonColor: primary);
          });
        }
      });
      isSaving = false;
    } on FirebaseAuthException catch (e) {
      isSaving = false;
      Get.defaultDialog(
          title: "Error",
          titleStyle: TextStyle(color: primary),
          middleText: e.message ?? e.code,
          middleTextStyle: TextStyle(color: primary),
          textConfirm: "Okay",
          onConfirm: () {
            Get.back();
            nameC.clear();
            passwordC.clear();
            emailC.clear();
            selectedGender = 0;
            selectedDate = DateTime.now();
          },
          confirmTextColor: clr_white,
          buttonColor: primary);
    }
  }

  void logout() async {
    Get.defaultDialog(
      title: "Logout",
      middleText: "Are you sure you want to logout?",
      onConfirm: () async {
        await FirebaseAuth.instance.signOut();
        Get.offAllNamed(Routes.LOGIN);
        hidden.value = true;
        isSaving = false;
        emailC.clear();
        passwordC.clear();
        nameC.clear();
        selectedGender = 0;
        selectedDate = DateTime.now();
      },
      textConfirm: "Yes",
      textCancel: "No",
      buttonColor: primary,
      confirmTextColor: clr_white,
      cancelTextColor: primary,
      titleStyle: TextStyle(color: primary),
      middleTextStyle: TextStyle(color: primary),
    );
  }

  void reset(String email) async {
    if (email != "" && GetUtils.isEmail(email)) {
      await _auth.sendPasswordResetEmail(email: email);
      Get.defaultDialog(
        title: "Succeed",
        middleText: "Successfully sent the reset password to your email",
        onConfirm: () {
          Get.back();
          Get.back();
        },
        textConfirm: "Okay",
        buttonColor: primary,
        confirmTextColor: clr_white,
        cancelTextColor: black,
        titleStyle: TextStyle(color: primary),
        middleTextStyle: TextStyle(color: primary),
      );
    } else {
      Get.defaultDialog(
        title: "Warning",
        middleText: "Invalid Email",
        textConfirm: "Okay",
        buttonColor: primary,
        confirmTextColor: clr_white,
        cancelTextColor: black,
        onConfirm: () => Get.back(),
        titleStyle: TextStyle(color: primary),
        middleTextStyle: TextStyle(color: primary),
      );
    }
  }

  streamUser(User? fuser) {
    if (fuser != null) {
      currUser.bindStream(UserModel().streamList(fuser.uid));
      print("auth id = " + fuser.uid);
      print("tojson =  ${user.toJson}");
    } else {
      print("null auth");
      user = UserModel();
      print("toJson =  ${user.toJson}");
    }
  }

  @override
  void onInit() {
    super.onInit();
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, streamUser);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    hidden.value = true;
    emailC.clear();
    passwordC.clear();
    nameC.clear();
    selectedGender = 0;
    selectedDate = DateTime.now();
  }
}

 
  // Stream<User?> streamAuth() {
  //   return auth.authStateChanges();
  // }

  // void signup(String email, String pass) async {
  //   try {
  //     final myuser = await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //       email: email,
  //       password: pass,
  //     );

  //     Get.defaultDialog(
  //       onConfirm: () async {
  //         await myuser.user!.sendEmailVerification();
  //         Get.back();
  //         Get.back();
  //       },
  //       buttonColor: primary,
  //       textConfirm: "Yes, I will verify my email",
  //       title: "Verification Email",
  //       middleText: "Please verify email",
  //       confirmTextColor: clr_white,
  //       cancelTextColor: black,
  //       titleStyle: TextStyle(color: primary),
  //       middleTextStyle: TextStyle(color: primary),
  //     );
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'weak-password') {
  //       print('The password provided is too weak.');
  //       Get.defaultDialog(
  //         title: "Warning",
  //         middleText: "The password provided is too weak.",
  //         textConfirm: "Okay",
  //         onConfirm: () => Get.back(),
  //         buttonColor: primary,
  //         confirmTextColor: clr_white,
  //         cancelTextColor: black,
  //         titleStyle: TextStyle(color: primary),
  //         middleTextStyle: TextStyle(color: primary),
  //       );
  //     } else if (e.code == 'email-already-in-use') {
  //       print('The account already exists for that email.');
  //       Get.defaultDialog(
  //         title: "Warning",
  //         middleText: "The account already exists for that email.",
  //         textConfirm: "Okay",
  //         onConfirm: () => Get.back(),
  //         buttonColor: purple,
  //         confirmTextColor: clr_white,
  //         cancelTextColor: black,
  //         titleStyle: TextStyle(color: primary),
  //         middleTextStyle: TextStyle(color: primary),
  //       );
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // void login(String email, String pass) async {
  //   try {
  //     final myuser = await auth.signInWithEmailAndPassword(
  //       email: email,
  //       password: pass,
  //     );
  //     if (myuser.user!.emailVerified) {
  //       Get.offAllNamed(Routes.HOME);
  //     } else {
  //       Get.defaultDialog(
  //         buttonColor: purple,
  //         title: "Failed Login",
  //         middleText: "Verify email first. Do you want to re-sent",
  //         onConfirm: () async {
  //           await myuser.user!.sendEmailVerification();
  //           Get.back();
  //         },
  //         textConfirm: "Yes",
  //         textCancel: "Cancel",
  //         confirmTextColor: clr_white,
  //         cancelTextColor: lightpurple,
  //         titleStyle: TextStyle(color: lightpurple),
  //         middleTextStyle: TextStyle(color: lightpurple),
  //       );
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'user-not-found') {
  //       print('No user found for that email.');
  //       Get.defaultDialog(
  //         title: "Warning",
  //         middleText: "No user found for that email.",
  //         textConfirm: "Okay",
  //         buttonColor: purple,
  //         confirmTextColor: clr_white,
  //         cancelTextColor: black,
  //         onConfirm: () => Get.back(),
  //         titleStyle: TextStyle(color: lightpurple),
  //         middleTextStyle: TextStyle(color: lightpurple),
  //       );
  //     } else if (e.code == 'wrong-password') {
  //       print('Wrong password provided for that user.');
  //       Get.defaultDialog(
  //         title: "Warning",
  //         middleText: "Wrong password provided for that user.",
  //         textConfirm: "Okay",
  //         buttonColor: purple,
  //         confirmTextColor: clr_white,
  //         cancelTextColor: black,
  //         onConfirm: () => Get.back(),
  //         titleStyle: TextStyle(color: lightpurple),
  //         middleTextStyle: TextStyle(color: lightpurple),
  //       );
  //     }
  //     Get.defaultDialog(
  //       title: "Warning",
  //       middleText: "No user found for that email.",
  //       textConfirm: "Okay",
  //       buttonColor: purple,
  //       confirmTextColor: clr_white,
  //       cancelTextColor: black,
  //       onConfirm: () => Get.back(),
  //       titleStyle: TextStyle(color: lightpurple),
  //       middleTextStyle: TextStyle(color: lightpurple),
  //     );
  //   }
  // }

  // void logout() async {
  //   Get.defaultDialog(
  //     title: "Logout",
  //     middleText: "Are you sure you want to logout?",
  //     onConfirm: () async {
  //       await FirebaseAuth.instance.signOut();
  //       Get.offAllNamed(Routes.LOGIN);
  //     },
  //     textConfirm: "Yes",
  //     textCancel: "No",
  //     buttonColor: purple,
  //     confirmTextColor: clr_white,
  //     cancelTextColor: lightpurple,
  //     titleStyle: TextStyle(color: lightpurple),
  //     middleTextStyle: TextStyle(color: lightpurple),
  //   );
  // }

  // void reset(String email) async {
  //   if (email != "" && GetUtils.isEmail(email)) {
  //     await auth.sendPasswordResetEmail(email: email);
  //     Get.defaultDialog(
  //       title: "Succeed",
  //       middleText: "Successfully sent the reset password to your email",
  //       onConfirm: () {
  //         Get.back();
  //         Get.back();
  //       },
  //       textConfirm: "Okay",
  //       buttonColor: purple,
  //       confirmTextColor: clr_white,
  //       cancelTextColor: black,
  //       titleStyle: TextStyle(color: lightpurple),
  //       middleTextStyle: TextStyle(color: lightpurple),
  //     );
  //   } else {
  //     Get.defaultDialog(
  //       title: "Warning",
  //       middleText: "Invalid Email",
  //       textConfirm: "Okay",
  //       buttonColor: purple,
  //       confirmTextColor: clr_white,
  //       cancelTextColor: black,
  //       onConfirm: () => Get.back(),
  //       titleStyle: TextStyle(color: lightpurple),
  //       middleTextStyle: TextStyle(color: lightpurple),
  //     );
  //   }
  // }
