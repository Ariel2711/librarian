import 'package:get/get.dart';

import '../controllers/save_controller.dart';

class SaveBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SaveController>(
      () => SaveController(),
    );
  }
}
