import 'package:flutter/material.dart';
//import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:simple_tracker/notifications/notification.dart';

//import 'package:awesome_notifications/awesome_notifications.dart';
class Notify extends StatefulWidget {
  const Notify({Key? key}) : super(key: key);

  @override
  _NotifyState createState() => _NotifyState();
}

class _NotifyState extends State<Notify> {
  @override
  void initState() {
    Provider.of<NotificationService>(context, listen:false).initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Consumer<NotificationService>(
              builder: (context, model, _) => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () => model.instantNofitication(),
                          child: Text("Instant Notification")),
                      ElevatedButton(
                          onPressed: () => model.sheduledNotification(),
                          child: Text("Scheduled Notification")),
                    ],
                  )),
        ),
      ),
    );
  }
}
