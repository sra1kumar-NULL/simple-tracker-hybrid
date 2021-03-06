import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_tracker/authentication/sign_in.dart';
import 'package:simple_tracker/notifications/notification.dart';
import 'package:simple_tracker/notifications/notify.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:simple_tracker/notifications/fcmnotifications.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      child: MaterialApp(
        home: SignIn(),
        debugShowCheckedModeBanner: false,
      ),
      providers: [
        ChangeNotifierProvider(create: (_)=>NotificationService())
      ],
    );
  }

  // This widget is the root of your application.
  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     home:Notify()
  //   );
  // }
}
