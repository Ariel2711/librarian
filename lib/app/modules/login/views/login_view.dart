import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:librarian/app/controllers/auth_controller.dart';
import 'package:librarian/app/routes/app_pages.dart';
import 'package:librarian/app/utils/color.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';

class LoginView extends GetView<AuthController> {
  final authC = Get.find<AuthController>();
  GlobalKey<FormState> form = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Obx(
            () => Form(
              key: form,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset("assets/lottie/register.json"),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    child: Column(children: [
                      if (controller.isRegis)
                        TextField(
                            showCursor: true,
                            cursorColor: primary,
                            style: TextStyle(color: primary),
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            controller: controller.nameC,
                            decoration: InputDecoration(
                              hintText: "Input your username",
                              hintStyle: TextStyle(color: primary),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: primary)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: primary)),
                              disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: primary)),
                              label: Row(children: [
                                Icon(
                                  Icons.person,
                                  color: primary,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Username",
                                  style: TextStyle(color: primary),
                                ),
                              ]),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: primary)),
                            )),
                      if (controller.isRegis)
                        SizedBox(
                          height: 20,
                        ),
                      AppTextField(
                          textStyle: TextStyle(color: primary),
                          textFieldType: TextFieldType.EMAIL,
                          isValidationRequired: true,
                          showCursor: true,
                          cursorColor: primary,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
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
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: primary)),
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      Obx(() => TextField(
                          showCursor: true,
                          cursorColor: primary,
                          style: TextStyle(color: primary),
                          keyboardType: TextInputType.visiblePassword,
                          controller: controller.passwordC,
                          obscureText: controller.hidden.value,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(
                                Icons.remove_red_eye,
                                color: primary,
                              ),
                              onPressed: () {
                                controller.hidden.toggle();
                              },
                            ),
                            hintText: "Input your password",
                            hintStyle: TextStyle(color: primary),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: primary)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: primary)),
                            disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: primary)),
                            label: Row(
                              children: [
                                Icon(
                                  Icons.lock,
                                  color: primary,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Password",
                                  style: TextStyle(color: primary),
                                )
                              ],
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: primary)),
                          ))),
                    ]),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  if (controller.isRegis)
                    ListTile(
                      leading: Container(
                          width: 24,
                          alignment: Alignment.centerLeft,
                          child: Icon(
                            Icons.calendar_today,
                            color: primary,
                          )),
                      onTap: () async =>
                          await controller.handleBirthDate(context),
                      title: Text(
                        "Birth Date",
                        style: TextStyle(fontSize: 12, color: primary),
                      ),
                      subtitle: Text(controller.selectedDate is DateTime
                          ? DateFormat("EEE, dd MMM y")
                              .format(controller.selectedDate!)
                          : '--'),
                    ),
                  if (controller.isRegis)
                    Divider(
                      color: primary,
                      height: 0,
                      thickness: 1,
                    ),
                  SizedBox(
                    height: 10,
                  ),
                  if (controller.isRegis)
                    FormField<int>(
                      validator: (value) => controller.selectedGender > 0
                          ? null
                          : "This field is required",
                      builder: (gender) => Obx(
                        () => ListTile(
                          visualDensity: VisualDensity.compact,
                          title: Text("Gender"),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          subtitle: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: RadioListTile<int>(
                                      activeColor: primary,
                                      value: 1,
                                      groupValue: controller.selectedGender,
                                      onChanged: (value) => controller
                                          .selectedGender = value ?? 0,
                                      title: Text("Male", style: TextStyle(color: primary),),
                                    ),
                                  ),
                                  Expanded(
                                    child: RadioListTile<int>(
                                      activeColor: primary,
                                      value: 2,
                                      groupValue: controller.selectedGender,
                                      onChanged: (value) => controller
                                          .selectedGender = value ?? 0,
                                      title: Text("Female", style: TextStyle(color: primary),),
                                    ),
                                  ),
                                ],
                              ),
                              if (gender.hasError)
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    gender.errorText!,
                                    style: TextStyle(color: red, fontSize: 12),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  SizedBox(
                    height: 5,
                  ),
                  Obx(
                      () => AppButton(
                        shapeBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100)),
                        width: Get.width,
                        text: controller.isSaving ? "Loading..." : "Submit",
                        child: controller.isSaving
                            ? Text("Loading...")
                            : null,
                        color: primary,
                        textColor: clr_white,
                        onTap: controller.isSaving
                            ? null
                            : () async {
                                if (form.currentState!.validate()) {
                                  controller.isSaving = true;
                                  controller.isRegis
                                      ? await controller.register()
                                      : await controller.login();
                                  controller.isSaving = false;
                                }
                              },
                      ),
                    ),
                  TextButton(
                    onPressed: () {
                      controller.isRegis = !controller.isRegis;
                      controller.nameC.clear();
                      controller.passwordC.clear();
                      controller.emailC.clear();
                      controller.hidden.value = true;
                    },
                    style: ButtonStyle(visualDensity: VisualDensity.compact),
                    child: Text(controller.isRegis
                        ? "Already have account? Login here"
                        : "Doesn't Have Account? Register!"),
                  ),
                  TextButton(
                    style: ButtonStyle(visualDensity: VisualDensity.compact),
                    onPressed: () {},
                    child: TextButton(
                      child: Text("Forgot Password?"),
                      onPressed: () => Get.toNamed(Routes.RESET),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Center(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(20),
//             child: Column(
//               children: [
//                 Container(
//                   width: 200,
//                   height: 200,
//                   child: Lottie.asset("assets/lottie/login.json"),
//                 ),
//                 SizedBox(
//                   height: 30,
//                 ),
//                 TextField(
//                     showCursor: true,
//                     cursorColor: lightpurple,
//                     style: TextStyle(color: lightpurple),
//                     keyboardType: TextInputType.emailAddress,
//                     textInputAction: TextInputAction.next,
//                     controller: controller.emailC,
//                     decoration: InputDecoration(
//                       hintText: "Input your email address",
//                       hintStyle: TextStyle(color: lightpurple),
//                       focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: lightpurple)),
//                       enabledBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: lightpurple)),
//                       disabledBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: lightpurple)),
//                       label: Row(children: [
//                         Icon(
//                           Icons.email,
//                           color: lightpurple,
//                         ),
//                         SizedBox(
//                           width: 5,
//                         ),
//                         Text(
//                           "Email",
//                           style: TextStyle(color: lightpurple),
//                         ),
//                       ]),
//                       border: OutlineInputBorder(
//                           borderSide: BorderSide(color: lightpurple)),
//                     )),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Obx(() => TextField(
//                                     showCursor: true,
//                                     cursorColor: lightpurple,
//                                     style: TextStyle(color: lightpurple),
//                                     keyboardType: TextInputType.visiblePassword,
//                                     controller: controller.passC,
//                                     obscureText: controller.hidden.value,
//                                     decoration: InputDecoration(
//                                       suffixIcon: IconButton(
//                                         icon: Icon(
//                                           Icons.remove_red_eye,
//                                           color: lightpurple,
//                                         ),
//                                         onPressed: () {
//                                           controller.hidden.toggle();
//                                         },
//                                       ),
//                                       hintText: "Input your password",
//                                       hintStyle: TextStyle(color: lightpurple),
//                                       focusedBorder: OutlineInputBorder(
//                                           borderSide: BorderSide(color: lightpurple)),
//                                       enabledBorder: OutlineInputBorder(
//                                           borderSide: BorderSide(color: lightpurple)),
//                                       disabledBorder: OutlineInputBorder(
//                                           borderSide: BorderSide(color: lightpurple)),
//                                       label: Row(
//                                         children: [
//                                           Icon(
//                                             Icons.lock,
//                                             color: lightpurple,
//                                           ),
//                                           SizedBox(
//                                             width: 5,
//                                           ),
//                                           Text(
//                                             "Password",
//                                             style: TextStyle(color: lightpurple),
//                                           )
//                                         ],
//                                       ),
//                                       border: OutlineInputBorder(
//                                           borderSide: BorderSide(color: lightpurple)),
//                                     ))),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Container(
//                   width: 150,
//                   child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                           shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20),
//                       )),
//                       onPressed: () {
//                         authC.login(
//                             controller.emailC.text, controller.passC.text);
//                       },
//                       child: Text("Login")),
//                 ),
//                 SizedBox(
//                   height: 5,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       "Doesn't Have Account?",
//                       style: TextStyle(color: lightpurple),
//                     ),
//                     TextButton(
//                       onPressed: () => Get.toNamed(Routes.REGISTER),
//                       child: Text(
//                         "Register Here",
//                         style: TextStyle(color: blue),
//                       ),
//                     ),
//                   ],
//                 ),
//                 TextButton(
//                     onPressed: () {
//                       Get.toNamed(Routes.RESET);
//                     },
//                     child:
//                         Text("Forget Password", style: TextStyle(color: blue))),
//               ],
//             ),
//           ),
//         ),
//       ),



// SafeArea(
//         child: Container(
//           height: Get.height,
//           padding: EdgeInsets.all(16),
//           child: SingleChildScrollView(
//             child: Obx(
//               () => Form(
//                 key: _form,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     SvgPicture.asset(
//                       svgLogin,
//                       height: 200,
//                     ),
//                     16.height,
//                     BoxContainer(
//                       children: [
//                         if (controller.isRegis)
//                           AppTextField(
//                             controller: controller.nameC,
//                             textFieldType: TextFieldType.NAME,
//                             decoration: InputDecoration(
//                                 prefixIcon: Icon(Icons.person),
//                                 labelText: "Name"),
//                             isValidationRequired: true,
//                           ),
//                         if (controller.isRegis) 16.height,
//                         AppTextField(
//                           controller: controller.emailC,
//                           textFieldType: TextFieldType.EMAIL,
//                           decoration: InputDecoration(
//                               prefixIcon: Icon(Icons.email),
//                               labelText: "Email"),
//                           errorInvalidEmail: "Invalid Email",
//                         ),
//                         16.height,
//                         AppTextField(
//                           controller: controller.passwordC,
//                           isValidationRequired: true,
//                           textFieldType: TextFieldType.PASSWORD,
//                           decoration: InputDecoration(
//                               prefixIcon: Icon(Icons.lock),
//                               labelText: "Password",
//                               suffixIconColor: clr_primary),
//                         ),
//                         16.height,
//                         if (controller.isRegis)
//                           Column(
//                             children: [
//                               AppTextField(
//                                 controller: controller.confirmPasswordC,
//                                 validator: (value) =>
//                                     value == controller.passwordC.text
//                                         ? null
//                                         : "Password doesn't match",
//                                 isValidationRequired: true,
//                                 textFieldType: TextFieldType.PASSWORD,
//                                 decoration: InputDecoration(
//                                     prefixIcon: Icon(Icons.lock),
//                                     labelText: "Confirm Password",
//                                     suffixIconColor: clr_primary),
//                               ),
//                               16.height,
//                               ListTile(
//                                 leading: Container(
//                                     width: 24,
//                                     alignment: Alignment.centerLeft,
//                                     child: Icon(
//                                       Icons.calendar_today,
//                                       color: clr_primary,
//                                     )),
//                                 onTap: () async =>
//                                     await controller.handleBirthDate(context),
//                                 title: text("Birth Date", fontSize: 12),
//                                 subtitle: text(
//                                     controller.selectedDate is DateTime
//                                         ? DateFormat("EEE, dd MMM y")
//                                             .format(controller.selectedDate!)
//                                         : '--'),
//                               ),
//                               Divider(
//                                 color: clr_primary,
//                                 height: 0,
//                                 thickness: 1,
//                               ),
//                               16.height,
//                               FormField<int>(
//                                 validator: (value) =>
//                                     controller.selectedGender > 0
//                                         ? null
//                                         : "This field is required",
//                                 builder: (state) => Obx(
//                                   () => ListTile(
//                                     visualDensity: VisualDensity.compact,
//                                     title: text("Gender"),
//                                     shape: RoundedRectangleBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(15)),
//                                     subtitle: Column(
//                                       children: [
//                                         Row(
//                                           children: [
//                                             Expanded(
//                                               child: RadioListTile<int>(
//                                                 value: 10,
//                                                 groupValue:
//                                                     controller.selectedGender,
//                                                 onChanged: (value) =>
//                                                     controller.selectedGender =
//                                                         value ?? 0,
//                                                 title: text("Male"),
//                                               ),
//                                             ),
//                                             Expanded(
//                                               child: RadioListTile<int>(
//                                                 value: 20,
//                                                 groupValue:
//                                                     controller.selectedGender,
//                                                 onChanged: (value) =>
//                                                     controller.selectedGender =
//                                                         value ?? 0,
//                                                 title: text("Female"),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                         if (state.hasError)
//                                           Align(
//                                             alignment: Alignment.centerLeft,
//                                             child: text(state.errorText,
//                                                 color: Colors.red[900],
//                                                 fontSize: 12),
//                                           ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                       ],
//                     ),
//                     32.height,
//                     Obx(
//                       () => AppButton(
//                         shapeBorder: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(100)),
//                         width: Get.width,
//                         text: controller.isSaving ? "" : "Submit",
//                         child: controller.isSaving
//                             ? CircularProgressIndicator()
//                             : null,
//                         color: clr_primary,
//                         textColor: clr_white,
//                         onTap: controller.isSaving
//                             ? null
//                             : () async {
//                                 if (_form.currentState!.validate()) {
//                                   controller.isSaving = true;
//                                   controller.isRegis
//                                       ? await controller.signUp()
//                                       : await controller.signIn();
//                                   controller.isSaving = false;
//                                 }
//                                 // Get.toNamed(Routes.HOME);
//                               },
//                       ),
//                     ),
//                     // 16.height,
//                     TextButton(
//                       onPressed: () {
//                         controller.isRegis = !controller.isRegis;
//                       },
//                       style: ButtonStyle(visualDensity: VisualDensity.compact),
//                       child: Text(controller.isRegis
//                           ? "Already have account? Login here"
//                           : "Doesn't Have Account? Register!"),
//                     ),
//                     TextButton(
//                       style: ButtonStyle(visualDensity: VisualDensity.compact),
//                       onPressed: () {},
//                       child: Text("Forgot Password?"),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );