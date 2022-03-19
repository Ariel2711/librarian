import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:librarian/app/data/database.dart';

const String uid = "id";
const String uusername = "username";
const String uemail = "email";
const String upassword = "password";
const String ugender = "gender";
const String ubirth = "birth";
const String uimage = "image";
const String utime = "time";

class UserModel {
  String? id;
  String? username;
  String? email;
  String? password;
  String? image;
  int? gender;
  DateTime? birth;
  DateTime? time;

  UserModel(
      {this.id,
      this.username,
      this.email,
      this.password,
      this.image,
      this.gender,
      this.birth,
      this.time});

  UserModel fromJson(DocumentSnapshot doc) {
    print("doc data = ${doc.data()}");
    Map<String, dynamic> json = doc.data() as Map<String, dynamic>;
    return UserModel(
      id: doc.id,
      username: json[uusername],
      email: json[uemail],
      password: json[upassword],
      image: json[uimage],
      gender: json[ugender],
      birth: (json[ubirth]as Timestamp?)?.toDate(),
      time: (json[utime]as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> get toJson => {
        uid: id,
        uusername: username,
        uemail: email,
        upassword: password,
        uimage: image,
        ugender: gender,
        ubirth: birth,
        utime: time,
      };

  Database db = Database(
      collectionReference: firestore.collection(
        userCollection,
      ),
      storageReference: storage.ref(userCollection));

  Future<UserModel> save({File? file}) async {
    id == null ? id = await db.add(toJson) : await db.edit(toJson);
    if (file != null && id != null) {
      image = await db.upload(id: id!, file: file);
      db.edit(toJson);
    }
    return this;
  }

  Stream<UserModel> streamList(String id) async* {
    print("getStream");
    yield* db.collectionReference.doc(id).snapshots().map((event) {
      print("event id = ${event.id}");
      return fromJson(event);
    });
  }
}
