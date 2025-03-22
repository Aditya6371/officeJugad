import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:zero_admin/models/models.dart';
import 'package:zero_admin/res/res.dart';

import 'local.dart';

class DBWrapper {
  final _flutterSecureStorage = const FlutterSecureStorageManager();
  final _preference = Get.find<SharedPreferencesManager>();

  Future<void> init() async {
    await _preference.init();
    await Hive.initFlutter();
    await _openHiveBox();
  }

  Future<Box> _openHiveBox() async {
    return await Hive.openBox('${AppConstants.appName}-hive');
  }

  void clearData(String key) {
    _preference.delete(key);
    clearAuthRes();
  }

  // check for user is logged in or not
  Future<bool> isLoggedIn() async {
    final authData = await Get.find<DBWrapper>().getAuthRes();
    if (authData == null) {
      return false;
    } else {
      return true;
    }
  }

  // save remember me
  Future<void> saveRememberMe(String username, String password) async {
    final box = await _openHiveBox();
    await box.put('rememberMeKey', {
      'username': username,
      'password': password,
    });
  }

  Future<Map<String, String>> getRememberMe() async {
    final box = await _openHiveBox();
    return box.get('rememberMeKey');
  }

  // delete remember me
  Future<void> deleteRememberMe() async {
    final box = await _openHiveBox();
    await box.delete('rememberMeKey');
  }

  /// Save AuthRes model to Hive
  Future<void> saveAuthRes(AuthRes authRes) async {
    final box = await _openHiveBox();
    await box.put('authResKey', authRes);
  }

  /// Get AuthRes model from Hive
  Future<AuthRes?> getAuthRes() async {
    final box = await _openHiveBox();
    return box.get('authResKey');
  }

  /// Get AuthRes model from Hive
  void clearAuthRes() async {
    final box = await _openHiveBox();
    return box.deleteFromDisk();
  }

  void deleteBox() async {
    _preference.clear();
    await Hive.close(); // Close the Hive box
  }

  void clearAll() async {
    /// Shared Preference
    _preference.clear();

    // /// Hive
    // final box = await _openHiveBox();
    // box.clear();

    //Clear Auth res
    clearAuthRes();

    /// Secured storage
    _flutterSecureStorage.deleteAllSecuredValues();
  }

  String getStringValue(String key, {String defaultValue = ''}) =>
      _preference.getStringValue(key, defaultValue);

  Future<void> saveValue<T>(String key, T value) async =>
      await _preference.saveSharedValue(key, value);

  bool getBoolValue(String key, {bool defaultValue = false}) =>
      _preference.getBoolValue(key, defaultValue);

  int getIntValue(String key, {int defaultValue = 0}) =>
      _preference.getIntValue(key, defaultValue);

  Future<String> getSecuredValue(String key, {String defaultValue = ''}) async {
    try {
      return await _flutterSecureStorage.getSecuredValue(key);
    } catch (error) {
      return defaultValue;
    }
  }

  Future<void> saveValueSecurely(String key, String value) async =>
      await _flutterSecureStorage.saveValueSecurely(key, value);

  Future<void> deleteSecuredValue(String key) async =>
      _flutterSecureStorage.deleteSecuredValue(key);

  Future<void> deleteAllSecuredValues() async =>
      _flutterSecureStorage.deleteAllSecuredValues();
}
