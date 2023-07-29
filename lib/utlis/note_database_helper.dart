import '../models/note.dart';
import 'package:sqflite/sqflite.dart';

class NoteDatabaseHelper {
  static final NoteDatabaseHelper _instance = NoteDatabaseHelper._();
  factory NoteDatabaseHelper() => _instance;
  NoteDatabaseHelper._();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = '$dbPath/notes.db';
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE notes(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        content TEXT,
        modifiedTime INTEGER
      )
    ''');
  }

  Future<List<Note>> getNotes() async {
    final db = await database;
    final result = await db.query('notes', orderBy: 'modifiedTime DESC');
    return result.map((noteMap) => Note.fromMap(noteMap)).toList();
  }

  Future<Note> getNoteById(int id) async {
    final db = await database;
    final result = await db.query('notes', where: 'id = ?', whereArgs: [id]);
    return Note.fromMap(result.first);
  }

  Future<void> insertNote(Note note) async {
    final db = await database;
    await db.insert('notes', note.toMap());
  }

  Future<void> updateNote(Note note) async {
    final db = await database;
    await db
        .update('notes', note.toMap(), where: 'id = ?', whereArgs: [note.id]);
  }

  Future<void> deleteNote(int id) async {
    final db = await database;
    await db.delete('notes', where: 'id = ?', whereArgs: [id]);
  }
}
