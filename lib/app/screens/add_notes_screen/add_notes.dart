import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/bloc/notes_block/add_notes_event.dart';
import 'package:notes_app/bloc/notes_block/notes_bloc.dart';
import 'package:notes_app/model/notes.dart';
import 'package:notes_app/utils/text_styles.dart';

class AddNotesScreen extends StatefulWidget {
  const AddNotesScreen({super.key, this.appBarTitle, this.note});
  final String? appBarTitle;
  final Note? note;
  static String route = '/add_notes';

  @override
  State<AddNotesScreen> createState() => _AddNotesScreenState();
}

class _AddNotesScreenState extends State<AddNotesScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey();
  late Note _note;
  @override
  void initState() {
    super.initState();
    _titleController.text = widget.note?.title ?? "";
    _descController.text = widget.note?.note ?? "";
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _descController.dispose();
  }

  onTapSave() {
    bool isvalid = _formkey.currentState!.validate();

    if (isvalid) {
      if (widget.note != null) {
        updateNote();
        Navigator.pop(context, _note);
      } else {
        insertNote();
        Navigator.pop(context);
      }
    }
  }

  insertNote() {
    context.read<NotesBloc>().add(CreateNoteEvent(
          note: Note(
            title: _titleController.text,
            note: _descController.text,
          ),
        ));
  }

  updateNote() {
    _note = widget.note!
        .copyWith(title: _titleController.text, note: _descController.text);

    context.read<NotesBloc>().add(UpdateNoteEvent(note: _note));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            FocusManager.instance.primaryFocus?.unfocus();

            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black38,
          ),
        ),
        title: Text(
          widget.appBarTitle ?? "Screen",
          style: CustomTextStyle.textStyle(20),
        ),
        actions: [
          InkWell(
            onTap: () => onTapSave(),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.save_outlined,
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
      body: Form(
        key: _formkey,
        child: Column(
          children: [
            TextFormField(
              controller: _titleController,
              cursorColor: Colors.black38,
              decoration: InputDecoration(
                  hintText: "Title",
                  hintStyle: CustomTextStyle.textStyle(20),
                  focusedBorder: InputBorder.none,
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: InputBorder.none),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: TextFormField(
                  controller: _descController,
                  cursorColor: Colors.black38,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  autofocus: true,
                  decoration: InputDecoration(
                      hintText: "Add note",
                      hintStyle: CustomTextStyle.textStyle(18),
                      focusedBorder: InputBorder.none,
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: InputBorder.none),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
