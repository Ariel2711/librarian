// ignore_for_file: must_be_immutable

import 'package:avatar_glow/avatar_glow.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:librarian/app/controllers/auth_controller.dart';
import 'package:librarian/app/data/models/book_model.dart';
import 'package:librarian/app/data/models/read_model.dart';
import 'package:librarian/app/routes/app_pages.dart';
import 'package:librarian/app/utils/color.dart';
import '../controllers/home_controller.dart';
import 'package:nb_utils/nb_utils.dart';

class HomeView extends GetView<HomeController> {
  final GlobalKey<FormState> form = GlobalKey<FormState>();
  Read reads = Get.arguments ?? Read();
  final authC = Get.find<AuthController>();

  Future<Null> refresh() async {
    await Future.delayed(Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    controller.modelToController(reads);
    print("userid = ${authC.user.id}");
    print("user = ${authC.user.email}");
    return Scaffold(
      appBar: AppBar(
          backgroundColor: secondary,
          title: Row(children: [
            CircleAvatar(
              backgroundImage: AssetImage("assets/icon.png"),
              backgroundColor: secondary,
            ),
            SizedBox(
              width: 8,
            ),
            ShaderMask(
              shaderCallback: (bounds) => RadialGradient(
                      center: Alignment.center,
                      radius: 1.0,
                      colors: [white, Color.fromARGB(255, 131, 170, 238)],
                      tileMode: TileMode.mirror)
                  .createShader(bounds),
              child: Text(
                "Librarian",
                style: TextStyle(color: white),
              ),
            ),
          ])),
      endDrawer: Drawer(
        backgroundColor: white,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            width: double.infinity,
            height: 130,
            color: secondary,
            child: Center(
              child: Column(
                children: [
                  Obx(
                    () => authC.user.image != null
                        ? AvatarGlow(
                            endRadius: 50.0,
                            glowColor: white,
                            duration: Duration(seconds: 1),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  height: 80,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    color: secondary,
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
                            glowColor: white,
                            duration: Duration(seconds: 1),
                            child: Material(
                              elevation: 6.0,
                              shape: CircleBorder(),
                              child: Icon(Icons.person,
                                  size: 80, color: secondary),
                            ),
                          ),
                  ),
                  Obx(
                    () => SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        authC.user.username ?? "Username",
                        style: TextStyle(color: clr_white, fontSize: 20),
                      ),
                    ),
                  ),
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
                    color: secondary,
                  ),
                  title: Text(
                    "Profile",
                    style: TextStyle(color: secondary),
                  ),
                ),
                ListTile(
                  onTap: () => Get.defaultDialog(
                    title: "Notifications",
                    middleText: "This is Notifications",
                    titleStyle: TextStyle(color: secondary),
                    middleTextStyle: TextStyle(color: secondary),
                    textConfirm: "Okay",
                    onConfirm: () => Get.back(),
                    confirmTextColor: white,
                    buttonColor: secondary,
                  ),
                  leading: Icon(
                    Icons.notifications,
                    color: secondary,
                  ),
                  title: Text(
                    "Notifications",
                    style: TextStyle(color: secondary),
                  ),
                ),
                ListTile(
                  onTap: () => Get.defaultDialog(
                    title: "Help",
                    middleText: "This is Help",
                    titleStyle: TextStyle(color: secondary),
                    middleTextStyle: TextStyle(color: secondary),
                    textConfirm: "Okay",
                    onConfirm: () => Get.back(),
                    confirmTextColor: white,
                    buttonColor: secondary,
                  ),
                  leading: Icon(
                    Icons.info_outline,
                    color: secondary,
                  ),
                  title: Text(
                    "Help",
                    style: TextStyle(color: secondary),
                  ),
                ),
                ListTile(
                  onTap: () => authC.logout(),
                  leading: Icon(
                    Icons.logout,
                    color: secondary,
                  ),
                  title: Text(
                    "Logout",
                    style: TextStyle(color: secondary),
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
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: <Color>[
                secondary,
                primary,
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            ),
            padding: EdgeInsets.zero,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Book List",
                          style: TextStyle(color: white, fontSize: 20),
                        ),
                        IconButton(
                          onPressed: () => Get.toNamed(Routes.ADD),
                          icon: Icon(
                            Icons.add_circle_outline,
                            color: white,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    height: 260,
                    child: Obx(
                      () => controller.books.length < 1
                          ? Center(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "No Book Found",
                                      style: TextStyle(color: white),
                                    ),
                                    TextButton(
                                        onPressed: () =>
                                            Get.toNamed(Routes.ADD),
                                        child: Text(
                                          "Add your first book!",
                                          style: TextStyle(color: white),
                                        ))
                                  ]),
                            )
                          : SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: controller.books.length,
                                physics: ScrollPhysics(),
                                itemBuilder: (context, index) => BookCard(
                                  book: controller.books[index],
                                ),
                              ),
                            ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25),
                    child: Container(
                      height: 500,
                      decoration: BoxDecoration(
                          color: white,
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(10))),
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.all(12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Recent Activity",
                                  style:
                                      TextStyle(color: primary, fontSize: 20),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(Icons.menu_book_outlined, color: primary),
                              ],
                            ),
                          ),
                          Obx(
                            () => controller.reads.length < 1
                                ? Center(
                                    child: Text("No Read Found",
                                        style: TextStyle(color: primary)))
                                : ListView.builder(
                                    shrinkWrap: true,
                                    physics: ScrollPhysics(),
                                    itemCount: controller.reads.length,
                                    itemBuilder: (context, index) {
                                      return SingleChildScrollView(
                                          child: Container(
                                        decoration: BoxDecoration(
                                          color: primary.withOpacity(
                                              index % 2 == 1 ? 0.2 : 0.3),
                                        ),
                                        child: Dismissible(
                                          confirmDismiss: (direction) {
                                            return showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    titleTextStyle: TextStyle(
                                                        color: primary,
                                                        fontSize: 20),
                                                    contentTextStyle: TextStyle(
                                                        color: primary,
                                                        fontSize: 17),
                                                    title: Text("Confirm"),
                                                    content: Text(
                                                        "Are you sure to delete?"),
                                                    actions: [
                                                      IconButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop(false);
                                                          },
                                                          icon: Text(
                                                            "No",
                                                            style: TextStyle(
                                                                color: primary),
                                                          )),
                                                      IconButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop(true);
                                                          },
                                                          icon: Text(
                                                            "Yes",
                                                            style: TextStyle(
                                                                color: primary),
                                                          ))
                                                    ],
                                                  );
                                                });
                                          },
                                          onDismissed: (direction) async =>
                                              await controller.deleteread(
                                                  controller.reads[index]),
                                          key: Key(index.toString()),
                                          background: Container(
                                            color: red,
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.delete,
                                                  size: 40,
                                                  color: white,
                                                ),
                                                SizedBox(
                                                  width: 8,
                                                ),
                                                Text(
                                                  "Delete",
                                                  style:
                                                      TextStyle(color: white),
                                                )
                                              ],
                                            ),
                                            padding: EdgeInsets.only(right: 10),
                                          ),
                                          child: ListBook(
                                              read: controller.reads[index],
                                              book: controller.books
                                                      .firstWhereOrNull(
                                                          (element) =>
                                                              element.id ==
                                                              controller
                                                                  .reads[index]
                                                                  .bookid) ??
                                                  Book()),
                                        ),
                                      ));
                                    }),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: white,
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
        initialActiveIndex: 0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: primary,
        onPressed: () async {
          await showDialog(
              context: context,
              builder: (context) {
                return SimpleDialog(
                  backgroundColor: background,
                  children: [
                    Container(
                      height: 315,
                      width: 100,
                      decoration: BoxDecoration(color: background),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                            Center(
                              child: Text(
                                "Reading Form",
                                style: TextStyle(color: primary, fontSize: 20),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Form(
                              key: form,
                              child: SingleChildScrollView(
                                child: Column(children: [
                                  DropdownSearch<Book>(
                                    items: controller.books,
                                    itemAsString: (book) => book!.judul!,
                                    showClearButton: true,
                                    showSearchBox: true,
                                    onChanged: (book) {
                                      controller.selectedbook = book;
                                      controller.bookid = book!.id;
                                      controller.prepageC.text =
                                          book.readpage.toString();
                                    },
                                    mode: Mode.MENU,
                                    dropdownSearchDecoration: InputDecoration(
                                      suffixIconColor: primary,
                                      focusColor: primary,
                                      suffixStyle: TextStyle(color: primary),
                                      border: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: primary)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: primary)),
                                      disabledBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: primary),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      prefixIcon: Icon(
                                        Icons.book,
                                        color: primary,
                                      ),
                                      labelText: "Book Name",
                                      labelStyle: TextStyle(color: primary),
                                      prefixIconColor: primary,
                                      hoverColor: primary,
                                      fillColor: primary,
                                      iconColor: primary,
                                      contentPadding: EdgeInsets.zero,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  TextFormField(
                                      enabled: false,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      readOnly: true,
                                      showCursor: true,
                                      cursorColor: primary,
                                      style: TextStyle(color: primary),
                                      keyboardType: TextInputType.number,
                                      controller: controller.prepageC,
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        hintText:
                                            "Input your previous read page",
                                        hintStyle: TextStyle(color: primary),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: primary)),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: primary)),
                                        disabledBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: primary)),
                                        label: Row(
                                          children: [
                                            Icon(
                                              Icons.menu_book,
                                              color: primary,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              "Previous Read Page",
                                              style: TextStyle(color: primary),
                                            )
                                          ],
                                        ),
                                        border: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: primary)),
                                      )),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  TextFormField(
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "This field is required";
                                        }
                                        if (controller.selectedbook == null) {
                                          return "This field is empty";
                                        }
                                        if (value.toInt() >
                                            controller.selectedbook!.page!) {
                                          return "This field can't be more than book page";
                                        }
                                        if (value.toInt() <=
                                            controller
                                                .selectedbook!.readpage!) {
                                          return "This field can't be less or equal than previous page";
                                        }
                                        return null;
                                      },
                                      controller: controller.newpageC,
                                      showCursor: true,
                                      cursorColor: primary,
                                      style: TextStyle(color: primary),
                                      keyboardType: TextInputType.number,
                                      textInputAction: TextInputAction.done,
                                      decoration: InputDecoration(
                                        hintText: "Input your newest read page",
                                        hintStyle: TextStyle(color: primary),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: primary)),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: primary)),
                                        disabledBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: primary)),
                                        label: Row(
                                          children: [
                                            Icon(
                                              Icons.menu_book,
                                              color: primary,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              "Newest Read Page",
                                              style: TextStyle(color: primary),
                                            )
                                          ],
                                        ),
                                        border: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: primary)),
                                      )),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Obx(
                                    () => Container(
                                      width: Get.width,
                                      child: FloatingActionButton.extended(
                                          backgroundColor: primary,
                                          onPressed: controller.isSaving
                                              ? null
                                              : () {
                                                  if (form.currentState!
                                                      .validate()) {
                                                    controller.store(reads);
                                                  }
                                                },
                                          label: controller.isSaving
                                              ? Text("Loading...")
                                              : Text("Submit")),
                                    ),
                                  ),
                                ]),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              });
          controller.prepageC.clear();
          controller.newpageC.clear();
        },
        child: Icon(
          Icons.add,
          color: white,
          size: 30,
        ),
      ),
    );
  }
}

