/// This class is used for all the APIs endpoints
class Apis {
  const Apis._();

  static String baseUrl = 'https://api.zeroapp.net/';
  static String mapBaseUrl =
      'https://nominatim.openstreetmap.org/reverse?format=json';
  static const String getVersions = 'services/getVersions';
  static const String adminLogin = 'auth/adminGenerateToken';
  static const String generateToken = 'auth/loginAndGetToken';
  static const String updateprofile = 'auth/updateProfile/';
  static const String validateuser = 'auth/validateUser/';
  static const String createVehicles = 'vehicles';
  static const String getVehicleList = 'vehicles';
  static const String getUsersList = 'users';
  static const String updateUserStatus = 'users';
  static const String deleteVehicle = 'vehicles/';
  static const String getAllEvDetails = 'ev';
  static const String vehicles = 'vehicles';
  static const String banners = 'banners';
  static const String brands = 'brands';
}
