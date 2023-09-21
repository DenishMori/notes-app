import 'package:notes_app/database/db_helper.dart';
import 'package:notes_app/model/notes.dart';

class Repositary {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  Future<List<Note>> getAllNotes() async => await _dbHelper.readAllNotes();
  Future<void> closeDb() async => await _dbHelper.closeDatabase();
  Future<Note> createNoteInDb(Note note) async =>
      await _dbHelper.insertNotes(note);
  Future<bool> deleteNoteFromDb(int id) async =>
      await _dbHelper.deleteNotes(id);
  Future<bool> updateNoteInDb(Note note) async =>
      await _dbHelper.updateNotes(note);
}