class BookCard extends GetView<HomeController> {
  BookCard({required this.book});
  Book book;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
            context: context,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
            builder: (context) => Container(
                height: 130,
                child: Column(
                  children: [
                    ListTile(
                        title: Text(
                          "Edit",
                          style: TextStyle(color: primary),
                        ),
                        leading: Icon(
                          Icons.edit,
                          color: primary,
                        ),
                        onTap: () => Get.toNamed(Routes.ADD, arguments: book)),
                    ListTile(
                        title: Text(
                          "Delete",
                          style: TextStyle(color: primary),
                        ),
                        leading: Icon(
                          Icons.delete,
                          color: primary,
                        ),
                        onTap: () => controller.delete(book)),
                  ],
                )));
      },
      child: Container(
        padding: EdgeInsets.all(10),
        width: 160,
        height: 260,
        margin: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              book.image != null
                  ? Container(
                      height: 80,
                      width: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image: NetworkImage(book.image!),
                              fit: BoxFit.cover)),
                    )
                  : Container(
                      height: 80,
                      width: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image: AssetImage("assets/default.png"),
                              fit: BoxFit.fitHeight)),
                    ),
              SizedBox(
                height: 15,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(
                  book.judul!,
                  style: TextStyle(color: primary, fontSize: 18),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(
                  book.kategori!,
                  style: TextStyle(color: primary, fontSize: 15),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(
                  "${book.page} pages",
                  style: TextStyle(color: primary, fontSize: 15),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                NumberFormat.percentPattern('id')
                    .format((book.readpage ?? 0) / (book.page ?? 0)),
                style: TextStyle(color: primary),
              ),
              SizedBox(
                height: 5,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: LinearProgressIndicator(
                  color: primary,
                  value: (book.readpage ?? 0) / (book.page ?? 0),
                  minHeight: 10,
                  backgroundColor: Colors.grey[400],
                ),
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

class ListBook extends GetView<HomeController> {
  ListBook({required this.read, required this.book});
  Read read;
  Book book;
  @override
  Widget build(BuildContext context) {
    return ListTile(
        trailing: Card(
          color: primary,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: Text(
              "${read.prepage}-${read.newpage}",
              style: TextStyle(color: white),
            ),
          ),
        ),
        leading: book.image != null
            ? Container(
                height: 40,
                width: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                        image: NetworkImage(book.image!), fit: BoxFit.cover)),
              )
            : Container(
                height: 40,
                width: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                        image: AssetImage("assets/default.png"),
                        fit: BoxFit.fitHeight)),
              ),
        title: SingleChildScrollView(
            scrollDirection: Axis.horizontal, child: Text(book.judul!)),
        subtitle: Text("${DateFormat.yMMMEd().format(read.time!)}"));
  }
}

