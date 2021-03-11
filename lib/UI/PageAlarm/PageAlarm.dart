import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zoom_alarm/Models/AlarmData.dart';
import 'package:zoom_alarm/Models/Note.dart';
import 'package:zoom_alarm/Style.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:zoom_alarm/routes.dart';

class PageAlarm extends StatefulWidget {
  Note data;

  PageAlarm(this.data);

  @override
  _PageAlarmState createState() => _PageAlarmState();
}

class _PageAlarmState extends State<PageAlarm> with TickerProviderStateMixin {
  double animateValue = 0;

  Animation<double> animation;
  AnimationController animationController;
  CurveTween tween = CurveTween(curve: Curves.linear);
  int _duration = 1200;

  AudioCache cache = AudioCache();
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: _duration));
    animationController.addListener(() {
      setState(() {});
    });
    animation = tween.animate(animationController);
    animationController.repeat();
    play();
  }

  stopAndPlay() async {
    stop();
    play();
  }

  play() async {
    audioPlayer = await cache.loop("audio/alarm_sound.mp3");
  }

  stop() async {
    print("STOPPED");
    audioPlayer.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: _content()),
    );
  }

  Widget _content() {
    return Container(
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                head(),
                _description(),
                SizedBox(
                  height: 30,
                ),
                animatedLogo(),
                SizedBox(
                  height: 30,
                ),
                Spacer(),
                buttonOpenZoom(onTap: () {
                  stop();
                  openInZoom();
                }),
                SizedBox(
                  height: 30,
                ),
                buttonDelay(onTap: () {
                  stop();
                }),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget head() {
    return Text(
      "Напоминание",
      textAlign: TextAlign.center,
      style: TextStyle(
          color: cMainText,
          fontSize: 28,
          fontWeight: FontWeight.w600,
          fontFamily: fontFamily),
    );
  }

  Widget _description() {
    return Text(
      widget.data.name,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: cMainText,
          fontSize: 20,
          fontWeight: FontWeight.w400,
          fontFamily: fontFamily),
    );
  }

  Widget animatedLogo() {
    if (animation.value != null) {
      if (animation.value < 0.5) {
        animateValue = animation.value * 2;
      } else {
        animateValue = 2 - animation.value * 2;
      }
    }

    return Container(
      width: MediaQuery.of(context).size.width * 0.4 + 20,
      height: MediaQuery.of(context).size.width * 0.4 + 20,
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.4 + (20 * animateValue),
          height: MediaQuery.of(context).size.width * 0.4 + (20 * animateValue),
          child: Image.asset(
            "assets/images/logo.png",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget buttonOpenZoom({Function onTap}) {
    return GestureDetector(
      behavior: HitTestBehavior.deferToChild,
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: cBlue, borderRadius: BorderRadius.all(Radius.circular(50))),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            "Открыть в Zoom",
            style: TextStyle(
                color: cWhite,
                fontWeight: FontWeight.w500,
                fontSize: 18,
                fontFamily: fontFamily),
          ),
        ),
      ),
    );
  }

  Widget buttonCloseAlarm() {}

  Widget buttonDelay({Function onTap}) {
    return GestureDetector(
      behavior: HitTestBehavior.deferToChild,
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: cWhite,
            borderRadius: BorderRadius.all(Radius.circular(50)),
            border: Border.all(color: cBlue, width: 2)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            "Отложить на 10 мин.",
            style: TextStyle(
                color: cMainText,
                fontWeight: FontWeight.w500,
                fontSize: 18,
                fontFamily: fontFamily),
          ),
        ),
      ),
    );
  }

  openInZoom() async {
    print("launch");
    goToHomePage();
    if (await canLaunch(widget.data.link)) {
      await launch(widget.data.link);

    } else {
      throw 'Could not launch ${widget.data.link}';
    }
  }

  void goToHomePage() async {
    // await Future.delayed(Duration(milliseconds: 2500));
    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>PageAlarm(null)));
    Navigator.pushReplacementNamed(context, Routes.home);
  }
}
