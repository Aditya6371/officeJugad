import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:crypto/crypto.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zero_admin/data/data.dart';
import 'package:zero_admin/utils/utils.dart';

import '../models/models.dart';
import '../res/res.dart';
import '../widgets/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';

class Utility {
  const Utility._();

  static int rupeesToPaise(num rupees) {
    return (rupees * 100).round();
  }

  static String calculateXVerifyChecksum({
    required String base64EncodedPayload,
    required String apiEndpoint,
    required String saltKey,
    required String saltIndex,
  }) {
    // Concatenate the required components
    String dataToHash = base64EncodedPayload + apiEndpoint + saltKey;

    // Convert the string to bytes
    List<int> bytes = utf8.encode(dataToHash);

    // Calculate SHA256 hash
    Digest sha256Result = sha256.convert(bytes);

    // Convert hash to hex string
    String hashString = sha256Result.toString();

    // Create final checksum by adding ### and salt index
    String finalChecksum = "$hashString###$saltIndex";

    return finalChecksum;
  }

  static String convertJsonToBase64(Map<String, dynamic> jsonData) {
    // Convert JSON to string
    String jsonString = json.encode(jsonData);

    // Convert string to bytes
    List<int> bytes = utf8.encode(jsonString);

    // Convert bytes to base64
    String base64String = base64.encode(bytes);

    return base64String;
  }

  static bool isTestMode() {
    return Platform.environment.containsKey('FLUTTER_TEST');
  }

  static void hideKeyboard() => FocusManager.instance.primaryFocus?.unfocus();

  static String getThumbnailUrl(String? videoLink) {
    if (videoLink == null || videoLink.isEmpty) return '';

    // YouTube (including Shorts)
    if (videoLink.contains('youtube.com') || videoLink.contains('youtu.be')) {
      final RegExp regExp = RegExp(
          r'(?:youtube\.com\/(?:shorts\/|(?:[^\/\n\s]+\/\S+\/|(?:v|e(?:mbed)?)\/|\S*?[?&]v=))|youtu\.be\/)([a-zA-Z0-9_-]{11})');
      final match = regExp.firstMatch(videoLink);
      if (match != null && match.groupCount >= 1) {
        final videoId = match.group(1);
        return 'https://img.youtube.com/vi/$videoId/0.jpg';
      }
    }

    // Return a default thumbnail URL if the link does not match any known platform
    return 'https://example.com/default-thumbnail.jpg';
  }

  static Future<String?> uploadPdfAndGetUrl(
      Uint8List asset, String name, String bucketName) async {
    try {
      Utility.showLoader();
      final reference = FirebaseStorage.instance
          .ref()
          .child(bucketName)
          .child('${DateTime.now().millisecondsSinceEpoch}$name');
      final uploadTask = await reference.putData(asset);
      final url = await uploadTask.ref.getDownloadURL();
      Utility.closeLoader();
      AppLog(url);
      return url;
    } catch (error) {
      AppLog.error('$error');
      return null;
    }
  }

  static Future<String?> uploadFileAndGetUrl(
      Uint8List asset, String name, String bucketName) async {
    try {
      Utility.showLoader();

      // Prepare the API endpoint URL
      final apiUrl = '${Apis.baseUrl}files/upload';

      // Prepare the request
      var request = http.MultipartRequest('POST', Uri.parse(apiUrl));

      // Add the file to the request
      request.files.add(http.MultipartFile.fromBytes(
        'file', // This should match the field name expected by your API
        asset,
        filename: '${DateTime.now().millisecondsSinceEpoch}$name',
      ));

      // Use bucketName as folderPath
      request.fields['folderPath'] = bucketName;

      // Send the request
      var response = await request.send();

      // Check if the request was successful
      if (response.statusCode == 200) {
        // Parse the response
        final responseBody = await response.stream.bytesToString();
        final jsonResponse = json.decode(responseBody);

        // Extract the file URL from the response
        final url = jsonResponse['fileUrl'];

        Utility.closeLoader();
        AppLog(url);
        return url;
      } else {
        throw Exception(
            'Failed to upload file. Status code: ${response.statusCode}');
      }
    } catch (error) {
      AppLog.error('$error');
      Utility.closeLoader();
      return null;
    }
  }

