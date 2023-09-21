import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/bloc/notes_block/add_notes_event.dart';
import 'package:notes_app/bloc/notes_block/add_notes_state.dart';
import 'package:notes_app/model/notes.dart';
import 'package:notes_app/repository/repository.dart';

class NotesBloc extends Bloc<NotesEvent, AddToNotesState> {
  final Repositary _repositary = Repositary();
  NotesBloc() : super(NotesInitialState()) {
    on<GetAllNotesEvents>((event, emit) async {
      emit.call(NotedLoadingState());
      try {
        List<Note> notes = await _repositary.getAllNotes();
        emit.call(NotesLoadedState(notes: notes));
      } catch (e) {
        emit.call(NotesErrorState(e.toString()));
      }
    });
    on<DeleteNoteEvent>(
      (event, emit) async {
        _repositary.deleteNoteFromDb(event.id!);
        List<Note> notes = await _repositary.getAllNotes();
        emit.call(NotesLoadedState(notes: notes));
      },
    );

    on<CreateNoteEvent>(
      (event, emit) async {
        _repositary.createNoteInDb(event.note!);
        List<Note> notes = await _repositary.getAllNotes();
        emit.call(NotesLoadedState(notes: notes));
      },
    );

    on<UpdateNoteEvent>(
      (event, emit) async {
        _repositary.updateNoteInDb(event.note!);
        List<Note> notes = await _repositary.getAllNotes();
        emit.call(NotesLoadedState(notes: notes));
      },
    );

    on<ShowNotesGridEvent>((event, emit) async {
      emit.call(ShowNotesGridtState(isGrid: true));
    });

    on<ShowNotesListEvent>((event, emit) async {
      emit.call(ShowNotesListState(isList: false));
    });

    on<CloseDbEvent>((event, emit) async {
      await _repositary.closeDb();
    });
  }
}
