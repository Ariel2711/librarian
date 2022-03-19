import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:librarian/app/controllers/auth_controller.dart';
import 'package:librarian/app/routes/app_pages.dart';
import 'package:librarian/app/utils/color.dart';
import 'package:lottie/lottie.dart';
import '../controllers/reset_controller.dart';

class ResetView extends GetView<ResetController> {
  final authC = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      // appBar: AppBar(
      //   title: Text('Reset'),
      //   centerTitle: true,
      // ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    children: [
                      Icon(
                        Icons.arrow_back,
                        color: primary,
                      ),
                      TextButton(
                          onPressed: () => Get.back(),
                          child: Text("Back",
                              style: TextStyle(
                                  color: primary, fontSize: 20))),
                    ],
                  )),
              Container(
                width: 200,
                height: 200,
                child: Lottie.asset("assets/lottie/password.json"),
              ),
              SizedBox(
                height: 50,
              ),
              TextField(
                  showCursor: true,
                  cursorColor: primary,
                  style: TextStyle(color: primary),
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.emailAddress,
                  controller: controller.emailC,
                  decoration: InputDecoration(
                    hintText: "Input your email address",
                    hintStyle: TextStyle(color: primary),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: primary)),

                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: primary)),

                    disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: primary)),
                    label: Row(children: [
                      Icon(
                        Icons.email,
                        color: primary,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Email",
                        style: TextStyle(color: primary),
                      ),
                    ]),
                    // labelText: "Email",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: primary)),
                  )),
              SizedBox(
                height: 20,
              ),
              Container(
                width: 150,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
                    onPressed: () {
                      authC.reset(controller.emailC.text);
                    },
                    child: Text("Submit")),
              ),
              SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: () => Get.toNamed(Routes.LOGIN),
                child: Text("Already have account? Login here", style: TextStyle(color: blue)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