// class BookCard extends GetView<HomeController> {
//   BookCard({required this.book});
//   Book book;
//   @override
//   Widget build(BuildContext context) {
//     RxBool showEdit = false.obs;
//     return Obx(
//       () => Stack(
//         children: [
//           InkWell(
//             onTap: () => showEdit.value = !showEdit.value,
//             child: Container(
//               padding: EdgeInsets.all(10),
//               width: 160,
//               height: 260,
//               margin: EdgeInsets.all(10),
//               child: SingleChildScrollView(
//                 child: Column(
//                   mainAxisSize: MainAxisSize.max,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     if (book.image != null)
//                       Container(
//                         height: 80,
//                         width: 150,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             image: DecorationImage(
//                                 image: NetworkImage(book.image!),
//                                 fit: BoxFit.cover)),
//                       ),
//                     SizedBox(
//                       height: 15,
//                     ),
//                     Text(
//                       book.judul!,
//                       style: TextStyle(color: primary, fontSize: 18),
//                     ),
//                     SizedBox(
//                       height: 5,
//                     ),
//                     Text(
//                       book.kategori!,
//                       style: TextStyle(color: primary, fontSize: 15),
//                     ),
//                     SizedBox(
//                       height: 5,
//                     ),
//                     Text(
//                       "${book.page} pages",
//                       style: TextStyle(color: primary, fontSize: 15),
//                     ),
//                     SizedBox(
//                       height: 5,
//                     ),
//                     Text(
//                       NumberFormat.percentPattern('id')
//                         .format((book.readpage ?? 0) / (book.page ?? 0)),
//                       style: TextStyle(color: primary),
//                     ),
//                     SizedBox(
//                       height: 5,
//                     ),
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(16),
//                       child: LinearProgressIndicator(
//                         color: primary,
//                         value: (book.readpage ?? 0) / (book.page ?? 0),
//                         minHeight: 10,
//                         backgroundColor: Colors.grey[400],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               decoration: BoxDecoration(
//                 color: white,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//             ),
//           ),
//           if (showEdit.value)
//             AnimatedContainer(
//               duration: Duration(milliseconds: 5),
//               child: Container(
//                   margin: EdgeInsets.all(10),
//                   width: 160,
//                   height: 260,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     color: primary.withOpacity(0.9),
//                   ),
//                   child: Column(
//                     children: [
//                       Align(
//                         alignment: Alignment.centerRight,
//                         child: IconButton(
//                             onPressed: () {
//                               showEdit.value = !showEdit.value;
//                             },
//                             icon: Icon(
//                               Icons.cancel_outlined,
//                               color: primary,
//                             )),
//                       ),
//                       Column(
//                         children: [
//                       TextButton.icon(
//                           onPressed: () {
//                             Get.toNamed(Routes.ADD, arguments: book);
//                           },
//                           icon: Icon(
//                             Icons.edit,
//                             color: primary,
//                           ),
//                           label: Text(
//                             "Edit",
//                             style: TextStyle(color: primary),
//                           )),
//                       TextButton.icon(
//                           onPressed: () {
//                             controller.delete(book);
//                           },
//                           icon: Icon(
//                             Icons.delete,
//                             color: primary,
//                           ),
//                           label: Text(
//                             "Delete",
//                             style: TextStyle(color: primary),
//                           )),
//                         ],
//                       )
//                     ],
//                   )),
//             ),
//         ],
//       ),
//     );
//   }
// }

