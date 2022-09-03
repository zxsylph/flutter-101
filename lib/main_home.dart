import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_101/my_dialog.dart';

class MainHome extends StatefulWidget {
  const MainHome({Key? key}) : super(key: key);

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  @override
  void initState() {
    super.initState();
    setupNoti();
  }

  Future<void> setupNoti() async {
    await Firebase.initializeApp().then((value) async {
      FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
      String? token = await firebaseMessaging.getToken();
      print('token ==> $token');

      //ตอนใช้งาน App อยู่
      FirebaseMessaging.onMessage.listen((event) {
        String? title = event.notification!.title;
        String? body = event.notification!.body;
        print('Noti ตอนเปิด App title ==> $title, body ==> $body');
        MyDialog(context: context).normalDialog(title: title!, body: body!);
      });

      //ตอนย่อ App
      FirebaseMessaging.onMessageOpenedApp.listen((event) {
        String? title = event.notification!.title;
        String? body = event.notification!.body;
        print('Noti ตอนย่อ App title ==> $title, body ==> $body');
        MyDialog(context: context).normalDialog(title: title!, body: body!);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(), body: const Text("This is Main"));
  }
}
