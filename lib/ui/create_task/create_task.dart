import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whats_next/bloc/app_bloc.dart';
import 'package:whats_next/db_helper/db_helper.dart';

class CreateTask extends StatelessWidget {
  static Future open(context) async => await Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => CreateTask()),
      );
  final notesCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final appBloc = Provider.of<AppBloc>(context);
    return Scaffold(
      floatingActionButton: RaisedButton(
        onPressed: () async {
          appBloc.addNote(notesCtrl.text);
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
              labelText: "What's next?",
              alignLabelWithHint: true,
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