// FutureBuilder<List<Book>>(
// future: controller.getallbook(),
// builder: (context, s) {
//   if (s.connectionState == ConnectionState.waiting) {
//     return  Center(
//               child:
//                   Lottie.asset("assets/lottie/loading.json"),
//             );
//   }
//   if (s.data?.length == 0) {
//     return Center(
//       child: Text("List Book Empty"),
//     );
//   } else {
//     return ListView.builder(
//         itemCount: s.data!.length,
//         itemBuilder: (context, index) {
//           Book book = s.data![index];
//           return Book(judul: book.judul, kategori: book.kategori, page: book.page, image: book.image, edit: book.id, delete: book.id, index: index)
//         }
//         );
//   }
// }),

// StreamBuilder<QuerySnapshot<Object?>>(
//                       stream: controller.streamall(),
//                       builder: (context, s) {
//                         if (s.connectionState == ConnectionState.active) {
//                           var listAll = s.data!.docs;
//                           return ListView.builder(
//                               itemCount: listAll.length,
//                               scrollDirection: Axis.horizontal,
//                               itemBuilder: (context, index) {
//                                 return Book(
//                                   judul:
//                                       "${(listAll[index].data() as Map<String, dynamic>)["judul"]}",
//                                   kategori:
//                                       "${(listAll[index].data() as Map<String, dynamic>)["kategori"]}",
//                                   page:
//                                       "${(listAll[index].data() as Map<String, dynamic>)["page"]}",
//                                   image:
//                                       "${(listAll[index].data() as Map<String, dynamic>)["image"]}",
//                                   edit: listAll[index].id,
//                                   delete: listAll[index].id,
//                                   index: index,
//                                 );
//                               });
//                         }
//                         return Center(
//                           child: Lottie.asset("assets/lottie/loading.json"),
//                         );
//                       }),

