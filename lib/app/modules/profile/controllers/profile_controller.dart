import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:librarian/app/data/models/book_model.dart';
import 'package:librarian/app/data/models/user_model.dart';
import 'package:librarian/app/utils/color.dart';
import 'package:librarian/app/data/database.dart';

class ProfileController extends GetxController {
  RxBool edit = false.obs;
  RxBool hidden = true.obs;
  late TextEditingController nameC;
  late TextEditingController emailC;
  late TextEditingController passC;
  late File image;
  var imagePath = ''.obs;
  ImagePicker picker = ImagePicker();

  var _selectedGender = 0.obs;
  int get selectedGender => _selectedGender.value;
  set selectedGender(int value) => _selectedGender.value = value;

  Rx<DateTime?> _selectedDate = DateTime(2000).obs;
  DateTime? get selectedDate => _selectedDate.value;
  set selectedDate(DateTime? value) => _selectedDate.value = value;

  handleBirthDate(dynamic context) async {
    selectedDate = await showDatePicker(
            context: context,
            initialDate: selectedDate ?? DateTime.now(),
            initialDatePickerMode: DatePickerMode.year,
            firstDate:
                DateTime(selectedDate?.year ?? DateTime.now().year - 100),
            lastDate: DateTime.now()) ??
        selectedDate;
  }

  RxList<Book> rxBooks = RxList<Book>();
  List<Book> get books => rxBooks.value;
  set books(List<Book> value) => rxBooks.value = value;

  Future pickImage() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      File file = File(result.files.single.path!);
      imagePath.value = file.path;
    }
  }

  modelToController(UserModel user) {
    nameC.text = user.username ?? '';
    emailC.text = user.email ?? '';
    passC.text = user.password ?? '';
    selectedDate = user.birth ?? DateTime.now();
    selectedGender = user.gender ?? 0;
  }

  var _isSaving = false.obs;
  bool get isSaving => _isSaving.value;
  set isSaving(bool value) => _isSaving.value = value;

  Future store(UserModel user) async {
    isSaving = true;
    user.username = nameC.text;
    user.email = emailC.text;
    user.password = passC.text;
    user.birth = selectedDate;
    user.gender = selectedGender;
    try {
      print(user.toJson);
      await user.save(
          file: imagePath.value == '' ? null : File(imagePath.value));
      Get.defaultDialog(
          title: "Succeed",
          middleText: "Profile has been updated",
          textConfirm: "Okay",
          titleStyle: TextStyle(color: primary),
          middleTextStyle: TextStyle(color: primary),
          buttonColor: primary,
          confirmTextColor: clr_white,
          onConfirm: () {
            Get.back();
          });
    } catch (e) {
      print(e);
    } finally {
      isSaving = false;
    }
  }

  Database db = Database(
      collectionReference: firestore.collection(
        bookCollection,
      ),
      storageReference: storage.ref(bookCollection));

  Stream<List<Book>> streampage() async* {
    yield* db.collectionReference.snapshots().map((query) {
      List<Book> allpage = [];
      for (var doc in query.docs) {
        allpage.add(
          Book.fromJson(
            doc,
          ),
        );
      }
      return allpage;
    });
  }

  Stream<List<Book>> streamread() async* {
    yield* db.collectionReference.snapshots().map((query) {
      List<Book> readpage = [];
      for (var doc in query.docs) {
        readpage.add(
          Book.fromJson(
            doc,
          ),
        );
      }
      return readpage;
    });
  }

  @override
  void onInit() {
    nameC = TextEditingController();
    emailC = TextEditingController();
    passC = TextEditingController();
    rxBooks.bindStream(Book().streamList());
    super.onInit();
  }

  @override
  void onClose() {
    nameC.dispose();
    emailC.dispose();
    passC.dispose();
    super.onClose();
  }
}
