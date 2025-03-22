// import 'dart:io' show File;

// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:path_provider/path_provider.dart';
// import 'package:zero/controllers/home/home.dart';

// class NotificationService extends GetxController {
//   final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   @override
//   void onInit() {
//     super.onInit();
//     init(); // Initialize notifications on controller initialization
//   }

//   // Method to initialize notification settings and handle foreground messages
//   Future<void> init() async {
//     // Initialize the local notifications plugin
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');
//     DarwinInitializationSettings darwinInitializationSettings =
//         DarwinInitializationSettings(
//             // onDidReceiveLocalNotification: onDidReceiveLocalNotification,
//             );

//     InitializationSettings initializationSettings = InitializationSettings(
//       android: initializationSettingsAndroid,
//       iOS: darwinInitializationSettings,
//     );

//     await _flutterLocalNotificationsPlugin.initialize(initializationSettings);

//     // Handle foreground messages
//     FirebaseMessaging.onMessage.listen(
//       (RemoteMessage message) {
//         debugPrint('Message received in foreground: ${message.toMap()}');
//         // Utility.showDialog('${message.toMap()}');

//         if (message.notification != null) {
//           if (GetPlatform.isAndroid) {
//             if (message.notification?.android?.imageUrl != null) {
//               _showNotificationWithImage(message);
//             } else {
//               _showNotification(message);
//             }
//           } else if (GetPlatform.isIOS) {
//             if (message.notification?.apple?.imageUrl != null) {
//               _showNotificationWithImage(message);
//             } else {
//               _showNotification(message);
//             }
//           }
//         }
//       },
//     );

//     // // Register the background message handler
//     // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

//     // // Handle initial notification when app is launched from a notification
//     // handleInitialNotification();

//     // // Handle on tap message to open app from a notification
//     // handleOnMessageOpenedApp();
//   }

//   // Method to handle on message open app.
//   Future<void> handleOnMessageOpenedApp() async {
//     FirebaseMessaging.onMessageOpenedApp.listen((message) {
//       // Navigate to a specific screen or handle notification here
//       debugPrint('App launched from a notification: ${message.toMap()}');
//       // Utility.showDialog('${message.toMap()}');
//       if (Get.isRegistered<HomeController>()) {
//         Get.find<HomeController>().openMessage(message.data);
//       }
//     });
//   }

//   // Method to handle initial notification
//   Future<void> handleInitialNotification() async {
//     // Navigate to a specific screen or handle notification here

//     FirebaseMessaging.instance.getInitialMessage().then(
//       (message) {
//         if (message != null) {
//           // Navigate to a specific screen or handle notification here
//           debugPrint('App launched from a notification: ${message.toMap()}');
//           if (Get.isRegistered<HomeController>()) {
//             Get.find<HomeController>().openMessage(message.data);
//           }
//           // Utility.showDialog('${message.toMap()}');
//         }
//       },
//     );
//   }

//   // // Method to handle background messages
//   // @pragma('vm:entry-point')
//   // Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   //   // If you're going to use other Firebase services in the background, such as Firestore,
//   //   // make sure you call `initializeApp` before using other Firebase services.
//   //   await Firebase.initializeApp();

//   //   debugPrint('Handling a background message: ${message.toMap()}');

//   //   // Handle background messages here
//   // }

//   // Method to show a notification without an image
//   Future<void> _showNotification(RemoteMessage message) async {
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails(
//       'your_channel_id', // Set a channel ID
//       'your_channel_name', // Set a channel name
//       importance: Importance.max,
//       priority: Priority.high,
//       icon: "@drawable/ic_stat_ic_launcher_foreground",
//     );

//     const DarwinNotificationDetails iosPlatformChannelSpecifics =
//         DarwinNotificationDetails(
//       presentAlert: true,
//       presentBadge: true,
//       presentSound: true,
//     );

//     const NotificationDetails platformChannelSpecifics = NotificationDetails(
//       android: androidPlatformChannelSpecifics,
//       iOS: iosPlatformChannelSpecifics,
//     );

//     await _flutterLocalNotificationsPlugin.show(
//       0, // Notification ID
//       message.notification?.title,
//       message.notification?.body,
//       platformChannelSpecifics,
//       payload: 'Notification Payload',
//     );
//   }

//   // Method to show a notification with an image
//   Future<void> _showNotificationWithImage(RemoteMessage message) async {
//     final String? imageUrl = message.notification?.android?.imageUrl ??
//         message.notification?.apple?.imageUrl;
//     if (imageUrl != null) {
//       final File? bigPicturePath = await _downloadAndSaveImage(imageUrl);

//       if (bigPicturePath != null) {
//         final BigPictureStyleInformation bigPictureStyleInformation =
//             BigPictureStyleInformation(
//           FilePathAndroidBitmap(bigPicturePath.path),
//           contentTitle: message.notification?.title,
//           summaryText: message.notification?.body,
//         );

//         final AndroidNotificationDetails androidPlatformChannelSpecifics =
//             AndroidNotificationDetails(
//           'your_channel_id',
//           'your_channel_name',
//           icon: "@drawable/ic_stat_ic_launcher_foreground",
//           styleInformation: bigPictureStyleInformation,
//           importance: Importance.max,
//           priority: Priority.high,
//         );

//         final DarwinNotificationDetails iosPlatformChannelSpecifics =
//             DarwinNotificationDetails(
//           attachments: [DarwinNotificationAttachment(bigPicturePath.path)],
//           presentAlert: true,
//           presentBadge: true,
//           presentSound: true,
//         );

//         final NotificationDetails platformChannelSpecifics =
//             NotificationDetails(
//           android: androidPlatformChannelSpecifics,
//           iOS: iosPlatformChannelSpecifics,
//         );

//         await _flutterLocalNotificationsPlugin.show(
//           0, // Notification ID
//           message.notification?.title,
//           message.notification?.body,
//           platformChannelSpecifics,
//           payload: 'Notification Payload',
//         );
//       } else {
//         // Fallback to notification without image if image download fails
//         _showNotification(message);
//       }
//     } else {
//       // Fallback to notification without image if no image URL is provided
//       _showNotification(message);
//     }
//   }

//   // Method to download and save the image to local storage
//   Future<File?> _downloadAndSaveImage(String url) async {
//     try {
//       final response = await http.get(Uri.parse(url));
//       final directory = await getApplicationDocumentsDirectory();
//       final filePath = '${directory.path}/notification_image.png';
//       final file = File(filePath);
//       await file.writeAsBytes(response.bodyBytes);
//       return file;
//     } catch (e) {
//       debugPrint('Error downloading image: $e');
//       return null;
//     }
//   }

//   // Method to request permission and generate FCM token
//   Future<String?> generateFCMToken() async {
//     // Request notification permissions
//     final settings = await FirebaseMessaging.instance.requestPermission();

//     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//       debugPrint('User granted permission');
//     } else if (settings.authorizationStatus ==
//         AuthorizationStatus.provisional) {
//       debugPrint('User granted provisional permission');
//     } else {
//       debugPrint('User declined or has not accepted permission');
//     }

//     // Generate FCM token
//     final fcmToken = await FirebaseMessaging.instance.getToken();

//     return fcmToken;
//   }

//   Future<void> onDidReceiveLocalNotification(
//       int id, String? title, String? body, String? payload) async {
//     // Handle the local notification here
//     debugPrint(
//         'Received local notification with id: $id, title: $title, body: $body');
//   }
// }
