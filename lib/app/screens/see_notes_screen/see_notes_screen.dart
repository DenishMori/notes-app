import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/app/screens/add_notes_screen/add_notes.dart';
import 'package:notes_app/app/screens/home_screen/componentes/action_button.dart';
import 'package:notes_app/app/screens/home_screen/componentes/note_delete_alert_dialog.dart';
import 'package:notes_app/bloc/notes_block/add_notes_event.dart';
import 'package:notes_app/bloc/notes_block/notes_bloc.dart';
import 'package:notes_app/model/notes.dart';
import 'package:notes_app/utils/app_color.dart';
import 'package:notes_app/utils/helper_widget.dart';

class SeeNotesScreen extends StatefulWidget {
  const SeeNotesScreen({super.key, this.note});
  static String route = '/see_notes_screen';
  final Note? note;
  @override
  State<SeeNotesScreen> createState() => _SeeNotesScreenState();
}

class _SeeNotesScreenState extends State<SeeNotesScreen> {
  Note? _note;

  @override
  void initState() {
    super.initState();
    _note = widget.note;
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: actionButton(
            context,
            onTap: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        title: const Text(
          "Note",
          style: TextStyle(color: AppColors.codGray),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: actionButton(
              context,
              icon: const Icon(Icons.delete_outline),
              onTap: () async {
                bool isAgree = await showDeleteNoteDialog(context);
                if (isAgree) {
                  Future.delayed(Duration.zero, () {
                    context
                        .read<NotesBloc>()
                        .add(DeleteNoteEvent(id: _note?.id));
                    Navigator.pop(context);
                  });
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: actionButton(
              context,
              icon: const Icon(Icons.edit_note),
              onTap: () async {
                _note = await Navigator.push(context,
                    MaterialPageRoute(builder: (_) {
                  return AddNotesScreen(
                    note: _note,
                  );
                }));
              },
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(
          top: _size.height * 0.02,
          left: _size.height * 0.035,
          right: _size.height * 0.035,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: Text(
                _note?.title ?? '',
                maxLines: null,
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: AppColors.codGray,
                      fontSize: _size.width * 0.06,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
            addVerticalSpace(10),
            Text(
              _note?.note ?? '',
              maxLines: null,
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: AppColors.codGray,
                    fontSize: _size.width * 0.06,
                    fontWeight: FontWeight.w500,
                  ),
            )
          ],
        ),
      ),
    );
  }
}
