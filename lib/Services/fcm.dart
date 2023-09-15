import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void registerNotification() async {
    firebaseMessaging.requestPermission();
    firebaseMessaging.getToken().then((token) {
      // sharedPrefs.setFcmtoken(token!);
      // _cash.setDeviceToken(token!);
      print('device token is ${token}');
    }).catchError((err) {});

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {}
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      showNotification(message);
      print(message.notification!.title);
      print(message.notification!.body);
      print(message.notification!.android!.clickAction);

      return;
    });
  }

  Future? showNotification(RemoteMessage? remoteNotification) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'intwin',
      'intwin_channel',
      playSound: true,
      // sound: RawResourceAndroidNotificationSound('synth'),
      enableVibration: true,
      importance: Importance.max,
      priority: Priority.high,
    );

    if (Platform.isAndroid) {
      const AndroidNotificationChannel channel = AndroidNotificationChannel(
        'high_importance_channel',
        'High Importance Notifications',
        importance: Importance.max,
      );
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);
    }
    DarwinNotificationDetails darwinNotificationDetails =
        const DarwinNotificationDetails(
            categoryIdentifier: 'textCategory', presentSound: true);
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);
    NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: darwinNotificationDetails);

    await flutterLocalNotificationsPlugin.show(
        0,
        remoteNotification!.notification?.title,
        remoteNotification.notification?.body,
        platformChannelSpecifics,
        payload: null);
  }

  void configLocalNotification() {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsDarwin);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }
}