import 'package:notes_app/model/notes.dart';

abstract class NotesEvent {
  NotesEvent({this.notes});

  List<Note>? notes;
}

class GetAllNotesEvents extends NotesEvent {}

class CreateNoteEvent extends NotesEvent {
  Note? note;
  CreateNoteEvent({this.note});
}

class DeleteNoteEvent extends NotesEvent {
  int? id;

  DeleteNoteEvent({this.id});
}

class UpdateNoteEvent extends NotesEvent {
  Note? note;
  UpdateNoteEvent({this.note});
}

class ShowNotesListEvent extends NotesEvent {}

class ShowNotesGridEvent extends NotesEvent {}

class CloseDbEvent extends NotesEvent {}
