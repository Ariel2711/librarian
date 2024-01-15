// ignore_for_file: invalid_use_of_protected_member, unused_catch_clause

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:librarian/app/data/models/book_model.dart';
import 'package:librarian/app/data/models/read_model.dart';
import 'package:librarian/app/data/models/user_model.dart';
import 'package:librarian/app/utils/color.dart';

class HomeController extends GetxController {
  late TextEditingController prepageC;
  late TextEditingController newpageC;
  String? bookid;
  Book? selectedbook;

  RxList<Book> rxBooks = RxList<Book>();
  List<Book> get books => rxBooks.value;
  set books(List<Book> value) => rxBooks.value = value;

  RxList<Read> rxReads = RxList<Read>();
  List<Read> get reads => rxReads.value;
  set reads(List<Read> value) => rxReads.value = value;

  RxList<UserModel> rxUser = RxList<UserModel>();
  List<UserModel> get user => rxUser.value;
  set user(List<UserModel> value) => rxUser.value = value;

  modelToController(Read read) {
    bookid = read.bookid;
    newpageC.text = read.newpage?.toString() ?? '';
  }

  var _isSaving = false.obs;
  bool get isSaving => _isSaving.value;
  set isSaving(bool value) => _isSaving.value = value;

  Future store(Read read) async {
    isSaving = true;
    read.bookid = bookid;
    read.prepage = int.tryParse(prepageC.text);
    read.newpage = int.tryParse(newpageC.text);
    if (read.id == null) {
      read.time = DateTime.now();
    }
    try {
      if (read.bookid != null && read.newpage != null && read.prepage != null) {
        await read.save();
        selectedbook!.readpage = read.newpage;
        await selectedbook?.save();
        Get.defaultDialog(
            title: "Succeed",
            middleText: "Read has been added",
            textConfirm: "Okay",
            titleStyle: TextStyle(color: primary),
            middleTextStyle: TextStyle(color: primary),
            buttonColor: primary,
            confirmTextColor: clr_white,
            onConfirm: () {
              prepageC.clear();
              newpageC.clear();
              Get.back();
              Get.back();
            });
      } else {
        Get.defaultDialog(
            title: "Error",
            middleText: "Read failed to added",
            textConfirm: "Okay",
            titleStyle: TextStyle(color: primary),
            middleTextStyle: TextStyle(color: primary),
            buttonColor: primary,
            confirmTextColor: clr_white,
            onConfirm: () {
              prepageC.clear();
              newpageC.clear();
              Get.back();
            });
      }
    } catch (e) {
      print(e);
    } finally {
      isSaving = false;
    }
  }

  Future delete(Book book) async {
    if (book.id == null) {
      Get.defaultDialog(
        title: "Error",
        middleText: "Book ID not found",
        onConfirm: () => Get.back(),
        textConfirm: "Okay",
        buttonColor: primary,
        confirmTextColor: clr_white,
        cancelTextColor: black,
        titleStyle: TextStyle(color: primary),
        middleTextStyle: TextStyle(color: primary),
      );
      return Future.value(null);
    }
    try {
      Get.defaultDialog(
        onConfirm: () async {
          try {
            await book.delete();
            Get.back();
            Get.back();
          } catch (e) {
            print(e);
          }
        },
        onCancel: () {
          Get.back();
          Get.back();
        },
        textConfirm: "Yes",
        textCancel: "Cancel",
        title: "Delete Book",
        middleText: "Are you sure?",
        buttonColor: primary,
        confirmTextColor: clr_white,
        cancelTextColor: primary,
        titleStyle: TextStyle(color: primary),
        middleTextStyle: TextStyle(color: primary),
      );
    } on Exception catch (e) {
      Get.defaultDialog(
        title: "Error",
        middleText: "Failed to delete",
        onConfirm: () => Get.back(),
        textConfirm: "Okay",
        buttonColor: primary,
        confirmTextColor: clr_white,
        cancelTextColor: black,
        titleStyle: TextStyle(color: primary),
        middleTextStyle: TextStyle(color: primary),
      );
    }
  }

  Future deleteread(Read read) async {
    if (read.id == null) {
      Get.defaultDialog(
        title: "Error",
        middleText: "Book ID not found",
        onConfirm: () => Get.back(),
        textConfirm: "Okay",
        buttonColor: primary,
        confirmTextColor: clr_white,
        cancelTextColor: black,
        titleStyle: TextStyle(color: primary),
        middleTextStyle: TextStyle(color: primary),
      );
      return Future.value(null);
    }
    try {
      await read.delete();
    } on Exception catch (e) {
      Get.defaultDialog(
        title: "Error",
        middleText: "Failed to delete ${e}",
        onConfirm: () => Get.back(),
        textConfirm: "Okay",
        buttonColor: primary,
        confirmTextColor: clr_white,
        cancelTextColor: black,
        titleStyle: TextStyle(color: primary),
        middleTextStyle: TextStyle(color: primary),
      );
    }
  }

  @override
  void onInit() {
    prepageC = TextEditingController();
    newpageC = TextEditingController();
    rxBooks.bindStream(Book().streamList());
    rxReads.bindStream(Read().streamList());
    super.onInit();
  }

  @override
  void onClose() {
    prepageC.dispose();
    newpageC.dispose();
    super.onClose();
  }
}


// Stream<QuerySnapshot<Object?>> streamall() {
  //   CollectionReference book = firestore.collection("book");
  //   return book.orderBy("time", descending: false).snapshots();
  // }

  // void delete(String ID) {
  //   DocumentReference docdata = firestore.collection("book").doc(ID);
  //   try {
  //     Get.defaultDialog(
  //       title: "Delete Book",
  //       middleText: "Are you sure?",
  //       onConfirm: () {
  //         docdata.delete();
  //         Get.back();
  //       },
  //       textConfirm: "Yes",
  //       textCancel: "Cancel",
  //       buttonColor: purple,
  //       confirmTextColor: white,
  //       cancelTextColor: black,
  //     );
  //   } catch (e) {
  //     Get.defaultDialog(
  //       title: "Error",
  //       middleText: "Failed to delete",
  //       onConfirm: () => Get.back(),
  //       textConfirm: "Okay",
  //       buttonColor: purple,
  //       confirmTextColor: white,
  //       cancelTextColor: black,
  //     );
  //   }
  // }