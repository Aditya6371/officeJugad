part of 'app_pages.dart';

/// A chunks of routes and the path names which will be used to create
/// routes in [AppPages].
class Routes {
  static const String splash = _Paths.splash;
  static const String login = _Paths.login;
  static const String home = _Paths.home;
  static const String createVehicle = _Paths.createVehicle;
  static const String vehiclesList = _Paths.vehiclesList;
  static const String customers = _Paths.customers;
  static const String createBanner = _Paths.createBanner;
  static const String bannerList = _Paths.bannerList;
  static const String brandList = _Paths.brandList;
  static const String createBrand = _Paths.createBrand;
}

class _Paths {
  static const splash = '/splash-screen';
  static const login = '/login-screen';
  static const home = '/home-screen';
  static const createVehicle = '/create-vehicle-screen';
  static const vehiclesList = '/vehicles-list-screen';
  static const customers = '/customers-screen';
  static const createBanner = '/create-banner-screen';
  static const bannerList = '/banner-list-screen';
  static const brandList = '/brand-list-screen';
  static const createBrand = '/create-brand-screen';
}
