import 'dart:typed_data';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:simple_tracker/store/DisplayW.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService extends ChangeNotifier {

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  //final MethoCall _methoCall=MethodCall(_add,payload);
  //final Int32List flags=Int32List(3);
  Future initialize() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

    AndroidInitializationSettings androidInitializationSettings =
    AndroidInitializationSettings("iconfile");

    IOSInitializationSettings iosInitializationSettings =
    IOSInitializationSettings();

    final InitializationSettings initializationSettings =
    InitializationSettings(
        android: androidInitializationSettings,
        iOS: iosInitializationSettings);

    await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
    );
  }

  // Future selectNotification(String payload) async {
  //   if (payload != null) {
  //     print('notification payload: $payload');
  //   } else {
  //     print("Notification Done");
  //   }
  //   Get.to(()=>SecondScreen(payload));
  // }


  Future sheduledNotification() async {
    var interval = RepeatInterval.hourly;

    var bigPicture = BigPictureStyleInformation(
        DrawableResourceAndroidBitmap("iconfile"),
        largeIcon: DrawableResourceAndroidBitmap("iconfile"),
        contentTitle: "Weight Reminder",
        summaryText: "Enter Your Weight",

        htmlFormatContent: true,
        htmlFormatContentTitle: true);

    var android = AndroidNotificationDetails("id", "channel",
      ticker: "Reply",
      fullScreenIntent: true,
      // additionalFlags: flags ,
      styleInformation: bigPicture,
      channelShowBadge: true,
      importance: Importance.max,
      playSound: true,
    );
    var platform = new NotificationDetails(android: android);
    await _flutterLocalNotificationsPlugin.periodicallyShow(
    0,
    "Demo Sheduled notification",
    "tap to do something",
    interval,
    platform);
  }
  Future cancelAll() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }
}