  /// Returns true if the internet connection is available.
  static Future<bool> get isNetworkAvailable async {
    final List<ConnectivityResult> result =
        await Connectivity().checkConnectivity();
    return result.contains(ConnectivityResult.mobile) ||
        result.contains(ConnectivityResult.wifi) ||
        result.contains(ConnectivityResult.ethernet);
  }

  static Future<T?> openBottomSheet<T>(
    Widget child, {
    Color? backgroundColor,
    bool isDismissible = true,
    ShapeBorder? shape,
  }) async =>
      await Get.bottomSheet<T>(
        child,
        barrierColor: Colors.black.withOpacity(0.7),
        backgroundColor: backgroundColor,
        isDismissible: isDismissible,
        shape: shape,
        isScrollControlled: true,
      );

  static Future<TimeOfDay> pickTime({
    required BuildContext context,
    required TimeOfDay initialTime,
  }) async =>
      (await showTimePicker(
        context: context,
        initialTime: initialTime,
        initialEntryMode: TimePickerEntryMode.inputOnly,
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        ),
      )) ??
      initialTime;

  /// Show loader
  static void showLoader() async {
    await Get.dialog(
      const PopScope(
        canPop: false,
        child: AppLoader(),
      ),
      barrierDismissible: false,
    );
  }

  /// Close loader
  static void closeLoader() {
    closeDialog();
  }

  /// Show error dialog from response model
  static Future<void> showInfoDialog(
    ResponseModel data, [
    bool isSuccess = false,
    String? title,
  ]) async {
    await Get.dialog(
      AlertDialog.adaptive(
        title: Text(
          title ?? (isSuccess ? 'Success' : 'Error'),
        ),
        content: Text(
          jsonDecode(data.data)['message'] as String,
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: Get.back,
            isDefaultAction: true,
            child: Text(
              'Okay',
              style: Styles.black16,
            ),
          ),
        ],
      ),
    );
  }

  /// Show info dialog
  static void showDialog(
    String message, {
    bool canPop = true,
    Function()? onCLick,
  }) async {
    await Get.dialog(
      PopScope(
        canPop: canPop,
        child: AlertDialog.adaptive(
          title: const SizedBox.shrink(),
          content: Text(
            message,
            textAlign: TextAlign.center,
          ),
          actions: [
            CupertinoDialogAction(
              onPressed: onCLick ?? Get.back,
              child: const Text('Okay'),
            ),
          ],
        ),
      ),
    );
  }

  /// Show alert dialog
  static void showAlertDialog({
    String? message,
    String? title,
    Function()? onPress,
  }) async {
    await Get.dialog(
      AlertDialog.adaptive(
        title: Text('$title'),
        content: Text('$message'),
        actions: <Widget>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: onPress,
            child: Text('yes'.tr),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: closeDialog,
            child: Text('no'.tr),
          )
        ],
      ),
    );
  }

  /// Close any open dialog.
  static void closeDialog() {
    if (Get.isDialogOpen ?? false) Get.back<void>();
  }

  /// Close any open snackbar
  static void closeSnackbar() {
    if (Get.isSnackbarOpen) Get.back<void>();
  }

  /// Show a message to the user.
  ///
  /// [message] : Message you need to show to the user.
  /// [type] : Type of the message for different background color.
  /// [onTap] : An event for onTap.
  /// [actionName] : The name for the action.
  ///
  static void showSnackBar({
    ResponseModel? data,
    MessageType type = MessageType.information,
    Function()? onTap,
    String? actionName,
    SnackPosition snackPosition = SnackPosition.BOTTOM,
  }) {
    if (data == null) return;
    String message = jsonDecode(data.data)['message'];
    closeDialog();
    closeSnackbar();
    Get.rawSnackbar(
      messageText: Text(
        message,
        style: Styles.white16w600,
      ),
      mainButton: actionName != null
          ? TextButton(
              onPressed: onTap ?? Get.back,
              child: Text(
                actionName,
                style: Styles.white16,
              ),
            )
          : null,
      backgroundColor: data.hasError ? Colors.red : Colors.green,
      margin: Dimens.edgeInsets10,
      borderRadius: Dimens.ten + Dimens.five,
      snackStyle: SnackStyle.FLOATING,
      snackPosition: snackPosition,
      duration: const Duration(seconds: 3),
      animationDuration: const Duration(milliseconds: 300),
    );
  }

  static void showMessage({
    String? message,
    MessageType type = MessageType.information,
    Function()? onTap,
    String? actionName,
    SnackPosition snackPosition = SnackPosition.BOTTOM,
  }) {
    if (message == null || message.isEmpty) return;
    closeDialog();
    closeSnackbar();
    var backgroundColor = Colors.black;
    switch (type) {
      case MessageType.error:
        backgroundColor = Colors.red;
        break;
      case MessageType.information:
        backgroundColor = Colors.blue;
        break;
      case MessageType.success:
        backgroundColor = Colors.green;
        break;
      default:
        backgroundColor = Colors.black;
        break;
    }
    Future.delayed(
      const Duration(seconds: 0),
      () {
        Get.rawSnackbar(
          messageText: Text(
            message,
            style: Styles.white16w600,
          ),
          mainButton: actionName != null
              ? TextButton(
                  onPressed: onTap ?? Get.back,
                  child: Text(
                    actionName,
                    style: Styles.white16,
                  ),
                )
              : null,
          backgroundColor: backgroundColor,
          margin: Dimens.edgeInsets10,
          borderRadius: Dimens.ten + Dimens.five,
          snackStyle: SnackStyle.FLOATING,
          snackPosition: snackPosition,
          duration: const Duration(seconds: 3),
          animationDuration: const Duration(milliseconds: 300),
        );
      },
    );
  }

  static void unfocusKeyboard(BuildContext context) {
    var currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  /// Get device platform
  static Future<String> getDevicePlatform() async {
    var deviceOS = '';
    if (GetPlatform.isAndroid) {
      deviceOS = 'Android';
    } else if (GetPlatform.isIOS) {
      deviceOS = 'IOS';
    } else if (GetPlatform.isWindows) {
      deviceOS = 'Windows';
    } else {
      deviceOS = 'Others';
    }
    return deviceOS;
  }

  /// Get device make based on OS.
  static Future<String> getDeviceMake() async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    if (GetPlatform.isAndroid) {
      var build = await deviceInfoPlugin.androidInfo;
      return build.brand;
    } else if (GetPlatform.isIOS) {
      var data = await deviceInfoPlugin.iosInfo;
      return data.model;
    } else if (GetPlatform.isWindows) {
      var windowsData = await deviceInfoPlugin.windowsInfo;
      return windowsData.productName;
    } else {
      var macOS = await deviceInfoPlugin.macOsInfo;
      return macOS.computerName;
    }
  }

  /// Get device os version.
  static Future<String> getDeviceOsVersion() async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    var deviceOsVersion = 'device_os_version';
    try {
      if (GetPlatform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        deviceOsVersion =
            'Android ${build.version.release} (SDK ${build.version.sdkInt})';
      } else if (GetPlatform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        deviceOsVersion = '${data.systemName} ${data.systemVersion}';
      } else if (GetPlatform.isWeb) {
        deviceOsVersion = 'web_os_version';
      } else if (GetPlatform.isFuchsia) {
        deviceOsVersion = 'fuchsia_os_version';
      } else if (GetPlatform.isLinux) {
        deviceOsVersion = 'linux_os_version';
      } else if (GetPlatform.isWindows) {
        deviceOsVersion = 'windows_os_version';
      } else if (GetPlatform.isMacOS) {
        deviceOsVersion = 'mac_os_version';
      }
    } catch (exception) {
      log(exception.toString());
    }
    return deviceOsVersion;
  }

  /// Dialer launcher
  ///
  static void launchDialer(String number) async {
    var url = Uri.parse('tel:$number');
    await launchUrl(url);
  }

