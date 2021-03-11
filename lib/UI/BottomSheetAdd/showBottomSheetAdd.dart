import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zoom_alarm/Models/Note.dart';
import 'package:zoom_alarm/UI/BottomSheetAdd/Content.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

Future<void> showBottomSheetAdd(BuildContext context, {bool edit, Note note}) async{
  await showBarModalBottomSheet(
      context: context, builder: (context,data) => (edit != null && edit)?AddContent.edit(note):AddContent(),
  );
}
