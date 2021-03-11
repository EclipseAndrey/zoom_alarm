import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:zoom_alarm/Models/Note.dart';
import 'package:zoom_alarm/UI/PageAlarm/PageAlarm.dart';
import 'package:zoom_alarm/routes.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

Future<bool> initNotifications(BuildContext context) async {
  Future selectNotification(String payload) async {
    if (payload != null) {
      debugPrint('main notification payload: $payload');
    }
  }

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  final IOSInitializationSettings initializationSettingsIOS =
      IOSInitializationSettings(
    requestSoundPermission: true,
    requestBadgePermission: true,
    requestAlertPermission: true,
    onDidReceiveLocalNotification: (id, title, body, payload) {
      return null;
    },
  );
  final MacOSInitializationSettings initializationSettingsMacOS =
      MacOSInitializationSettings(
          requestAlertPermission: false,
          requestBadgePermission: false,
          requestSoundPermission: false);
  final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
      macOS: initializationSettingsMacOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: selectNotification);

  final NotificationAppLaunchDetails notificationAppLaunchDetails =
      await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  print("Details start " +
      notificationAppLaunchDetails.didNotificationLaunchApp.toString());

  if (notificationAppLaunchDetails.didNotificationLaunchApp) {
    print(notificationAppLaunchDetails.payload);
    goToAlarmPage(context,
        Note.fromMap(json.decode(notificationAppLaunchDetails.payload)));
    return true;
  } else {
    return false;
  }
}

void goToAlarmPage(BuildContext context, Note note) async {
  await Future.delayed(Duration(milliseconds: 2500));
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => PageAlarm(note)));
}