//Price Format
  static String formatPrice(num number) {
    NumberFormat formatter = NumberFormat.decimalPattern('hi');
    return "₹${formatter.format(number)}";
  }

// Format Time
  static String formatTime(String time) {
    try {
      final DateTime parsedTime = DateFormat("HH:mm").parse(time);
      return DateFormat.jm().format(parsedTime);
    } catch (e) {
      return time;
    }
  }

// Format Date
  static String formatDate(String date) {
    try {
      final DateTime parsedDate = DateTime.parse(date);
      return DateFormat('MMMM d, yyyy').format(parsedDate);
    } catch (e) {
      return date;
    }
  }

  static TimeOfDay stringToTimeOfDay(String time) {
    final format = RegExp(r'(\d+):(\d+)\s*(AM|PM)', caseSensitive: false);
    final match = format.firstMatch(time);

    if (match != null) {
      int hour = int.parse(match.group(1)!);
      int minute = int.parse(match.group(2)!);
      String period = match.group(3)!.toUpperCase();

      // Convert hour to 24-hour format if necessary
      if (period == 'PM' && hour != 12) {
        hour += 12;
      } else if (period == 'AM' && hour == 12) {
        hour = 0;
      }

      return TimeOfDay(hour: hour, minute: minute);
    }

    return TimeOfDay.now(); // Return null if format doesn't match
  }

  static String formatTimelineTime(String time) {
    try {
      final DateTime parsedTime = DateTime.parse(time);
      return DateFormat.jm().format(parsedTime);
    } catch (e) {
      return time;
    }
  }

  // A static method to show a confirmation dialog
  static Future<bool?> showConfirmationDialog({
    required String title,
    required String content,
    String cancelText = "Cancel",
    String confirmText = "Delete",
  }) async {
    return material.showDialog<bool>(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text(cancelText),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text(
                confirmText,
                style: const TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

// Open WhatsApp
  static void openWhatsapp(String? name) async {
    String contact = AppConstants.adminPhoneNumber;
    String text = name != null
        ? "Hello, I came across the *$name* in your app and would like more information. Could you please assist me further?"
        : "Hello, I came across an item in your app that I am interested in. Could you kindly provide further assistance?";
    String androidUrl =
        "whatsapp://send?phone=$contact&text=${Uri.encodeComponent(text)}";
    String iosUrl = "https://wa.me/$contact?text=${Uri.encodeComponent(text)}";
    String webUrl =
        'https://api.whatsapp.com/send/?phone=$contact&text=${Uri.encodeComponent(text)}';

    try {
      if (Platform.isIOS) {
        if (await canLaunchUrl(Uri.parse(iosUrl))) {
          await launchUrl(Uri.parse(iosUrl));
        } else {
          throw 'Could not launch WhatsApp on iOS';
        }
      } else if (Platform.isAndroid) {
        if (await canLaunchUrl(Uri.parse(androidUrl))) {
          await launchUrl(Uri.parse(androidUrl));
        } else {
          throw 'Could not launch WhatsApp on Android';
        }
      } else {
        await launchUrl(Uri.parse(webUrl),
            mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      await launchUrl(Uri.parse(webUrl), mode: LaunchMode.externalApplication);
    }
  }

// Open Any URL in External Browser
  static Future<void> openExternalBrowser(String url) async {
    if (!await launchUrl(Uri.parse(url),
        mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  static void signOut() async {
    final dbWrapper = Get.find<DBWrapper>();
    final auth = FirebaseAuth.instance;
    final googleSignIn = GoogleSignIn();

    try {
      final currentUser = auth.currentUser;

      // Check if user is signed in with Google
      if (currentUser!.providerData
          .any((info) => info.providerId == 'google.com')) {
        if (await googleSignIn.isSignedIn()) {
          await googleSignIn.signOut();
        }
      }

      // Sign out from Firebase (works for both phone and Google auth)
      await auth.signOut();

      // Save isFirstTime value before clearing
      final isFirstTime = dbWrapper.getBoolValue(LocalKeys.isFirstTime);

      // Clear all stored data
      dbWrapper.clearAll();

      // Restore isFirstTime value after clearing
      await dbWrapper.saveValue(LocalKeys.isFirstTime, isFirstTime);

      // Navigate to login screen
      Get.offAllNamed(Routes.login);

      Utility.showMessage(
        message: 'Successfully signed out',
        type: MessageType.success,
      );
    } catch (e) {
      Utility.showMessage(
        message: 'Error signing out: ${e.toString()}',
        type: MessageType.error,
      );
    }
  }
}
