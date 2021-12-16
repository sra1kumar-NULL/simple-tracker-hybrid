import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:simple_tracker/store/DisplayW.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
class NotificationService extends ChangeNotifier {

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

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
  // Future onSelectNotification(String payload) async {
  //   showDialog(
  //     context: context,
  //     builder: (_) {
  //       return new AlertDialog(
  //         title: Text("Your Notification Detail"),
  //         content: Text("Payload : $payload"),
  //       );
  //     },
  //   );
  // }

  Future sheduledNotification() async {
    var interval = RepeatInterval.everyMinute;

    var bigPicture = BigPictureStyleInformation(
        DrawableResourceAndroidBitmap("iconfile"),
        largeIcon: DrawableResourceAndroidBitmap("iconfile"),
        contentTitle: "Weight Reminder",
        summaryText: "Enter Your Weight",

        htmlFormatContent: true,
        htmlFormatContentTitle: true);

    var android = AndroidNotificationDetails("id", "channel",
        ticker:"Reply",
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

}