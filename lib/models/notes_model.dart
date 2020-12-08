// To parse this JSON data, do
//
//     final notesModel = notesModelFromMap(jsonString);

import 'dart:convert';

import 'package:whats_next/bloc/app_bloc.dart';

NotesModel notesModelFromMap(String str) =>
    NotesModel.fromMap(json.decode(str));

String notesModelToMap(NotesModel data) => json.encode(data.toMap());

class NotesModel {
  NotesModel({
    this.id,
    this.note,
    this.status,
  });

  final int id;
  final String note;
  final NoteStatus status;

  factory NotesModel.fromMap(Map<String, dynamic> json) => NotesModel(
        id: json["id"] == null ? null : json["id"],
        note: json["note"] == null ? null : json["note"],
        status: json["status"] == null
            ? null
            : statusMap.keys.firstWhere(
                (val) => statusMap[val] == json['status'],
                orElse: () => null),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "note": note == null ? null : note,
        "status": status == null ? null : status,
      };
}
