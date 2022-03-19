import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
   final emailC = TextEditingController();
  final passC = TextEditingController();
  RxBool hidden = true.obs;

  @override
  void onClose() {
    emailC.dispose();
    passC.dispose();    super.onClose();
  }
}
