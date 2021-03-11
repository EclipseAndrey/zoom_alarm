// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Zoom Manager`
  String get app_name {
    return Intl.message(
      'Zoom Manager',
      name: 'app_name',
      desc: '',
      args: [],
    );
  }

  /// `Добавить напоминалку`
  String get button_add {
    return Intl.message(
      'Добавить напоминалку',
      name: 'button_add',
      desc: '',
      args: [],
    );
  }

  /// `Выбрать время`
  String get date_null {
    return Intl.message(
      'Выбрать время',
      name: 'date_null',
      desc: '',
      args: [],
    );
  }

  /// `Сегодня`
  String get today {
    return Intl.message(
      'Сегодня',
      name: 'today',
      desc: '',
      args: [],
    );
  }

  /// `Завтра`
  String get tomorrow {
    return Intl.message(
      'Завтра',
      name: 'tomorrow',
      desc: '',
      args: [],
    );
  }

  /// `Вчера`
  String get yesterday {
    return Intl.message(
      'Вчера',
      name: 'yesterday',
      desc: '',
      args: [],
    );
  }

  /// `Воскресенье`
  String get Sunday {
    return Intl.message(
      'Воскресенье',
      name: 'Sunday',
      desc: '',
      args: [],
    );
  }

  /// `Понедельник`
  String get Monday {
    return Intl.message(
      'Понедельник',
      name: 'Monday',
      desc: '',
      args: [],
    );
  }

  /// `Вторник`
  String get Tuesday {
    return Intl.message(
      'Вторник',
      name: 'Tuesday',
      desc: '',
      args: [],
    );
  }

  /// `Среда`
  String get Wednesday {
    return Intl.message(
      'Среда',
      name: 'Wednesday',
      desc: '',
      args: [],
    );
  }

  /// `Четверг`
  String get Thursday {
    return Intl.message(
      'Четверг',
      name: 'Thursday',
      desc: '',
      args: [],
    );
  }

  /// `Пятница`
  String get Friday {
    return Intl.message(
      'Пятница',
      name: 'Friday',
      desc: '',
      args: [],
    );
  }

  /// `Суббота`
  String get Saturday {
    return Intl.message(
      'Суббота',
      name: 'Saturday',
      desc: '',
      args: [],
    );
  }

  /// `Добавить`
  String get save {
    return Intl.message(
      'Добавить',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Удалить`
  String get delete {
    return Intl.message(
      'Удалить',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Ссылка на Zoom`
  String get url {
    return Intl.message(
      'Ссылка на Zoom',
      name: 'url',
      desc: '',
      args: [],
    );
  }

  /// `Описание конференции`
  String get desc {
    return Intl.message(
      'Описание конференции',
      name: 'desc',
      desc: '',
      args: [],
    );
  }

  /// `Время не выбрано`
  String get err_time {
    return Intl.message(
      'Время не выбрано',
      name: 'err_time',
      desc: '',
      args: [],
    );
  }

  /// `Сыылка некорректна`
  String get err_url {
    return Intl.message(
      'Сыылка некорректна',
      name: 'err_url',
      desc: '',
      args: [],
    );
  }

  /// `Описание не заполнено`
  String get err_desc {
    return Intl.message(
      'Описание не заполнено',
      name: 'err_desc',
      desc: '',
      args: [],
    );
  }

  /// `Добавлено`
  String get err_ok {
    return Intl.message(
      'Добавлено',
      name: 'err_ok',
      desc: '',
      args: [],
    );
  }

  /// `Ближайшая конференция`
  String get header_actual {
    return Intl.message(
      'Ближайшая конференция',
      name: 'header_actual',
      desc: '',
      args: [],
    );
  }

  /// `Прошедшие`
  String get header_past {
    return Intl.message(
      'Прошедшие',
      name: 'header_past',
      desc: '',
      args: [],
    );
  }

  /// `Запланированные`
  String get header_future {
    return Intl.message(
      'Запланированные',
      name: 'header_future',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}