import 'package:get/get.dart';

import '../controllers/allbook_controller.dart';

class AllbookBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllbookController>(
      () => AllbookController(),
    );
  }
}