// StreamBuilder<QuerySnapshot<Object?>>(
//                     stream: controller.streamall(),
//                     builder: (context, s) {
//                       if (s.connectionState == ConnectionState.active) {
//                         var listAll = s.data!.docs;
//                         return ListView.builder(
//                             itemCount: listAll.length,
//                             scrollDirection: Axis.horizontal,
//                             itemBuilder: (context, index) {
//                               return Container(
//                                 padding: EdgeInsets.all(10),
//                                 width: 160,
//                                 margin: EdgeInsets.all(10),
//                                 child: Column(
//                                   mainAxisSize: MainAxisSize.max,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     if ((listAll[index].data()
//                                             as Map<String, dynamic>)["image"] !=
//                                         null)
//                                       Container(
//                                         height: 90,
//                                         width: 150,
//                                         child: Image.network(
//                                           (listAll[index].data()
//                                               as Map<String, dynamic>)["image"],
//                                           fit: BoxFit.cover,
//                                         ),
//                                       ),
//                                     SizedBox(
//                                       height: 15,
//                                     ),
//                                     Text(
//                                       "${(listAll[index].data() as Map<String, dynamic>)["judul"]}",
//                                       style: TextStyle(
//                                           color: primary, fontSize: 18),
//                                     ),
//                                     SizedBox(
//                                       height: 5,
//                                     ),
//                                     Text(
//                                       "${(listAll[index].data() as Map<String, dynamic>)["kategori"]}",
//                                       style: TextStyle(
//                                           color: purplebook, fontSize: 15),
//                                     ),
//                                     SizedBox(
//                                       height: 5,
//                                     ),
//                                     Text(
//                                       "${(listAll[index].data() as Map<String, dynamic>)["page"]} pages",
//                                       style: TextStyle(
//                                           color: purplebook, fontSize: 15),
//                                     ),
//                                   ],
//                                 ),
//                                 decoration: BoxDecoration(
//                                   color: white,
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                               );
//                             });
//                       }
//                       return Center(
//                         child: Lottie.asset("assets/lottie/loading.json"),
//                       );
//                     }),

