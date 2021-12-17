import 'dart:typed_data';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:simple_tracker/store/DisplayW.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FcNotification extends ChangeNotifier {
  FcHome _fcHome=FcHome();
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

    var fcHome;
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,onSelectNotification: fcHome._onSelectNotification
    );
  }
  Future sheduledNotification() async {
    var interval = RepeatInterval.everyMinute;

    var bigPicture =  BigPictureStyleInformation(
        DrawableResourceAndroidBitmap("iconfile"),
        largeIcon: DrawableResourceAndroidBitmap("iconfile"),
        contentTitle: "Height Reminder",
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
class FcHome extends StatefulWidget {
  const FcHome({Key? key}) : super(key: key);

  @override
  _FcHomeState createState() => _FcHomeState();
}

class _FcHomeState extends State<FcHome> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fc HOME"),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              child: Text("Click To Start Notification service"),
              onPressed: (){
                FcNotification fcNotification=FcNotification();
                fcNotification.sheduledNotification;
              },
            ),
            SizedBox(
              height: 50,

            ),
            ElevatedButton(
              child: Text("Click to Cancel Notifications"),
              onPressed: (){
                FcNotification fcNotification=FcNotification();
                fcNotification.cancelAll();
              },

            )

          ],
        ),
      ),
    );
  }
  _onSelectNotification(){
    return TextField(
      autofocus: true,
    );
  }
}
