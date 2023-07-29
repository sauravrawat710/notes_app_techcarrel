import 'package:flutter/material.dart';
import '../models/note.dart';
import '../utlis/note_database_helper.dart';

class NoteProvider with ChangeNotifier {
  final NoteDatabaseHelper _databaseHelper = NoteDatabaseHelper();
  List<Note> _notes = [];

  List<Note> get notes => _notes;

  Future<void> fetchNotes() async {
    _notes = await _databaseHelper.getNotes();
    notifyListeners();
  }

  Future<Note> getNoteById(int id) async {
    return await _databaseHelper.getNoteById(id);
  }

  Future<void> addNote(Note note) async {
    await _databaseHelper.insertNote(note);
    await fetchNotes();
  }

  Future<void> updateNote(Note note) async {
    await _databaseHelper.updateNote(note);
    await fetchNotes();
  }

  Future<void> deleteNote(int id) async {
    await _databaseHelper.deleteNote(id);
    await fetchNotes();
  }
}
