import 'dart:io';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:librarian/app/data/models/book_model.dart';
import 'package:librarian/app/utils/color.dart';
import '../controllers/add_controller.dart';

class AddView extends GetView<AddController> {
  final GlobalKey<FormState> form = GlobalKey<FormState>();
  Book book = Get.arguments ?? Book();
  @override
  Widget build(BuildContext context) {
    controller.modelToController(book);
    return Scaffold(
      backgroundColor: background,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Center(
                  child: Text(
                    "Book Form",
                    style: TextStyle(fontSize: 20, color: primary),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Form(
                  key: form,
                  child: SingleChildScrollView(
                    child: Column(children: [
                      TextField(
                          showCursor: true,
                          cursorColor: primary,
                          style: TextStyle(color: primary),
                          textInputAction: TextInputAction.next,
                          controller: controller.judulC,
                          decoration: InputDecoration(
                            hintText: "Input your book name",
                            hintStyle: TextStyle(color: primary),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: primary)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: primary)),
                            disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: primary)),
                            label: Row(children: [
                              Icon(
                                Icons.book,
                                color: primary,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Book Name",
                                style: TextStyle(color: primary),
                              ),
                            ]),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: primary)),
                          )),
                      SizedBox(
                        height: 15,
                      ),
                      DropdownSearch<String>(
                        items: controller.listCategory,
                        onChanged: (value) =>
                            controller.selectedCategory = value,
                        mode: Mode.MENU,
                        dropdownSearchDecoration: InputDecoration(
                          suffixIconColor: primary,
                          focusColor: primary,
                          suffixStyle: TextStyle(color: primary),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: primary)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: primary)),
                          disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: primary),
                              borderRadius: BorderRadius.circular(10)),
                          prefixIcon: Icon(
                            Icons.category,
                            color: primary,
                          ),
                          labelText: "Book Category",
                          labelStyle: TextStyle(color: primary),
                          prefixIconColor: primary,
                          hoverColor: primary,
                          fillColor: primary,
                          iconColor: primary,
                          contentPadding: EdgeInsets.zero,
                        ),
                        selectedItem: controller.selectedCategory,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextField(
                          showCursor: true,
                          cursorColor: primary,
                          style: TextStyle(color: primary),
                          keyboardType: TextInputType.number,
                          controller: controller.pageC,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            hintText: "Input your book page",
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
                                  Icons.menu_book_outlined,
                                  color: primary,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Book Page",
                                  style: TextStyle(color: primary),
                                )
                              ],
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: primary)),
                          )),
                      SizedBox(
                        height: 15,
                      ),
                      TextField(
                          showCursor: true,
                          cursorColor: primary,
                          style: TextStyle(color: primary),
                          keyboardType: TextInputType.number,
                          controller: controller.readpageC,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            hintText: "Input your read page",
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
                                  Icons.menu_book,
                                  color: primary,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Read Page",
                                  style: TextStyle(color: primary),
                                )
                              ],
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: primary)),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Book Cover",
                                  style:
                                      TextStyle(color: primary, fontSize: 20),
                                )),
                            SizedBox(
                              height: 8,
                            ),
                            Obx(() =>
                                controller.imagePath.value != ''
                                    ? Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Container(
                                              height: 200,
                                              width: 400,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10),
                                                  image: DecorationImage(
                                                      image: FileImage(
                                                         File(controller.imagePath.value)),
                                                      fit: BoxFit.cover)),
                                            )
                                      )
                                    : book.image != null
                                        ? Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Container(
                                              height: 200,
                                              width: 400,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          book.image!),
                                                      fit: BoxFit.cover)),
                                            ))
                                        : Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Container(
                                              width: 400,
                                              height: 200,
                                              child: Center(
                                                  child: Image(
                                                      image: AssetImage(
                                                          "assets/book.png"))),
                                              decoration: BoxDecoration(
                                                color: clr_white,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                            ),
                                          )),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: 160,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  )),
                                  onPressed: () {
                                    controller.pickImage();
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.upload,
                                        color: clr_white,
                                      ),
                                      Text("Upload Image",
                                          style: TextStyle(color: clr_white)),
                                    ],
                                  )),
                            ),
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
                                              controller.store(book);
                                            }
                                          },
                                    label: controller.isSaving
                                        ? Text("Loading...")
                                        : Text("Submit")),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



