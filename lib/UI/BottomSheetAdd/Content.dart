import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:zoom_alarm/DBManager/DB.dart';
import 'package:zoom_alarm/InitNotifications.dart';
import 'package:zoom_alarm/MV/Notes.dart';
import 'package:zoom_alarm/Models/Note.dart';
import 'package:zoom_alarm/Style.dart';
import 'package:zoom_alarm/generated/l10n.dart';
import 'package:zoom_alarm/utils/time_formatter.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddContent extends StatefulWidget {
  bool edit;
  Note note;

  AddContent() {
    edit = false;
  }

  AddContent.edit(this.note) {
    edit = true;
  }

  @override
  _AddContentState createState() => _AddContentState();
}

class _AddContentState extends State<AddContent> {
  NotesWidgetModel notesWidgetModel;

  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerUrl = TextEditingController();
  DateTime currentTime;
  FocusNode focusNameProperty = FocusNode();

  FToast fToast;

  @override
  void initState() {
    notesWidgetModel = NotesWidgetModel();

    super.initState();
    fToast = FToast();
    fToast.init(context);

    if (widget.edit) {
      controllerName.text = widget.note.name;
      controllerUrl.text = widget.note.link;
      currentTime = widget.note.date;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        // height: MediaQuery.of(context).size.height*0.95,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            children: [
              SizedBox(
                height: 18,
              ),
              _buttonDateTime(),
              SizedBox(
                height: 18,
              ),
              _inputLink(),
              SizedBox(
                height: 18,
              ),
              _inputDesk(),
              SizedBox(
                height: 18,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  widget.edit ? _buttonDelete() : SizedBox(),
                  SizedBox(
                    width: widget.edit ? 18 : 0,
                  ),
                  _buttonSave(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buttonDateTime() {
    return GestureDetector(
      onTap: () {
        DatePicker.showDateTimePicker(context, showTitleActions: true,
            onChanged: (date) {
          print('change $date');
        }, onConfirm: (date) {
          currentTime = date;
          setState(() {});
          print('confirm $date');
        }, currentTime: DateTime.now(), locale: LocaleType.ru);
      },
      child: Container(
        decoration: BoxDecoration(
            color: cBlue, borderRadius: BorderRadius.all(Radius.circular(12))),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            currentTime == null
                ? S.of(context).date_null
                : getDateRussian(currentTime, context),
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

  _buttonSave() {
    return GestureDetector(
      onTap: () async {
        _save();
      },
      child: Container(
        decoration: BoxDecoration(
            color: cBlue, borderRadius: BorderRadius.all(Radius.circular(12))),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            S.of(context).save,
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

  _buttonDelete() {
    return GestureDetector(
      onTap: () async {
        _delete();
      },
      child: Container(
        decoration: BoxDecoration(
            color: cPay, borderRadius: BorderRadius.all(Radius.circular(12))),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            S.of(context).delete,
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

  _inputLink() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: cBlue),
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: TextField(
          //focusNode: focusNameProperty,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintStyle: TextStyle(
              fontSize: 14,
              color: Color.fromRGBO(153, 155, 158, 1),
            ),
            hintText: S.of(context).url,
          ),
          style: TextStyle(
              color: Color.fromRGBO(47, 82, 127, 1),
              fontSize: 14,
              fontWeight: FontWeight.w700,
              fontFamily: fontFamily),
          controller: controllerUrl,
        ),
      ),
    );
  }

  _inputDesk() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: cBlue),
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: TextField(
          //focusNode: focusNameProperty,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintStyle: TextStyle(
              fontSize: 14,
              color: Color.fromRGBO(153, 155, 158, 1),
            ),
            hintText: S.of(context).desc,
          ),
          style: TextStyle(
              color: Color.fromRGBO(47, 82, 127, 1),
              fontSize: 14,
              fontWeight: FontWeight.w700,
              fontFamily: fontFamily),
          controller: controllerName,
        ),
      ),
    );
  }

  _showToastError(String text) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.greenAccent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check),
          SizedBox(
            width: 12.0,
          ),
          Text(text),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );

    // Custom Toast Position
  }

  _save() async {
    if (currentTime == null) {
      _showToastError(S.of(context).err_time);
    } else if (controllerUrl == null || controllerUrl.text.isEmpty) {
      _showToastError(S.of(context).err_url);
    } else if (controllerName == null || controllerName.text.isEmpty) {
      _showToastError(S.of(context).err_desc);
    } else {
      if (widget.edit) {
        await DBProvider.db.deleteNote(widget.note.id);
      }
      notesWidgetModel.addNote(Note(
          status: "on",
          date: currentTime,
          link: controllerUrl.text,
          name: controllerName.text,
          idNotification: 0));

      Navigator.pop(context);
      _showToastError(S.of(context).err_ok);
    }
  }

  _delete() async {
    await notesWidgetModel.deleteNote(widget.note.id);
    Navigator.pop(context);
  }
}
