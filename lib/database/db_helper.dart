import 'dart:async';
import 'dart:developer';
import 'package:notes_app/model/notes.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class DatabaseHelper {
  DatabaseHelper.init();

  static Database? database;
  static DatabaseHelper? _databaseHelper;
  Future<Database> getDb() async {
    return database ??= await _initDatabase();
  }

  factory DatabaseHelper() {
    return _databaseHelper ??= DatabaseHelper.init();
  }

  Future<Database> _initDatabase() async {
    final String databasePath = await getDatabasesPath();
    final String databaseFilePath = path.join(databasePath, 'notes.db');

    return await openDatabase(databaseFilePath,
        version: 1, onCreate: _createDatabase);
  }

  static FutureOr<void> _createDatabase(Database db, int version) {
    db.execute(
      'CREATE TABLE tbl_notes (note_id INTEGER PRIMARY KEY, note_title TEXT, note_desc TEXT)',
    );
  }

  Future<void> closeDatabase() async {
    final Database database = await getDb();
    await database.close();
  }

  Future<Note> insertNotes(Note note) async {
    final Database database = await getDb();
    int id = await database.insert('tbl_notes', note.toMap());
    if (id > 0) {
      return note.copyWith(id: id);
    } else {
      throw Exception('Data is not inserted');
    }
  }

  Future<List<Note>> readAllNotes() async {
    final Database database = await getDb();
    List<Map<String, Object?>> queryList = await database.query('tbl_notes');
    log("------------- $queryList");
    return queryList.map((e) => Note.fromJson(e)).toList();
  }

  Future<bool> deleteNotes(int id) async {
    final Database database = await getDb();
    int affectedRow = await database.delete(
      'tbl_notes',
      where: 'note_id = ?',
      whereArgs: [id],
    );
    return affectedRow > 0;
  }

  Future<bool> updateNotes(Note note) async {
    final Database database = await getDb();
    int affectedRow = await database.update(
      'tbl_notes',
      note.toMap(),
      where: 'note_id = ?',
      whereArgs: [note.id],
    );
    return affectedRow > 0;
  }
}
