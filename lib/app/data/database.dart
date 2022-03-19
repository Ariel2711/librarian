import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:librarian/app/utils/color.dart';


FirebaseFirestore firestore = FirebaseFirestore.instance;
FirebaseStorage storage = FirebaseStorage.instance;
const bookCollection = "book";
const userCollection = "user";
const readCollection = "read";

class Database {
  CollectionReference collectionReference;
  Reference storageReference;
  Database({required this.collectionReference, required this.storageReference});

  Future<String?> add(Map<String, dynamic> json) async {
    try {
      DocumentReference book = await collectionReference.add(json);
      return book.id;
    } on FirebaseException catch (e) {
      Get.defaultDialog(
        title: "Error",
        middleText: "Book failed to add",
        onConfirm: () => Get.back(),
        textConfirm: "Okay",
        buttonColor: primary,
        confirmTextColor: clr_white,
        cancelTextColor: black,
      );
    } catch (e) {
      Get.defaultDialog(
        title: "Error",
        middleText: e.toString(),
        onConfirm: () => Get.back(),
        textConfirm: "Okay",
        buttonColor: primary,
        confirmTextColor: clr_white,
        cancelTextColor: black,
      );
    }
  }

  

  Future edit(Map<String, dynamic> json) async {
    try {
      return await collectionReference.doc(json["id"]).update(json);
    } on FirebaseException catch (e) {
      Get.defaultDialog(
        title: "Error",
        middleText: e.toString(),
        onConfirm: () => Get.back(),
        textConfirm: "Okay",
        buttonColor: primary,
        confirmTextColor: clr_white,
        cancelTextColor: black,
      );
      rethrow;
    }
  }

  Future delete(String id, {String? url}) async {
    try {
      if (url is String) {
        await storage.refFromURL(url).delete();
      }
      return await collectionReference.doc(id).delete();
    } on FirebaseException catch (e) {
      Get.defaultDialog(
        title: "Error",
        middleText: e.toString(),
        onConfirm: () => Get.back(),
        textConfirm: "Okay",
        buttonColor: primary,
        confirmTextColor: clr_white,
        cancelTextColor: black,
      );
      rethrow;
    }
  }

  
  

  Future<String?> upload({required String id, required File file}) async {
    try {
      String? url;
      var task = await storageReference.child(id).putFile(file);
      if (task.state == TaskState.success) {
        return await storageReference.child(id).getDownloadURL();
      }

      Get.defaultDialog(
        title: "Error",
        middleText: "Image failed to upload",
        onConfirm: () => Get.back(),
        textConfirm: "Okay",
        buttonColor: primary,
        confirmTextColor: clr_white,
        cancelTextColor: black,
      );
    } on FirebaseException catch (e) {
      Get.defaultDialog(
        title: "Error",
        middleText: e.toString(),
        onConfirm: () => Get.back(),
        textConfirm: "Okay",
        buttonColor: primary,
        confirmTextColor: clr_white,
        cancelTextColor: black,
      );
      rethrow;
    } catch (e) {
      Get.defaultDialog(
        title: "Error",
        middleText: e.toString(),
        onConfirm: () => Get.back(),
        textConfirm: "Okay",
        buttonColor: primary,
        confirmTextColor: clr_white,
        cancelTextColor: black,
      );
      rethrow;
    }
  }
}
