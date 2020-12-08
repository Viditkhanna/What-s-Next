import 'package:flutter/cupertino.dart';
import 'package:whats_next/db_helper/db_helper.dart';
import 'package:whats_next/models/notes_model.dart';

enum NoteStatus { PENDING, COMPLETE }

var statusMap = {
  NoteStatus.PENDING: 'pending',
  NoteStatus.COMPLETE: 'complete',
};

class AppBloc with ChangeNotifier {
  final _dbHelper = DatabaseHelper.instance;

  Future<List<NotesModel>> _notes;

  AppBloc() {
    _notes = _dbHelper.queryAllRows().then((value) {
      return value.map((e) => NotesModel.fromMap(e)).toList();
    });
  }

  Future<List<NotesModel>> get notes async => await _notes;

  Future<void> addNote(String val) async {
    if (val.trim().isEmpty) return;

    await _dbHelper.insert({
      DatabaseHelper.columnNote: val.trim(),
      DatabaseHelper.columnStatus: 'pending',
    });
    return refreshNotes();
  }

  Future<void> changeNoteStatus(id, NoteStatus val) async {
    await _dbHelper.update({
      DatabaseHelper.columnId: id,
      DatabaseHelper.columnStatus: statusMap[val],
    });
    return refreshNotes();
  }

  Future<void> updateNote(id, String val) async {
    if (val.trim().isEmpty) return;

    await _dbHelper.update({
      DatabaseHelper.columnId: id,
      DatabaseHelper.columnStatus: val.trim(),
    });
    return refreshNotes();
  }

  Future<void> deleteNote(id) async {
    await _dbHelper.delete(id);
    return refreshNotes();
  }

  void refreshNotes() {
    _notes = _dbHelper.queryAllRows().then((value) {
      return value.map((e) => NotesModel.fromMap(e)).toList();
    });
    _notes.then((value) {
      notifyListeners();
    });
  }
}