// TextField(
                    //   showCursor: true,
                    // cursorColor: primary,
                    // style: TextStyle(color: primary),
                    //     textInputAction: TextInputAction.next,
                    //     controller: controller.judulC,
                    //     decoration: InputDecoration(
                    //       hintText: "Input your book name",
                    //   hintStyle: TextStyle(color: primary),
                    //   focusedBorder: OutlineInputBorder(
                    //       borderSide: BorderSide(color: primary)),
                    //   enabledBorder: OutlineInputBorder(
                    //       borderSide: BorderSide(color: primary)),
                    //   disabledBorder: OutlineInputBorder(
                    //       borderSide: BorderSide(color: primary)),
                    //       label: Row(children: [
                    //         Icon(
                    //           Icons.book,
                    //           color: primary,
                    //         ),
                    //         SizedBox(
                    //           width: 5,
                    //         ),
                    //         Text(
                    //           "Book Name",
                    //           style: TextStyle(color: primary),
                    //         ),
                    //       ]),
                    //       border: OutlineInputBorder(
                    //           borderSide: BorderSide(color: primary)),
                    //     )),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    // // TextField(
                    // //   showCursor: true,
                    // // cursorColor: primary,
                    // // style: TextStyle(color: primary),
                    // //     textInputAction: TextInputAction.next,
                    // //     controller: controller.kategoriC,
                    // //     decoration: InputDecoration(
                    // //       hintText: "Input your book category",
                    // //   hintStyle: TextStyle(color: primary),
                    // //   focusedBorder: OutlineInputBorder(
                    // //       borderSide: BorderSide(color: primary)),
                    // //   enabledBorder: OutlineInputBorder(
                    // //       borderSide: BorderSide(color: primary)),
                    // //   disabledBorder: OutlineInputBorder(
                    // //       borderSide: BorderSide(color: primary)),
                    // //       label: Row(
                    // //         children: [
                    // //           Icon(
                    // //             Icons.category,
                    // //             color: primary,
                    // //           ),
                    // //           SizedBox(
                    // //             width: 5,
                    // //           ),
                    // //           Text(
                    // //             "Book Category",
                    // //             style: TextStyle(color: primary),
                    // //           )
                    // //         ],
                    // //       ),
                    // //       border: OutlineInputBorder(
                    // //           borderSide: BorderSide(color: primary)),
                    // //     )),
                    // DropdownSearch<String>(
                    //       items: controller.listCategory,
                    //       onChanged: (value) =>
                    //           controller.selectedCategory = value,
                    //       mode: Mode.MENU,
                    //       dropdownSearchDecoration: InputDecoration(
                    //         suffixIconColor: primary,
                    //         focusColor: primary,
                    //         suffixStyle: TextStyle(color: primary),
                    //         border: OutlineInputBorder(borderSide: BorderSide(color: primary)),
                    //   enabledBorder: OutlineInputBorder(
                    //       borderSide: BorderSide(color: primary)),
                    //   disabledBorder: OutlineInputBorder(
                    //       borderSide: BorderSide(color: primary),
                    //       borderRadius: BorderRadius.circular(10)),
                    //         prefixIcon: Icon(Icons.category, color: primary,),
                    //         labelText: "Category",
                    //         labelStyle: TextStyle(color: primary),
                    //         prefixIconColor: primary,
                    //         hoverColor: primary,
                    //         fillColor: white,
                    //         iconColor: white,
                    //         contentPadding: EdgeInsets.zero,
                    //       ),
                    //       selectedItem: controller.selectedCategory,
                    //       popupBackgroundColor: lightpurple2,
                    //     ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    // TextField(
                    //   showCursor: true,
                    // cursorColor: white,
                    // style: TextStyle(color: white),
                    //     keyboardType: TextInputType.number,
                    //     controller: controller.pageC,
                    //     textInputAction: TextInputAction.done,
                    //     decoration: InputDecoration(
                    //       hintText: "Input your book page",
                    //   hintStyle: TextStyle(color: white),
                    //   focusedBorder: OutlineInputBorder(
                    //       borderSide: BorderSide(color: white)),
                    //   enabledBorder: OutlineInputBorder(
                    //       borderSide: BorderSide(color: white)),
                    //   disabledBorder: OutlineInputBorder(
                    //       borderSide: BorderSide(color: white)),
                    //       label: Row(
                    //         children: [
                    //           Icon(
                    //             Icons.menu_book,
                    //             color: white,
                    //           ),
                    //           SizedBox(
                    //             width: 5,
                    //           ),
                    //           Text(
                    //             "Book Page",
                    //             style: TextStyle(color: white),
                    //           )
                    //         ],
                    //       ),
                    //       border: OutlineInputBorder(
                    //           borderSide: BorderSide(color: white)),
                    //     )),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    // Row(
                    //   children: [
                    //     Container(
                    //       width: 80,
                    //       child: ElevatedButton(
                    //           style: ElevatedButton.styleFrom(
                    //               shape: RoundedRectangleBorder(
                    //             borderRadius: BorderRadius.circular(20),
                    //           )),
                    //           onPressed: () => controller.upload(),
                    //           child: Icon(Icons.upload)),
                    //     ),
                    //     SizedBox(
                    //       width: 15,
                    //     ),
                    //     Text(
                    //       "Upload Image",
                    //       style: TextStyle(color: white),
                    //     ),
                    //   ],
                    // ),
                    // Obx(() => controller.imagePath.value != ''
                    //     ? Padding(
                    //         padding: const EdgeInsets.all(10),
                    //         child: Container(
                    //           width: 400,
                    //           height: 200,
                    //           child: Image.file(
                    //             File(controller.imagePath.value),
                    //             fit: BoxFit.cover,
                    //           ),
                    //           decoration: BoxDecoration(
                    //             color: white,
                    //             borderRadius: BorderRadius.circular(20),
                    //           ),
                    //         ),
                    //       )
                    //     : Padding(
                    //         padding: const EdgeInsets.all(10),
                    //         child: Container(
                    //           width: 400,
                    //           height: 200,
                    //           child: Center(
                    //               child: Image(
                    //                   image: AssetImage("assets/default.png"))),
                    //           decoration: BoxDecoration(
                    //             color: white,
                    //             borderRadius: BorderRadius.circular(20),
                    //           ),
                    //         ),
                    //       )),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    // Container(
                    //   width: 150,
                    //   child: ElevatedButton(
                    //       style: ElevatedButton.styleFrom(
                    //           shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(20),
                    //       )),
                    //       onPressed: () {
                    //         controller.add(
                    //           controller.judulC.text,
                    //           controller.kategoriC.text,
                    //           controller.pageC.text,
                    //         );
                    //       },
                    //       child: Text("Add")),
                    // ),  







