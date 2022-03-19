import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:librarian/app/data/database.dart';
import 'package:librarian/app/utils/color.dart';

class Book {
  String? id;
  String? judul;
  String? kategori;
  int? page;
  int? readpage;
  String? image;
  DateTime? time;

  Book({this.id, this.judul, this.kategori, this.page, this.image, this.time});

  Book.fromJson(DocumentSnapshot snapshot) {
    Map<String, dynamic>? json = snapshot.data() as Map<String, dynamic>?;
    id = snapshot.id;
    judul = json?['judul'];
    kategori = json?['kategori'];
    page = json?['page'];
    readpage = json?['readpage'];
    image = json?['image'];
    time = (json?['time']).toDate();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['judul'] = judul;
    data['kategori'] = kategori;
    data['page'] = page;
    data['readpage'] = readpage;
    data['image'] = image;
    data['time'] = time;
    return data;
  }

  Database db = Database(
      collectionReference: firestore.collection(
        bookCollection,
      ),
      storageReference: storage.ref(bookCollection));

  Future<Book> save({File? file}) async {
    id == null ? id = await db.add(toJson()) : await db.edit(toJson());
    if (file != null && id != null) {
      image = await db.upload(id: id!, file: file);
      db.edit(toJson());
    }
    return this;
  }

  Future delete() async {
    if (id == null) {
      Get.defaultDialog(
        title: "Error",
        middleText: "Invalid ID",
        onConfirm: () => Get.back(),
        textConfirm: "Okay",
        buttonColor: primary,
        confirmTextColor: clr_white,
        cancelTextColor: black,
      );
      return;
    }
    return await db.delete(id!, url: image);
  }

  Stream<List<Book>> streamList() async* {
    yield* db.collectionReference
        .orderBy("time", descending: true)
        .snapshots()
        .map((query) {
      List<Book> list = [];
      for (var doc in query.docs) {
        list.add(
          Book.fromJson(
            doc,
          ),
        );
      }
      return list;
    });
  }
}
