// ignore_for_file: invalid_use_of_protected_member

import 'package:get/get.dart';
import 'package:librarian/app/data/database.dart';
import 'package:librarian/app/data/models/book_model.dart';

class AllbookController extends GetxController {
  RxList<Book> rxBooks = RxList<Book>();
  List<Book> get books => rxBooks.value;
  set books(List<Book> value) => rxBooks.value = value;

  Database database = Database(
    collectionReference: firestore.collection(bookCollection),
    storageReference: storage.ref(bookCollection),
  );

  void onInit() {
    super.onInit();
    rxBooks.bindStream(Book().streamList());
  }
}
