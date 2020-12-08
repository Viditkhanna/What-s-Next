// To parse this JSON data, do
//
//     final notesModel = notesModelFromMap(jsonString);

import 'dart:convert';

NotesModel notesModelFromMap(String str) => NotesModel.fromMap(json.decode(str));

String notesModelToMap(NotesModel data) => json.encode(data.toMap());

class NotesModel {
  NotesModel({
    this.id,
    this.note,
    this.status,
  });

  final int id;
  final String note;
  final String status;

  factory NotesModel.fromMap(Map<String, dynamic> json) => NotesModel(
    id: json["id"] == null ? null : json["id"],
    note: json["note"] == null ? null : json["note"],
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "note": note == null ? null : note,
    "status": status == null ? null : status,
  };
}
