import 'dart:io';
import 'package:get/get.dart';
import 'package:librarian/app/data/database.dart';
import 'package:librarian/app/data/models/book_model.dart';

class ReadController extends GetxController {
  late String judulC = "";
  var imagePath = ''.obs;
  late File image;
  RxList<Book> rxBooks = RxList<Book>();
  List<Book> get books => rxBooks.value;
  set books(List<Book> value) => rxBooks.value = value;

  Database database = Database(
    collectionReference: firestore.collection(bookCollection),
    storageReference: storage.ref(bookCollection),
  );

  modelToController(Book book) {
    judulC = book.judul ?? '';
  }

  void onInit() {
    super.onInit();
    rxBooks.bindStream(Book().streamList());
  }
}
