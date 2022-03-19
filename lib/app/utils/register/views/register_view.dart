// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:librarian/app/controllers/auth_controller.dart';
// import 'package:librarian/app/utils/color.dart';
// import 'package:lottie/lottie.dart';
// import '../controllers/register_controller.dart';

// class RegisterView extends GetView<RegisterController> {
//   final authC = Get.find<AuthController>();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         // appBar: AppBar(
//         //   title: Text('Register'),
//         //   centerTitle: true,
//         // ),
//         body: Center(
//       child: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             children: [
//               Container(
//                 width: 200,
//                 height: 200,
//                 child: Lottie.asset("assets/lottie/register.json"),
//               ),
//               SizedBox(
//                 height: 30,
//               ),
//               TextField(
//                   showCursor: true,
//                   cursorColor: lightpurple,
//                   style: TextStyle(color: lightpurple),
//                   textInputAction: TextInputAction.next,
//                   keyboardType: TextInputType.emailAddress,
//                   controller: controller.emailC,
//                   decoration: InputDecoration(
//                     hintText: "Input your email address",
//                     hintStyle: TextStyle(color: lightpurple),
//                     focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: lightpurple)),
//                     enabledBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: lightpurple)),
//                     disabledBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: lightpurple)),
//                     label: Row(children: [
//                       Icon(
//                         Icons.email,
//                         color: lightpurple,
//                       ),
//                       SizedBox(
//                         width: 5,
//                       ),
//                       Text(
//                         "Email",
//                         style: TextStyle(color: lightpurple),
//                       ),
//                     ]),
//                     border: OutlineInputBorder(
//                         borderSide: BorderSide(color: lightpurple)),
//                   )),
//               SizedBox(
//                 height: 20,
//               ),
//               Obx(() => TextField(
//                                 showCursor: true,
//                                 cursorColor: lightpurple,
//                                 style: TextStyle(color: lightpurple),
//                                 obscureText: controller.hidden.value,
//                                 keyboardType: TextInputType.visiblePassword,
//                                 controller: controller.passC,
//                                 decoration: InputDecoration(
//                                   suffixIcon: IconButton(
//                                     icon: Icon(
//                                       Icons.remove_red_eye,
//                                       color: lightpurple,
//                                     ),
//                                     onPressed: () {
//                                       controller.hidden.toggle();
//                                     },
//                                   ),
//                                   hintText: "Input your password",
//                                   hintStyle: TextStyle(color: lightpurple),
//                                   focusedBorder: OutlineInputBorder(
//                                       borderSide: BorderSide(color: lightpurple)),
//                                   enabledBorder: OutlineInputBorder(
//                                       borderSide: BorderSide(color: lightpurple)),
//                                   disabledBorder: OutlineInputBorder(
//                                       borderSide: BorderSide(color: lightpurple)),
//                                   label: Row(
//                                     children: [
//                                       Icon(
//                                         Icons.lock,
//                                         color: lightpurple,
//                                       ),
//                                       SizedBox(
//                                         width: 5,
//                                       ),
//                                       Text(
//                                         "Password",
//                                         style: TextStyle(color: lightpurple),
//                                       )
//                                     ],
//                                   ),
//                                   border: OutlineInputBorder(
//                                       borderSide: BorderSide(color: lightpurple)),
//                                 ))),
//               SizedBox(
//                 height: 10,
//               ),
//               Container(
//                 width: 150,
//                 child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                         shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20),
//                     )),
//                     onPressed: () {
//                       authC.signup(
//                           controller.emailC.text, controller.passC.text);
//                     },
//                     child: Text("Submit")),
//               ),
//               SizedBox(
//                 height: 5,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     "Already Have Account?",
//                     style: TextStyle(color: lightpurple),
//                   ),
//                   TextButton(
//                     onPressed: () => Get.back(),
//                     child: Text("Login Here", style: TextStyle(color: blue)),
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     ));
//   }
// }
