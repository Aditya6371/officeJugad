import 'package:get/get.dart';
import 'package:zero_admin/data/data.dart';
import 'package:zero_admin/utils/utils.dart';

class SplashController extends GetxController {
  final DBWrapper _dbWrapper = Get.find<DBWrapper>();

  @override
  void onInit() {
    handleNavigation();
    super.onInit();
  }

  Future<void> handleNavigation() async {
    await Future.delayed(const Duration(seconds: 4));

    //Check if user is logged in
    final isLoggedIn = await _dbWrapper.isLoggedIn();
    if (isLoggedIn) {
      Get.offAllNamed(Routes.home);
      return;
    } else {
      Get.offAllNamed(Routes.login);
    }
  }
}