// StreamBuilder<QuerySnapshot<Object?>>(
//     stream: controller.streamall(),
//     builder: (context, s) {
//       if (s.connectionState == ConnectionState.active) {
//         var listAll = s.data!.docs;
//         return SingleChildScrollView(
//           child: ListView.builder(
//               shrinkWrap: true,
//               physics: ScrollPhysics(),
//               itemCount: listAll.length,
//               itemBuilder: (context, index) {
//                 return SingleChildScrollView(
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: primary.withOpacity(
//                           index % 2 == 1 ? 0.2 : 0.3),
//                     ),
//                     child: Dismissible(
//                       confirmDismiss: (direction) {
//                         return showDialog(
//                             context: context,
//                             builder: (context) {
//                               return AlertDialog(
//                                 title: Text("Confirm"),
//                                 content: Text(
//                                     "Are you sure to delete?"),
//                                 actions: [
//                                   IconButton(
//                                       onPressed: () {
//                                         Navigator.of(
//                                                 context)
//                                             .pop(false);
//                                       },
//                                       icon: Text(
//                                         "No",
//                                         style: TextStyle(
//                                             color:
//                                                 lightpurple),
//                                       )),
//                                   IconButton(
//                                       onPressed: () {
//                                         Navigator.of(
//                                                 context)
//                                             .pop(true);
//                                       },
//                                       icon: Text(
//                                         "Yes",
//                                         style: TextStyle(
//                                             color:
//                                                 lightpurple),
//                                       ))
//                                 ],
//                               );
//                             });
//                       },
//                       key: Key(index.toString()),
//                       background: Container(
//                         color: red,
//                         child: Row(
//                           children: [
//                             Icon(
//                               Icons.delete,
//                               size: 40,
//                               color: white,
//                             ),
//                             SizedBox(
//                               width: 8,
//                             ),
//                             Text(
//                               "Delete",
//                               style: TextStyle(
//                                   color: white),
//                             )
//                           ],
//                         ),
//                         padding:
//                             EdgeInsets.only(right: 10),
//                       ),
//                       child: ListTile(
//                           trailing: Card(
//                             color: lightpurple,
//                             shape:
//                                 RoundedRectangleBorder(
//                                     borderRadius:
//                                         BorderRadius
//                                             .circular(
//                                                 12)),
//                             child: Container(
//                               padding:
//                                   EdgeInsets.symmetric(
//                                       vertical: 4,
//                                       horizontal: 8),
//                               child: Text(
//                                 "1-${(listAll[index].data() as Map<String, dynamic>)["page"]}",
//                                 style: TextStyle(
//                                     color: white),
//                               ),
//                             ),
//                           ),
//                           leading: Image.network(
//                             "${(listAll[index].data() as Map<String, dynamic>)["image"]}",
//                             height: 40,
//                             width: 60,
//                             fit: BoxFit.cover,
//                           ),
//                           title: Text(
//                               "${(listAll[index].data() as Map<String, dynamic>)["judul"]}"),
//                           subtitle: Text(
//                               "${(listAll[index].data() as Map<String, dynamic>)["kategori"]}")
//                           // Text(
//                           //     "${DateFormat('EEEEEE, d MMM y').format((listAll[index].data() as Map<String, dynamic>) ["time"])}"),
//                           ),
//                     ),
//                   ),
//                 );
//               }),
//         );
//       }
//       return Center(
//         child:
//             Lottie.asset("assets/lottie/loading.json"),
//       );
//     }),

// child: StreamBuilder<QuerySnapshot<Object?>>(
//     stream: controller.streamall(),
//     builder: (context, s) {
//       if (s.connectionState == ConnectionState.active) {
//         var listAll = s.data!.docs;
//         return ListView.builder(
//             itemCount: listAll.length,
//             scrollDirection: Axis.horizontal,
//             itemBuilder: (context, index) {
//               return Book(
//                 judul:
//                     "${(listAll[index].data() as Map<String, dynamic>)["judul"]}",
//                 kategori:
//                     "${(listAll[index].data() as Map<String, dynamic>)["kategori"]}",
//                 page:
//                     "${(listAll[index].data() as Map<String, dynamic>)["page"]}",
//                 image:
//                     "${(listAll[index].data() as Map<String, dynamic>)["image"]}",
//                 edit: listAll[index].id,
//                 delete: listAll[index].id,
//                 index: index,
//               );
//             });
//       }
//       return Center(
//         child: Lottie.asset("assets/lottie/loading.json"),
//       );
//     }),
