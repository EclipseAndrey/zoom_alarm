import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:zoom_alarm/Models/DBInterface.dart';
import 'package:zoom_alarm/Models/Note.dart';

part 'Strings.dart';

class DBProvider implements DBInterface {
  DBProvider._();

  static final DBProvider db = DBProvider._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await _initDB();
    return _database;
  }

  Future<Database> _initDB() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + "base1.db";
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  void _createDB(Database db, int version) async {
    await db.execute(
      'CREATE TABLE ${DBTable.table} ( ${DBTable.id} INTEGER PRIMARY KEY AUTOINCREMENT, ${DBTable.name} TEXT, ${DBTable.link} TEXT, ${DBTable.date} DATETIME, ${DBTable.status} TEXT, ${DBTable.idNotification} INTEGER )',
    );
  }

  @override
  Future<List<Note>> getNotes() async {
    Database db = await this.database;
    final List<Map<String, dynamic>> notesMapList =
        await db.query(DBTable.table);
    final List<Note> noteList = [];
    notesMapList.forEach((element) {
      print(element.toString());
      noteList.add(Note.fromMap(element));
    });
    return noteList;
  }

  @override
  Future<int> insertNote(Note note) async {
    Database db = await this.database;
    return await db.insert(DBTable.table, note.toMap());
  }

  @override
  Future<bool> deleteNote(int id) async {
    Database db = await this.database;
    final List<Map<String, dynamic>> notesMapList = await db
        .query(DBTable.table, where: "${DBTable.id} = ?", whereArgs: [id]);
    final List<Note> noteList = [];
    notesMapList.forEach((element) {
      noteList.add(Note.fromMap(element));
    });
    if (noteList.length > 0) {
      await db
          .delete(DBTable.table, where: "${DBTable.id} = ?", whereArgs: [id]);
      return true;
    }
    return false;
  }
}
