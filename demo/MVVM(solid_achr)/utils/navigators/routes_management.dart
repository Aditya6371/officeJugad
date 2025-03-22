import 'package:get/get.dart';

import 'app_pages.dart';

abstract class RouteManagement {
  static void goOfAllSplash() {
    Get.offAllNamed<void>(
      Routes.splash,
    );
  }

  static void goOffAllLogin() {
    Get.offAllNamed<void>(
      Routes.login,
    );
  }

  static void goOffAllHome() {
    Get.offAllNamed<void>(
      Routes.home,
    );
  }

  static void goOffAllCreateVehicle() {
    Get.offAllNamed<void>(
      Routes.createVehicle,
    );
  }

  static void goOffAllVehiclesList() {
    Get.offAllNamed<void>(
      Routes.vehiclesList,
    );
  }

  static void goOffAllCustomers() {
    Get.offAllNamed<void>(
      Routes.customers,
    );
  }

  static void goOffAllCreateBanner() {
    Get.offAllNamed<void>(
      Routes.createBanner,
    );
  }

  static void goOffAllBannerList() {
    Get.offAllNamed<void>(
      Routes.bannerList,
    );
  }

  static void goOffAllBrandList() {
    Get.offAllNamed<void>(
      Routes.brandList,
    );
  }

  static void goOffAllCreateBrand() {
    Get.offAllNamed<void>(
      Routes.createBrand,
    );
  }
}
