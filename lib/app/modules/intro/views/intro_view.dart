import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:librarian/app/routes/app_pages.dart';
import 'package:librarian/app/utils/color.dart';
import 'package:lottie/lottie.dart';
import '../controllers/intro_controller.dart';

class IntroView extends GetView<IntroController> {
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      globalBackgroundColor: background,
      pages: [
        PageViewModel(
            title: "Welcome Librarian",
            body: "An application that is perfect for you a book lover",
            image: Center(
              child: Lottie.asset("assets/lottie/book.json"),
            ),
            decoration: PageDecoration(
                titlePadding: EdgeInsets.all(20),
                imagePadding: EdgeInsets.all(20),
                titleTextStyle: TextStyle(color: primary, fontSize: 30),
                bodyTextStyle: TextStyle(color: primary, fontSize: 20))),
        PageViewModel(
          title: "Login",
          body: "Login to start!!!",
          image: Center(
            child: Lottie.asset("assets/lottie/login.json"),
          ),
          decoration: PageDecoration(
            titlePadding: EdgeInsets.all(20),
            imagePadding: EdgeInsets.all(20),
            titleTextStyle: TextStyle(color: primary, fontSize: 30),
            bodyTextStyle: TextStyle(color: primary, fontSize: 25),
          ),
        ),
      ],
      showNextButton: true,
      next: Text(
        "Next",
        style: TextStyle(
          color: primary,
          fontWeight: FontWeight.w600,
        ),
      ),
      onDone: () {
        Get.toNamed(Routes.LOGIN);
      },
      onSkip: () {
        Get.toNamed(Routes.LOGIN);
      },
      showBackButton: false,
      showSkipButton: true,
      skip: const Text("Skip",
          style: TextStyle(fontWeight: FontWeight.w600, color: primary)),
      back: const Icon(
        Icons.arrow_back,
        color: primary,
      ),
      done: const Text("Login",
          style: TextStyle(fontWeight: FontWeight.w600, color: primary)),
    );
  }
}
