import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:zoom_alarm/UI/HomePage.dart';
import 'package:zoom_alarm/UI/InitialPage.dart';
import 'package:zoom_alarm/generated/l10n.dart';
import 'package:zoom_alarm/routes.dart';

import 'InitNotifications.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
      theme: ThemeData(),
      initialRoute: Routes.initial,
      routes: <String, WidgetBuilder>{
        Routes.initial: (BuildContext context) => InitialPage(),
        Routes.home: (BuildContext context) => HomePage(),
      },
    );
  }
}
