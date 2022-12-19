// import 'package:firebase_messaging/firebase_messaging.dart';
//
// class PushNotificationManager {
//   PushNotificationManager._();
//   factory PushNotificationManager() => _instance;
//   static final PushNotificationManager _instance = PushNotificationManager._();
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//   final bool _initialized = false;
//
//   Future<void> init() async {
//     if (!_initialized) {
//       //ios
//       _firebaseMessaging.requestPermission();
//
//       String? token = await _firebaseMessaging.getToken();
//       print('the token is $token');
//     }
//   }
// }
