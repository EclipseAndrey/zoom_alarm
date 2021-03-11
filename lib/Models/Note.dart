import 'package:flutter/material.dart';
import 'package:zoom_alarm/DBManager/DB.dart';
import 'package:zoom_alarm/utils/time_formatter.dart';

class SortNote {
  List<Note> actual;
  List<Note> future;
  List<Note> past;

  clean (){
    actual = [];
    future = [];
    past= [];
  }
}



class Note {
  int id;
  int idNotification;
  String name;
  String status;
  DateTime date;
  String link;

  Note({
    this.id,
    @required this.idNotification,
    @required this.name,
    @required this.status,
    @required this.date,
    @required this.link,
  });

  factory Note.fromMap(Map<String, dynamic> map) {
    return new Note(
      id: map[ DBTable.id] as int,
      idNotification: map[DBTable.idNotification] as int,
      name: map[DBTable.name] as String,
      status: map[DBTable.status] as String,
      date: fromDBTime(map[DBTable.date].toString()) ,
      link: map[DBTable.link] as String,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      DBTable.idNotification: this.idNotification,
      DBTable.name: this.name,
      DBTable.status: this.status,
      DBTable.date: setDBTime(this.date),
      DBTable.link: this.link,
    } as Map<String, dynamic>;
  }
}