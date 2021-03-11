import 'package:zoom_alarm/Models/Note.dart';

abstract class DBInterface {
  Future<int> insertNote(Note note);
  Future<bool> deleteNote (int id);
  Future<List<Note>> getNotes();
}