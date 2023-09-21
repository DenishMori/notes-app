import 'package:notes_app/model/notes.dart';

abstract class AddToNotesState {}

class NotesInitialState extends AddToNotesState {}

class NotedLoadingState extends AddToNotesState {}

class NotesLoadedState extends AddToNotesState {
  List<Note>? notes;
  NotesLoadedState({
    this.notes,
  });
}

class CreateNotesState extends AddToNotesState {
  List<Note>? notes;
  CreateNotesState({
    this.notes,
  });
}

class DeleteNotesState extends AddToNotesState {
  List<Note>? notes;
  DeleteNotesState({
    this.notes,
  });
}

class UpdateNotesState extends AddToNotesState {
  List<Note>? notes;
  UpdateNotesState({
    this.notes,
  });
}

class ShowNotesListState extends AddToNotesState {
  bool? isList;
  ShowNotesListState({this.isList});
}

class ShowNotesGridtState extends AddToNotesState {
  bool? isGrid;
  ShowNotesGridtState({this.isGrid});
}

class NotesErrorState extends AddToNotesState {
  NotesErrorState(this.message);

  String message;
}
