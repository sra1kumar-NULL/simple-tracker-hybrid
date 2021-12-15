import 'package:flutter/material.dart';
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
        initializationSettings,onSelectNotification: _addItem());
  }
  
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
        ticker: "Reply",
        styleInformation: bigPicture,
        importance: Importance.max,
        ongoing: true,
        );

    var platform = new NotificationDetails(android: android);

    await _flutterLocalNotificationsPlugin.periodicallyShow(
        0,
        "Demo Sheduled notification",
        "tap to do something",
        interval,
        platform);
  }
  _addItem(){
    debugPrint("This is Due to Clicking Notification");
  }
}