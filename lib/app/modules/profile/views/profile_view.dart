import 'dart:io';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:badges/badges.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:librarian/app/controllers/auth_controller.dart';
import 'package:librarian/app/data/models/user_model.dart';
import 'package:librarian/app/routes/app_pages.dart';
import 'package:librarian/app/utils/color.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  final GlobalKey<FormState> form = GlobalKey<FormState>();
  UserModel user = Get.arguments ?? UserModel();
  final authC = Get.find<AuthController>();

  Future<Null> refresh() async {
    await Future.delayed(Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    controller.modelToController(authC.user);
    print("userid = ${authC.user.id}");
    print("user = ${authC.user.email}");
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
          backgroundColor: primary,
          title: Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage("assets/icon.png"),
                backgroundColor: primary,
              ),
              SizedBox(
                width: 8,
              ),
              ShaderMask(
                shaderCallback: (bounds) => RadialGradient(
                        center: Alignment.center,
                        radius: 1.0,
                        colors: [clr_white, Color.fromARGB(255, 131, 170, 238)],
                        tileMode: TileMode.mirror)
                    .createShader(bounds),
                child: Text(
                  "Librarian",
                  style: TextStyle(color: clr_white),
                ),
              ),
            ],
          )),
      endDrawer: Drawer(
        backgroundColor: clr_white,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            width: double.infinity,
            height: 130,
            color: primary,
            child: Center(
              child: Column(
                children: [
                  Obx(
                    () => authC.user.image != null
                        ? AvatarGlow(
                            endRadius: 50.0,
                            glowColor: clr_white,
                            duration: Duration(seconds: 1),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  height: 80,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    color: primary,
                                    borderRadius: BorderRadius.circular(80 / 2),
                                  ),
                                ),
                                Container(
                                  height: 70,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(authC.user.image!),
                                        fit: BoxFit.cover),
                                    border: Border.all(
                                        color: Colors.white10, width: 3),
                                    borderRadius:
                                        BorderRadius.circular(100 / 2),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : AvatarGlow(
                            endRadius: 50.0,
                            glowColor: secondary,
                            duration: Duration(seconds: 1),
                            child: Material(
                              elevation: 6.0,
                              shape: CircleBorder(),
                              child:
                                  Icon(Icons.person, size: 80, color: primary),
                            ),
                          ),
                  ),
                  Obx(() => SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(
                          authC.user.username ?? "Username",
                          style: TextStyle(color: clr_white, fontSize: 20),
                        ),
                      )),
                ],
              ),
            ),
            alignment: Alignment.topCenter,
            padding: EdgeInsets.only(left: 10),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ListTile(
                  onTap: () => Get.toNamed(Routes.PROFILE),
                  leading: Icon(
                    Icons.person,
                    color: primary,
                  ),
                  title: Text(
                    "Profile",
                    style: TextStyle(color: primary),
                  ),
                ),
                ListTile(
                  onTap: () => Get.defaultDialog(
                    title: "Notifications",
                    middleText: "This is Notifications",
                    titleStyle: TextStyle(color: primary),
                    middleTextStyle: TextStyle(color: primary),
                    textConfirm: "Okay",
                    onConfirm: () => Get.back(),
                    confirmTextColor: clr_white,
                    buttonColor: primary,
                  ),
                  leading: Icon(
                    Icons.notifications,
                    color: primary,
                  ),
                  title: Text(
                    "Notifications",
                    style: TextStyle(color: primary),
                  ),
                ),
                ListTile(
                  onTap: () => Get.defaultDialog(
                    title: "Help",
                    middleText: "This is Help",
                    titleStyle: TextStyle(color: primary),
                    middleTextStyle: TextStyle(color: primary),
                    textConfirm: "Okay",
                    onConfirm: () => Get.back(),
                    confirmTextColor: clr_white,
                    buttonColor: primary,
                  ),
                  leading: Icon(
                    Icons.info_outline,
                    color: primary,
                  ),
                  title: Text(
                    "Help",
                    style: TextStyle(color: primary),
                  ),
                ),
                ListTile(
                  onTap: () => authC.logout(),
                  leading: Icon(
                    Icons.logout,
                    color: primary,
                  ),
                  title: Text(
                    "Logout",
                    style: TextStyle(color: primary),
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
      body: RefreshIndicator(
        color: primary,
        onRefresh: refresh,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: form,
                child: SingleChildScrollView(
                  child: Column(children: [
                    Stack(
                      children: [
                        Container(
                          height: 280,
                          child: SvgPicture.asset("assets/bg.svg",
                              fit: BoxFit.cover),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Obx(
                                        () => controller.imagePath.value != ''
                                            ? AvatarGlow(
                                                endRadius: 50.0,
                                                glowColor: clr_white,
                                                duration: Duration(seconds: 1),
                                                child: Stack(
                                                  alignment: Alignment.center,
                                                  children: [
                                                    Container(
                                                      height: 90,
                                                      width: 90,
                                                      decoration: BoxDecoration(
                                                        color: primary,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    90 / 2),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        if (controller.edit ==
                                                            true) {
                                                          controller
                                                              .pickImage();
                                                        } else {
                                                          Get.defaultDialog(
                                                            title: "Warning",
                                                            middleText:
                                                                "You must turn on edit mode",
                                                            titleStyle:
                                                                TextStyle(
                                                                    color:
                                                                        primary),
                                                            middleTextStyle:
                                                                TextStyle(
                                                                    color:
                                                                        primary),
                                                            onConfirm: () =>
                                                                Get.back(),
                                                            buttonColor:
                                                                primary,
                                                            textConfirm: "Okay",
                                                          );
                                                        }
                                                      },
                                                      child: Badge(
                                                        badgeColor: clr_white,
                                                        position: BadgePosition
                                                            .bottomEnd(),
                                                        badgeContent: Icon(
                                                          Icons
                                                              .camera_enhance_outlined,
                                                          color: primary,
                                                        ),
                                                        child: Container(
                                                          height: 80,
                                                          width: 80,
                                                          decoration:
                                                              BoxDecoration(
                                                            image: DecorationImage(
                                                                image: FileImage(
                                                                    File(controller
                                                                        .imagePath
                                                                        .value)),
                                                                fit: BoxFit
                                                                    .cover),
                                                            border: Border.all(
                                                                color:
                                                                    clr_white,
                                                                width: 3),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        90 / 2),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : authC.user.image != null
                                                ? AvatarGlow(
                                                    endRadius: 50.0,
                                                    glowColor: clr_white,
                                                    duration:
                                                        Duration(seconds: 1),
                                                    child: Stack(
                                                      alignment:
                                                          Alignment.center,
                                                      children: [
                                                        Container(
                                                          height: 90,
                                                          width: 90,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: primary,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        90 / 2),
                                                          ),
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            if (controller
                                                                    .edit ==
                                                                true) {
                                                              controller
                                                                  .pickImage();
                                                            } else {
                                                              Get.defaultDialog(
                                                                title:
                                                                    "Warning",
                                                                middleText:
                                                                    "You must turn on edit mode",
                                                                titleStyle:
                                                                    TextStyle(
                                                                        color:
                                                                            primary),
                                                                middleTextStyle:
                                                                    TextStyle(
                                                                        color:
                                                                            primary),
                                                                onConfirm: () =>
                                                                    Get.back(),
                                                                buttonColor:
                                                                    primary,
                                                                textConfirm:
                                                                    "Okay",
                                                              );
                                                            }
                                                          },
                                                          child: Badge(
                                                            badgeColor:
                                                                clr_white,
                                                            position:
                                                                BadgePosition
                                                                    .bottomEnd(),
                                                            badgeContent: Icon(
                                                              Icons
                                                                  .camera_enhance_outlined,
                                                              color: primary,
                                                            ),
                                                            child: Container(
                                                              height: 80,
                                                              width: 80,
                                                              decoration:
                                                                  BoxDecoration(
                                                                image: DecorationImage(
                                                                    image: FileImage(File(controller
                                                                        .imagePath
                                                                        .value)),
                                                                    fit: BoxFit
                                                                        .cover),
                                                                border: Border.all(
                                                                    color:
                                                                        clr_white,
                                                                    width: 3),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            90 /
                                                                                2),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                : AvatarGlow(
                                                    endRadius: 50.0,
                                                    glowColor: clr_white,
                                                    duration:
                                                        Duration(seconds: 1),
                                                    child: InkWell(
                                                      onTap: () {
                                                        if (controller.edit ==
                                                            true) {
                                                          controller
                                                              .pickImage();
                                                        } else {
                                                          Get.defaultDialog(
                                                            title: "Warning",
                                                            middleText:
                                                                "You must turn on edit mode",
                                                            titleStyle:
                                                                TextStyle(
                                                                    color:
                                                                        primary),
                                                            middleTextStyle:
                                                                TextStyle(
                                                                    color:
                                                                        primary),
                                                            onConfirm: () =>
                                                                Get.back(),
                                                            buttonColor:
                                                                primary,
                                                            textConfirm: "Okay",
                                                          );
                                                        }
                                                      },
                                                      child: Badge(
                                                        badgeColor: clr_white,
                                                        position: BadgePosition
                                                            .bottomEnd(),
                                                        badgeContent: Icon(
                                                          Icons
                                                              .camera_enhance_outlined,
                                                          color: primary,
                                                        ),
                                                        child: Container(
                                                          height: 80,
                                                          width: 80,
                                                          decoration:
                                                              BoxDecoration(
                                                            image: DecorationImage(
                                                                image: FileImage(
                                                                    File(controller
                                                                        .imagePath
                                                                        .value)),
                                                                fit: BoxFit
                                                                    .cover),
                                                            border: Border.all(
                                                                color:
                                                                    clr_white,
                                                                width: 3),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        90 / 2),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Container(
                                          width: 170,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Obx(() =>
                                                  Text(authC.user.username!)),
                                              Obx(() =>
                                                  Text(authC.user.email!)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  InkWell(
                                    onTap: () {
                                      controller.edit.value = true;
                                      if (controller.edit.value == true) {
                                        Get.defaultDialog(
                                            title: "Edit Mode",
                                            titleStyle:
                                                TextStyle(color: primary),
                                            middleText: "Edit mode is on",
                                            middleTextStyle:
                                                TextStyle(color: primary),
                                            textConfirm: "Okay",
                                            onConfirm: () => Get.back(),
                                            confirmTextColor: clr_white,
                                            buttonColor: primary);
                                      }
                                    },
                                    child: Card(
                                      color: clr_white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 4, horizontal: 4),
                                          child: Icon(
                                            Icons.edit,
                                            color: primary,
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    height: 80,
                                    width: 140,
                                    decoration: BoxDecoration(
                                      color: clr_white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: Column(
                                          children: [
                                            Text(
                                              "Total Book",
                                              style: TextStyle(color: primary),
                                            ),
                                            Obx(() => Text(
                                                  controller.books.length
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: primary,
                                                      fontSize: 40),
                                                )),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 80,
                                    width: 140,
                                    decoration: BoxDecoration(
                                      color: clr_white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: Column(
                                          children: [
                                            Text(
                                              "Total Progress",
                                              style: TextStyle(color: primary),
                                            ),
                                            Text(
                                              "100%",
                                              style: TextStyle(
                                                  color: primary, fontSize: 40),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                        child: Text(
                      "User Profile",
                      style: TextStyle(color: primary, fontSize: 30),
                    )),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: Column(children: [
                        Obx(() => TextField(
                            enabled: controller.edit.value,
                            showCursor: true,
                            cursorColor: primary,
                            style: TextStyle(color: primary),
                            textInputAction: TextInputAction.done,
                            controller: controller.nameC,
                            decoration: InputDecoration(
                              hintText: "Input your name",
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
                            ))),
                        SizedBox(
                          height: 15,
                        ),
                        Obx(() => ListTile(
                              enabled: controller.edit.value,
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
                              textColor: primary,
                            )),
                        Divider(
                          color: primary,
                          height: 0,
                          thickness: 1,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        FormField<int>(
                          validator: (value) => controller.selectedGender > 0
                              ? null
                              : "This field is required",
                          builder: (gender) => Obx(
                            () => ListTile(
                              enabled: controller.edit.value,
                              visualDensity: VisualDensity.compact,
                              title: Text(
                                "Gender",
                                style: TextStyle(color: primary),
                              ),
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
                                          title: Text(
                                            "Male",
                                            style: TextStyle(color: primary),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: RadioListTile<int>(
                                          activeColor: primary,
                                          selectedTileColor: primary,
                                          value: 2,
                                          groupValue: controller.selectedGender,
                                          onChanged: (value) => controller
                                              .selectedGender = value ?? 0,
                                          title: Text(
                                            "Female",
                                            style: TextStyle(color: primary),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (gender.hasError)
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        gender.errorText!,
                                        style:
                                            TextStyle(color: red, fontSize: 12),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        TextFormField(
                            enabled: false,
                            showCursor: true,
                            cursorColor: primary,
                            style: TextStyle(color: primary),
                            textInputAction: TextInputAction.next,
                            controller: controller.emailC,
                            decoration: InputDecoration(
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
                            // enabled: false,
                            readOnly: true,
                            showCursor: true,
                            cursorColor: primary,
                            style: TextStyle(color: primary),
                            keyboardType: TextInputType.visiblePassword,
                            controller: controller.passC,
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
                        SizedBox(
                          height: 20,
                        ),
                      ]),
                    ),
                    Obx(
                      () => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: Get.width,
                          child: FloatingActionButton.extended(
                              backgroundColor: primary,
                              onPressed: controller.isSaving
                                  ? null
                                  : () {
                                      if (form.currentState!.validate()) {
                                        if (controller.edit == true) {
                                          controller.store(authC.user);
                                          controller.edit.value = false;
                                        } else {
                                          Get.defaultDialog(
                                            title: "Warning",
                                            middleText:
                                                "You must turn on edit mode",
                                            titleStyle:
                                                TextStyle(color: primary),
                                            middleTextStyle:
                                                TextStyle(color: primary),
                                            onConfirm: () => Get.back(),
                                            buttonColor: primary,
                                            textConfirm: "Okay",
                                          );
                                        }
                                      }
                                    },
                              label: controller.isSaving
                                  ? Text(
                                      "Loading...",
                                      style: TextStyle(color: clr_white),
                                    )
                                  : Text(
                                      "Update Profile",
                                      style: TextStyle(color: clr_white),
                                    )),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: clr_white,
        style: TabStyle.reactCircle,
        color: primary,
        activeColor: primary,
        items: [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.person, title: 'Profile'),
        ],
        onTap: (index) {
          if (index == 0) {
            Get.toNamed(Routes.HOME);
          } else if (index == 1) {
            Get.toNamed(Routes.PROFILE);
          }
        },
        initialActiveIndex: 1,
      ),
    );
  }
}

// Center(
                //   child: AvatarGlow(
                //     endRadius: 60.0,
                //     glowColor: purple,
                //     duration: Duration(seconds: 1),
                //     child: Material(
                //       elevation: 6.0,
                //       shape: CircleBorder(),
                //       child: Icon(Icons.person, size: 80, color: lightpurple),
                //     ),
                //   ),
                // ),
                // Text(
                //   "Change Profile Picture",
                //   style: TextStyle(color: clr_white, fontSize: 20),
                // ),
                // SizedBox(height: 20),
                // TextField(
                //   readOnly: true,
                //   showCursor: true,
                //   cursorColor: clr_white,
                //   style: TextStyle(color: clr_white),
                //   autocorrect: false,
                //   textInputAction: TextInputAction.next,
                //   decoration: InputDecoration(
                //     hintText: "Input your email",
                //     hintStyle: TextStyle(color: clr_white),
                //     focusedBorder:
                //         OutlineInputBorder(borderSide: BorderSide(color: clr_white)),
                //     enabledBorder:
                //         OutlineInputBorder(borderSide: BorderSide(color: clr_white)),
                //     disabledBorder:
                //         OutlineInputBorder(borderSide: BorderSide(color: clr_white)),
                //     label: Row(children: [
                //       Icon(
                //         Icons.email,
                //         color: clr_white,
                //       ),
                //       SizedBox(
                //         width: 5,
                //       ),
                //       Text(
                //         "Email",
                //         style: TextStyle(color: clr_white),
                //       ),
                //     ]),
                //     border:
                //         OutlineInputBorder(borderSide: BorderSide(color: clr_white)),
                //   ),
                // ),
                // SizedBox(
                //   height: 20,
                // ),
                // Obx(() => TextField(
                //   readOnly: true,
                //     showCursor: true,
                //     cursorColor: clr_white,
                //     style: TextStyle(color: clr_white),
                //     keyboardType: TextInputType.visiblePassword,
                //     obscureText: controller.hidden.value,
                //     decoration: InputDecoration(
                //       suffixIcon: IconButton(
                //         icon: Icon(
                //           Icons.remove_red_eye,
                //           color: clr_white,
                //         ),
                //         onPressed: () {
                //           controller.hidden.toggle();
                //         },
                //       ),
                //       hintText: "Input your password",
                //       hintStyle: TextStyle(color: clr_white),
                //       focusedBorder: OutlineInputBorder(
                //           borderSide: BorderSide(color: clr_white)),
                //       enabledBorder: OutlineInputBorder(
                //           borderSide: BorderSide(color: clr_white)),
                //       disabledBorder: OutlineInputBorder(
                //           borderSide: BorderSide(color: clr_white)),
                //       label: Row(
                //         children: [
                //           Icon(
                //             Icons.lock,
                //             color: clr_white,
                //           ),
                //           SizedBox(
                //             width: 5,
                //           ),
                //           Text(
                //             "Password",
                //             style: TextStyle(color: clr_white),
                //           )
                //         ],
                //       ),
                //       border: OutlineInputBorder(
                //           borderSide: BorderSide(color: clr_white)),
                //     ))),
                // SizedBox(
                //   height: 20,
                // ),
                // TextField(
                //   showCursor: true,
                //   cursorColor: clr_white,
                //   style: TextStyle(color: clr_white),
                //   autocorrect: false,
                //   textInputAction: TextInputAction.next,
                //   decoration: InputDecoration(
                //     hintText: "Input your username",
                //     hintStyle: TextStyle(color: clr_white),
                //     focusedBorder:
                //         OutlineInputBorder(borderSide: BorderSide(color: clr_white)),
                //     enabledBorder:
                //         OutlineInputBorder(borderSide: BorderSide(color: clr_white)),
                //     disabledBorder:
                //         OutlineInputBorder(borderSide: BorderSide(color: clr_white)),
                //     label: Row(children: [
                //       Icon(
                //         Icons.person,
                //         color: clr_white,
                //       ),
                //       SizedBox(
                //         width: 5,
                //       ),
                //       Text(
                //         "Username",
                //         style: TextStyle(color: clr_white),
                //       ),
                //     ]),
                //     border:
                //         OutlineInputBorder(borderSide: BorderSide(color: clr_white)),
                //   ),
                // ),
                // SizedBox(height: 20),
                // Container(
                //   width: 150,
                //   child: ElevatedButton(
                //       style: ElevatedButton.styleFrom(
                //           shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(20),
                //       )),
                //       onPressed: () {},
                //       child: Text("Update Profile")),
                // ),


// Align(
                            //     alignment: Alignment.center,
                            //     child: Text(
                            //       "Book Cover",
                            //       style: TextStyle(color: clr_white, fontSize: 20),
                            //     )),
                            // SizedBox(
                            //   height: 8,
                            // ),
                            // Obx(() =>
                            //     controller.imagePath.value != ''
                            //         ? Padding(
                            //             padding: const EdgeInsets.all(10),
                            //             child: Container(
                            //               width: 400,
                            //               height: 200,
                            //               child: Image.file(
                            //                 File(
                            //                     controller.imagePath.value),
                            //                 fit: BoxFit.cover,
                            //               ),
                            //               decoration: BoxDecoration(
                            //                 color: clr_white,
                            //                 borderRadius:
                            //                     BorderRadius.circular(20),
                            //               ),
                            //             ),
                            //           )
                            //         : user.image != null
                            //             ? Padding(
                            //                 padding:
                            //                     const EdgeInsets.all(10),
                            //                 child: Container(
                            //                   width: 400,
                            //                   height: 200,
                            //                   child: Image.network(
                            //                     user.image!,
                            //                     fit: BoxFit.cover,
                            //                   ),
                            //                   decoration: BoxDecoration(
                            //                     color: clr_white,
                            //                     borderRadius:
                            //                         BorderRadius.circular(
                            //                             20),
                            //                   ),
                            //                 ),
                            //               )
                            //             : Padding(
                            //                 padding:
                            //                     const EdgeInsets.all(10),
                            //                 child: Container(
                            //                   width: 400,
                            //                   height: 200,
                            //                   child: Center(
                            //                       child: Image(
                            //                           image: AssetImage(
                            //                               "assets/default.png"))),
                            //                   decoration: BoxDecoration(
                            //                     color: clr_white,
                            //                     borderRadius:
                            //                         BorderRadius.circular(
                            //                             20),
                            //                   ),
                            //                 ),
                            //               )),