import 'package:zoom_alarm/Models/Note.dart';

Future<List<Note>> sortNotes(List<Note> list, {bool reverse}) async {
  for (int i = list.length - 1; i > 0; i--) {
    for (int j = 0; j < i; j++) {
      if (list[j].date.isAfter(list[j + 1].date)) {
        print("SORT OK");
        list.replaceRange(j, j + 2, [list[j + 1], list[j]]);
      }
    }
  }
  for (int i = 0; i < list.length; i++) {
    print("sort" + list[i].date.toString());
  }
  if (reverse != null && reverse) {
    return list.reversed.toList();
  } else {
    return list;
  }
}
