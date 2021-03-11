import 'package:flutter/material.dart';
import 'package:zoom_alarm/MV/Notes.dart';
import 'package:zoom_alarm/Models/Note.dart';
import 'package:zoom_alarm/Style.dart';
import 'package:zoom_alarm/generated/l10n.dart';
import 'package:zoom_alarm/utils/time_formatter.dart';

import 'BottomSheetAdd/showBottomSheetAdd.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  NotesWidgetModel notesWidgetModel;

  @override
  void initState() {
    super.initState();
    notesWidgetModel = NotesWidgetModel();
    notesWidgetModel.getNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: GestureDetector(
        onTap: () async {
          await showBottomSheetAdd(context);
          notesWidgetModel.getNotes();
        },
        child: Container(
          decoration: BoxDecoration(
              color: cBlue,
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 18),
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
      ),
      body: Container(
        color: Color.fromRGBO(250, 250, 250, 1),
        child: SafeArea(
          child: SingleChildScrollView(
            child: StreamBuilder<SortNote>(
              stream: notesWidgetModel.stream,
              builder: (context, data) {
                if (!data.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return _buildContent(data.data);
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  _buildContent(SortNote sortNote) {
    List<Widget> _outList = [];
    if (sortNote.actual.isNotEmpty) {
      _outList.add(_headerActual());
      _outList.add(_buildActualNote(sortNote.actual[0]));
    }
    if (sortNote.future.isNotEmpty) {
      _outList.add(_headerFuture());
      for (int i = 0; i < sortNote.future.length; i++) {
        _outList.add(_buildFutureNote(sortNote.future[i]));
      }
    }
    if (sortNote.past.isNotEmpty) {
      _outList.add(_headerPast());
      for (int i = 0; i < sortNote.past.length; i++) {
        _outList.add(_buildPastNote(sortNote.past[i]));
      }
    }

    if (_outList.isEmpty) {
      return Center(
        child: Text("Empty"),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _outList,
        ),
      );
    }
  }

  _headerActual() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        S.of(context).header_actual,
        style: TextStyle(
            color: cMainText.withOpacity(0.7),
            fontFamily: fontFamily,
            fontSize: 24,
            fontWeight: FontWeight.w700),
      ),
    );
  }

  _headerPast() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        S.of(context).header_past,
        style: TextStyle(
            color: cMainText.withOpacity(0.7),
            fontFamily: fontFamily,
            fontSize: 24,
            fontWeight: FontWeight.w700),
      ),
    );
  }

  _headerFuture() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        S.of(context).header_future,
        style: TextStyle(
            color: cMainText.withOpacity(0.7),
            fontFamily: fontFamily,
            fontSize: 24,
            fontWeight: FontWeight.w700),
      ),
    );
  }

  _buildActualNote(Note note) {
    return _gestureNote(
      note: note,
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            boxShadow: shadowContainer,
            color: cBlue,
            borderRadius: BorderRadius.all(Radius.circular(12))),
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: 100),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  getDateRussian(note.date, context),
                  style: TextStyle(
                      color: cWhite,
                      fontFamily: fontFamily,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  note.name,
                  style: TextStyle(
                      color: cWhite,
                      fontFamily: fontFamily,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildFutureNote(Note note) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: _gestureNote(
        note: note,
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              boxShadow: shadowContainer,
              color: cWhite,
              borderRadius: BorderRadius.all(Radius.circular(12)),
              border: Border.all(color: cBlue)),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: 100),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getDateRussian(note.date, context),
                    style: TextStyle(
                        color: cMainText,
                        fontFamily: fontFamily,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    note.name,
                    style: TextStyle(
                        color: cMainText,
                        fontFamily: fontFamily,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildPastNote(Note note) {
    return _gestureNote(
      note: note,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              boxShadow: shadowContainer,
              color: cWhite,
              borderRadius: BorderRadius.all(Radius.circular(12)),
              border: Border.all(color: cDefault)),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: 100),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getDateRussian(note.date, context),
                    style: TextStyle(
                        color: cMainText,
                        fontFamily: fontFamily,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    note.name,
                    style: TextStyle(
                        color: cMainText,
                        fontFamily: fontFamily,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _gestureNote({Widget child, Note note}) {
    return GestureDetector(
      onLongPress: () async {
        await showBottomSheetAdd(context, edit: true, note: note);
        notesWidgetModel.getNotes();
      },
      onTap: () {
        notesWidgetModel.launch(note.link);
      },
      child: child,
    );
  }
}
