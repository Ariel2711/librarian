import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:librarian/app/data/models/book_model.dart';
import 'package:librarian/app/utils/color.dart';

class AddController extends GetxController {
  late TextEditingController judulC;
  late TextEditingController kategoriC;
  late TextEditingController pageC;
  late TextEditingController readpageC;
  late File image;
  var imagePath = ''.obs;
  List<String> listCategory = [
    "Action and Adventure",
    "Classics",
    "Comic Book or Graphic Novel",
    "Detective and Mystery",
    "Fantasy",
    "Historical Fiction",
    "Horror",
    "Literary Fiction",
  ];
  String? selectedCategory;
  ImagePicker picker = ImagePicker();

  FirebaseStorage storage = FirebaseStorage.instance;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future pickImage() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      File file = File(result.files.single.path!);
      imagePath.value = file.path;
    }
  }

  modelToController(Book book) {
    judulC.text = book.judul ?? '';
    pageC.text = book.page?.toString() ?? '';
    readpageC.text = book.readpage?.toString() ?? '';
    selectedCategory = book.kategori;
  }

  var _isSaving = false.obs;
  bool get isSaving => _isSaving.value;
  set isSaving(bool value) => _isSaving.value = value;

  Future store(Book book) async {
    isSaving = true;
    book.judul = judulC.text;
    book.kategori = selectedCategory;
    book.page = int.tryParse(pageC.text);
    book.readpage = int.tryParse(readpageC.text);
    if (book.id == null) {
      book.time = DateTime.now();
    }
    try {
      if ((book.judul != '' &&
          book.page != '' &&
          selectedCategory != null &&
          imagePath != '' &&
          (book.readpage != '' && book.readpage! <= book.page!)) || (book.judul != '' &&
          book.page != '' &&
          selectedCategory != null &&
          book.image != '' &&
          (book.readpage != '' && book.readpage! <= book.page!))) {
        await book.save(
            file: imagePath.value == '' ? null : File(imagePath.value));
        Get.defaultDialog(
            title: "Succeed",
            middleText: "Book has been added",
            textConfirm: "Okay",
            titleStyle: TextStyle(color: primary),
            middleTextStyle: TextStyle(color: primary),
            buttonColor: primary,
            confirmTextColor: clr_white,
            onConfirm: () {
              judulC.clear();
              kategoriC.clear();
              pageC.clear();
              readpageC.clear();
              Get.back();
              Get.back();
            });
      } else {
        Get.defaultDialog(
            title: "Error",
            middleText: "Book failed to added",
            textConfirm: "Okay",
            titleStyle: TextStyle(color: primary),
            middleTextStyle: TextStyle(color: primary),
            buttonColor: primary,
            confirmTextColor: clr_white,
            onConfirm: () {
              judulC.clear();
              pageC.clear();
              readpageC.clear();
              Get.back();
            });
      }
    } catch (e) {
      print(e);
    } finally {
      isSaving = false;
    }
  }

  

  @override
  void onInit() {
    judulC = TextEditingController();
    kategoriC = TextEditingController();
    pageC = TextEditingController();
    readpageC = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    judulC.dispose();
    kategoriC.dispose();
    pageC.dispose();
    readpageC.dispose();
    super.onClose();
  }
}

// void add(String judul, String kategori, String page) async {
  //   CollectionReference book = firestore.collection("book");
  //   try {
  //     File file = File(imagePath.value);
  //     Reference path =
  //         await FirebaseStorage.instance.ref(DateTime.now().toIso8601String());
  //     var url = "";
  //     UploadTask task = path.putFile(file);
  //     await task.snapshotEvents.listen((event) async {
  //       if (event.state == TaskState.success) {
  //         url = await path.getDownloadURL();
  //         print('url = '+url);

  //         String DateNow = DateTime.now().toIso8601String();
  //         await book.add({
  //           "judul": judul,
  //           "kategori": selectedCategory,
  //           "page": page,
  //           "image": url,
  //           "time": DateNow,
  //         });

  //         Get.defaultDialog(
  //           title: "Succeed",
  //           middleText: "Book has been added",
  //           onConfirm: () {
  //             judulC.clear();
  //             kategoriC.clear();
  //             pageC.clear();
  //             Get.back();
  //             Get.back();
  //           },
  //           textConfirm: "Okay",
  //           buttonColor: purple,
  //           confirmTextColor: white,
  //           cancelTextColor: black,
  //         );
  //       }
  //     });

  //   } catch (e) {
  //     print(e);
  //     Get.defaultDialog(
  //       title: "Error",
  //       middleText: "Book failed to add",
  //       onConfirm: () => Get.back(),
  //       textConfirm: "Okay",
  //       buttonColor: purple,
  //       confirmTextColor: white,
  //       cancelTextColor: black,
  //     );
  //   }
  // }

  // void upload() async {
  //   FilePickerResult? result =
  //       await FilePicker.platform.pickFiles(type: FileType.image);
  //   if (result != null) {
  //     File file = File(result.files.single.path!);
  //     imagePath.value = file.path;
  //     try {
  //       print(file.path);
  //       Get.defaultDialog(
  //         title: "Succeed",
  //         middleText: "Image uploaded successfully",
  //         onConfirm: () => Get.back(),
  //         textConfirm: "Okay",
  //         buttonColor: purple,
  //         confirmTextColor: white,
  //         cancelTextColor: black,
  //       );
  //     } on FirebaseException catch (e) {
  //       print(e);
  //       Get.defaultDialog(
  //         title: "Error",
  //         middleText: "Image failed to upload",
  //         onConfirm: () => Get.back(),
  //         textConfirm: "Okay",
  //         buttonColor: purple,
  //         confirmTextColor: white,
  //         cancelTextColor: black,
  //       );
  //     }
  //   } else {}
  // }
