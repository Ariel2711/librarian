import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:librarian/app/controllers/auth_controller.dart';
import 'package:librarian/app/utils/color.dart';
import 'package:lottie/lottie.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseStorage.instance;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final authC = Get.put(AuthController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: authC.streamAuth(),
      builder: (context, s) {
        if (s.connectionState == ConnectionState.active) {
          return GetMaterialApp(
            theme: ThemeData(
              brightness: Brightness.light,
              backgroundColor: background,
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: clr_white,
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  primary: primary,
                ),
              ),
              appBarTheme: AppBarTheme(backgroundColor: secondary),
              textTheme: TextTheme(
                bodyText2: TextStyle(color: clr_white),
              ),
            ),
            debugShowCheckedModeBanner: false,
            title: "Librarian",
            initialRoute: s.data != null ? Routes.HOME : Routes.INTRO,
            getPages: AppPages.routes,
          );
        }
        return Center(
          child: Lottie.asset("assets/lottie/loading.json"),
        );
      },
    );
  }
}
