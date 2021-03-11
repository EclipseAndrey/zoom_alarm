import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:zoom_alarm/UI/EditPage.dart';
import 'package:zoom_alarm/UI/HomePage.dart';
import 'package:zoom_alarm/UI/InitialPage.dart';
import 'package:zoom_alarm/generated/l10n.dart';
import 'package:zoom_alarm/routes.dart';

import 'InitNotifications.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      title: 'Flutter Demo',
      theme: ThemeData(
      ),
      initialRoute: Routes.initial,
      routes: <String, WidgetBuilder>{
        Routes.initial: (BuildContext context) => InitialPage(),
        Routes.home: (BuildContext context) => HomePage(),
        Routes.edit: (BuildContext context) => EditPage(),
      },
    );
  }
}

