import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:librarian/app/data/database.dart';
import 'package:librarian/app/utils/color.dart';

class Read {
  String? id;
  String? bookid;
  int? prepage;
  int? newpage;
  DateTime? time;

  Read({this.id, this.bookid, this.prepage, this.newpage, this.time});

  Read.fromJson(DocumentSnapshot snapshot) {
    Map<String, dynamic>? json = snapshot.data() as Map<String, dynamic>?;
    id = snapshot.id;
    bookid = json?['bookid'];
    prepage = json?['prepage'];
    newpage = json?['newpage'];
    time = (json?['time']).toDate();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['bookid'] = bookid;
    data['prepage'] = prepage;
    data['newpage'] = newpage;
    data['time'] = time;
    return data;
  }

  Database db = Database(
      collectionReference: firestore.collection(
        readCollection,
      ),
      storageReference: storage.ref(readCollection));

  // Database get db => Database(
  // collectionReference: firestore
  //     .collection(bookCollection)
  //     .doc(bookID)
  //     .collection(readingCollection),
  // storageReference: storage.ref(bookCollection).child(readingCollection));

  Future<Read> save() async {
    id == null ? id = await db.add(toJson()) : await db.edit(toJson());
    if (id != null) {
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
    return await db.delete(id!);
  }

  Stream<List<Read>> streamList() async* {
    yield* db.collectionReference
        .orderBy("time", descending: true)
        .snapshots()
        .map((query) {
      List<Read> list = [];
      for (var doc in query.docs) {
        list.add(
          Read.fromJson(
            doc,
          ),
        );
      }
      return list;
    });
  }

  // Stream<List<Read>> streamAllList() async* {
  //   yield* firestore
  //       .collectionGroup(readCollection)
  //       .where("time", isGreaterThanOrEqualTo: DateTime(2020))
  //       .where("id", isNull: true)
  //       .orderBy("time", descending: true)
  //       .snapshots()
  //       .map((query) {
  //     List<Read> list = [];
  //     for (var doc in query.docs) {
  //       print(doc.reference);
  //       print(doc.data());
  //       list.add(
  //         Read.fromJson(
  //           doc,
  //         ),
  //       );
  //     }
  //     return list;
  //   });
  // }

  // Stream<List<Read>> streamListFromBook() async* {
  //   yield* db.collectionReference
  //       .orderBy("time", descending: true)
  //       .snapshots()
  //       .map((query) {
  //     List<Read> list = [];
  //     for (var doc in query.docs) {
  //       list.add(
  //         Read.fromJson(
  //           doc,
  //         ),
  //       );
  //     }
  //     return list;
  //   });
  // }
}
