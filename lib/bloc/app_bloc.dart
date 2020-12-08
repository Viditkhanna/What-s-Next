import 'package:flutter/cupertino.dart';
import 'package:whats_next/db_helper/db_helper.dart';

class AppBloc with ChangeNotifier {
  final _dbHelper = DatabaseHelper.instance;

  Future<List<Map<String, dynamic>>> _notes;

  AppBloc() {
    _notes = _dbHelper.queryAllRows();
  }

  Future<List<Map<String, dynamic>>> get notes async => await _notes;

  Future<void> addNote(String val) async {
    if (val.trim().isEmpty) return;

    await _dbHelper.insert({
      DatabaseHelper.columnNote: val.trim(),
      DatabaseHelper.columnStatus: 'pending',
    });
    return refreshNotes();
  }

  Future<void> changeNoteStatus(id, val) async {
    await _dbHelper.update({
      DatabaseHelper.columnId: id,
      DatabaseHelper.columnStatus: val,
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
    _notes = _dbHelper.queryAllRows().whenComplete(() {
      notifyListeners();
    });
  }
}