// TextButton.icon(
                                //     onPressed: () async {
                                //       showModalBottomSheet(
                                //           context: context,
                                //           shape: RoundedRectangleBorder(
                                //               borderRadius: BorderRadius.vertical(
                                //                   top: Radius.circular(16))),
                                //           builder: (context) => Container(
                                //                 height: 200,
                                //                 child: Column(
                                //                   children: [
                                //                     Container(
                                //                       alignment: Alignment.centerLeft,
                                //                       padding: EdgeInsets.only(
                                //                           top: 16, left: 16),
                                //                       child: Text("Image Source"),
                                //                     ),
                                //                     ListTile(
                                //                         title: Text("Camera"),
                                //                         leading: Icon(
                                //                           Icons.camera,
                                //                           color: white,
                                //                         ),
                                //                         onTap: () async {
                                //                           await controller.pickImage(
                                //                               ImageSource.camera);
                                //                           Get.back();
                                //                         }),
                                //                     ListTile(
                                //                         title: Text("Gallery", style: TextStyle(color: white),),
                                //                         leading: Icon(
                                //                           Icons.photo,
                                //                           color: white,
                                //                         ),
                                //                         onTap: () async {
                                //                           await controller.pickImage(
                                //                               ImageSource.gallery);
                                //                           Get.back();
                                //                         }),
                                //                   ],
                                //                 ),
                                //               ));
                                //     },
                                //     style: ButtonStyle(),
                                //     icon: Icon(Icons.upload),
                                //     label: Text("Upload Image")),