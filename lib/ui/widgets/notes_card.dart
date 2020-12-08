import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whats_next/bloc/app_bloc.dart';

class NotesCard extends StatelessWidget {
  final Map<String, dynamic> element;

  NotesCard({Key key, this.element}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appBloc = Provider.of<AppBloc>(context);
    return Stack(
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: TextFormField(
                    onFieldSubmitted: (val) {
                      appBloc.updateNote(element['id'], val);
                    },
                    initialValue: '${element['note']}',
                    decoration: InputDecoration(
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                    ),
                  ),
                ),
                if (element['status'] == 'pending')
                  InkWell(
                    onTap: () {
                      appBloc.changeNoteStatus(element['id'], 'complete');
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 5,
                        backgroundColor: Colors.red.withOpacity(0.8),
                      ),
                    ),
                  )
                else
                  InkWell(
                    onTap: () {
                      appBloc.changeNoteStatus(element['id'], 'pending');
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 5,
                        backgroundColor: Colors.green,
                      ),
                    ),
                  )
              ],
            ),
          ),
        ),
        Positioned(
          top: 4,
          right: 5,
          child: InkWell(
            onTap: () {
              _showConfirmDialog(context, element['id']);
            },
            child: CircleAvatar(
              radius: 8,
              backgroundColor: Colors.red,
              child: Icon(
                Icons.close,
                color: Colors.white,
                size: 8,
              ),
            ),
          ),
        ),
      ],
    );
  }

  _showConfirmDialog(context, id) {
    showDialog(
        context: context,
        builder: (context) {
          final appBloc = Provider.of<AppBloc>(context);
          return AlertDialog(
            title: Text('Alert'),
            content: Text('Are you sure you want to delete this note'),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('No')),
              FlatButton(
                  onPressed: () {
                    appBloc.deleteNote(element['id']);
                    Navigator.pop(context);
                  },
                  child: Text('Yes')),
            ],
          );
        });
  }
}
