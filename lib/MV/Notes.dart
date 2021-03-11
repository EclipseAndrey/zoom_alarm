import 'dart:async';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:zoom_alarm/DBManager/DB.dart';
import 'package:zoom_alarm/InitNotifications.dart' as init;
import 'package:zoom_alarm/Models/DBInterface.dart';
import 'package:zoom_alarm/Models/Note.dart';
import 'package:zoom_alarm/utils/sort_notes.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotesWidgetModel {

  final _streamController = StreamController<SortNote>.broadcast();

  get stream => _streamController.stream;

  DBInterface db = DBProvider.db;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = init.flutterLocalNotificationsPlugin;


  getNotes() async {
    SortNote sortNote = SortNote();
    List<Note> listNotes = await DBProvider.db.getNotes();
    if (listNotes.isEmpty) {
      sortNote.clean();
    } else {
      sortNote.clean();
      for (int i = 0; i < listNotes.length; i++) {
        print(listNotes[i].date.toString());
        if (listNotes[i].date.isAfter(DateTime.now())) {
          sortNote.future.add(listNotes[i]);
        } else {
          sortNote.past.add(listNotes[i]);
        }
      }
      if (sortNote.future.isNotEmpty) {
        Note stepNote = sortNote.future[0];
        for (int i = 1; i < sortNote.future.length; i++) {
          if (stepNote.date.isAfter(sortNote.future[i].date)) {
            stepNote = sortNote.future[i];
          }
        }
        sortNote.actual = [stepNote];
      }
    }
    sortNote.past = await sortNotes(sortNote.past, reverse: true);
    sortNote.future = await sortNotes(sortNote.future, reverse: false);
    if (sortNote.future.length > 0) sortNote.future.removeAt(0);
    _streamController.sink.add(sortNote);
  }

  void addNote(Note note) async {
    print('add note');
    note.id = await db.insertNote(note);
    await setNotification(note);
    getNotes();
  }

  deleteNote(int id)async{
    await  db.deleteNote(id);
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  void launch(String url) async {
    print("launch");
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  setNotification(Note note) async {

    tz.initializeTimeZones();

    tz.TZDateTime scheduledDate = tz.TZDateTime.from(note.date, tz.local);

    await flutterLocalNotificationsPlugin.zonedSchedule(
        note.id ?? 0,
        "Zoom Alarm ",
        note.name,
        scheduledDate,

        const NotificationDetails(

            android: AndroidNotificationDetails('full screen channel id',
                'full screen channel name', 'full screen channel description',
                priority: Priority.high,
                importance: Importance.high,
                fullScreenIntent: true)),
        payload: json.encode(note.toMap()),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,

    );
  }

  deleteNotification(int id)async{
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  close() {
    _streamController.close();
  }
}
