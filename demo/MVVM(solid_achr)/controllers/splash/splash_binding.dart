import 'package:get/get.dart';
import 'package:zero_admin/controllers/controllers.dart';

class SplashBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(
      () => SplashController(),
    );
  }
}
