// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "Friday" : MessageLookupByLibrary.simpleMessage("Пятница"),
    "Monday" : MessageLookupByLibrary.simpleMessage("Понедельник"),
    "Saturday" : MessageLookupByLibrary.simpleMessage("Суббота"),
    "Sunday" : MessageLookupByLibrary.simpleMessage("Воскресенье"),
    "Thursday" : MessageLookupByLibrary.simpleMessage("Четверг"),
    "Tuesday" : MessageLookupByLibrary.simpleMessage("Вторник"),
    "Wednesday" : MessageLookupByLibrary.simpleMessage("Среда"),
    "app_name" : MessageLookupByLibrary.simpleMessage("Zoom Manager"),
    "button_add" : MessageLookupByLibrary.simpleMessage("Добавить напоминалку"),
    "date_null" : MessageLookupByLibrary.simpleMessage("Выбрать время"),
    "delete" : MessageLookupByLibrary.simpleMessage("Удалить"),
    "desc" : MessageLookupByLibrary.simpleMessage("Описание конференции"),
    "err_desc" : MessageLookupByLibrary.simpleMessage("Описание не заполнено"),
    "err_ok" : MessageLookupByLibrary.simpleMessage("Добавлено"),
    "err_time" : MessageLookupByLibrary.simpleMessage("Время не выбрано"),
    "err_url" : MessageLookupByLibrary.simpleMessage("Сыылка некорректна"),
    "header_actual" : MessageLookupByLibrary.simpleMessage("Ближайшая конференция"),
    "header_future" : MessageLookupByLibrary.simpleMessage("Запланированные"),
    "header_past" : MessageLookupByLibrary.simpleMessage("Прошедшие"),
    "save" : MessageLookupByLibrary.simpleMessage("Добавить"),
    "today" : MessageLookupByLibrary.simpleMessage("Сегодня"),
    "tomorrow" : MessageLookupByLibrary.simpleMessage("Завтра"),
    "url" : MessageLookupByLibrary.simpleMessage("Ссылка на Zoom"),
    "yesterday" : MessageLookupByLibrary.simpleMessage("Вчера")
  };
}
