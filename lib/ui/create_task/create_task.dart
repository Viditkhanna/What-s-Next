import 'package:flutter/material.dart';
import 'package:whats_next/db_helper/db_helper.dart';

class CreateTask extends StatelessWidget {
  static Future open(context) async => await Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => CreateTask()),
      );
  final notesCtrl = TextEditingController();
  final dbHelper = DatabaseHelper.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: RaisedButton(
        onPressed: () async{
          if (notesCtrl.text.trim().isEmpty) return;
         await dbHelper.insert({
            DatabaseHelper.columnNote: notesCtrl.text,
            DatabaseHelper.columnStatus: 'pending',
          });
         Navigator.pop(context);
        },
        child: Text('Save'),
      ),
      appBar: AppBar(title: Text('Add Task')),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextFormField(
            controller: notesCtrl,
            maxLines: 8,
            autofocus: true,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
                labelText: "What's next?", alignLabelWithHint: true),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
