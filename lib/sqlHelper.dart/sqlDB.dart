import 'dart:io';

import 'package:sqflite/sqflite.dart';
import "package:path/path.dart";

import '../sqlModel.dart/sqlModelClass.dart';

// Create a class that holds the version and Database name //

class DatabaseHelper {
  static const int _version = 1;
  static const String _dbName = "Notes.db";

  // Create a db connection //

  static Future<Database> _getDB() async {
    return openDatabase(join(await getDatabasesPath(), _dbName),
        onCreate: ((db, version) async => await db.execute(
            "CREATE TABLE Note(id INTEGER PRIMARY KEY, title TEXT NOT NULL, description TEXT NOT NULL);")),
        version: _version);
  }

  // CRUD Operation *Create *Read *Update *Delete //
  //.............................................//

  //*Create

  static Future<int> createNote(Note note) async {
    final db = await _getDB();
    return db.insert("Note", note.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  //*Update

  static Future<int> updateNote(Note note) async {
    final db = await _getDB();
    return db.update("Note", note.toJson(),
        where: "id = ?",
        whereArgs: [note.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  //* Delete

  static Future<int> deleteNote(Note note) async {
    final db = await _getDB();
    return db.delete(
      "Note",
      where: "id = ?",
      whereArgs: [note.id],
    );
  }

// Fetch all Data from Database //

  static Future<List<Note>?> fetchDb() async {
    final db = await _getDB();

    final List<Map<String, dynamic>> map = await db.query("Note");

    if (map.isEmpty) {
      return null;
    }
    return List.generate(map.length, (index) => Note.fromJson(map[index]));
  }
}
