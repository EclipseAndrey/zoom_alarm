import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:zoom_alarm/InitNotifications.dart';
import 'package:zoom_alarm/UI/PageAlarm/PageAlarm.dart';
import 'package:zoom_alarm/routes.dart';

class InitialPage extends StatefulWidget {
  @override
  _InitialPageState createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {


  void goToHomePage() async{
    Navigator.pushReplacementNamed(context, Routes.home);
  }


  initNotificationsStart()async{
    if(!await initNotifications(context))
    goToHomePage();
  }


  @override
  void initState() {
    initNotificationsStart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFFFFFF),
        child: Center(
          child: FlareActor("assets/animation/hourglass.flr", alignment:Alignment.center, fit:BoxFit.contain, animation:"Sand Glass"),
        ),
      ),
    );
  }
}
