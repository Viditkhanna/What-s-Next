import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whats_next/bloc/app_bloc.dart';
import 'package:whats_next/db_helper/db_helper.dart';
import 'package:whats_next/ui/create_task/create_task.dart';
import 'package:whats_next/ui/widgets/notes_card.dart';

class HomePage extends StatelessWidget {
  final dbHelper = DatabaseHelper.instance;

  @override
  Widget build(BuildContext context) {
    final appBloc = Provider.of<AppBloc>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          CreateTask.open(context);
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(title: Text("What's Next")),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: appBloc.notes,
        builder: (context, snap) {
          if (snap.hasError) return Center(child: Text('${snap.error}'));
          if (!snap.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
          if (snap.data.isEmpty)
            return Center(
              child: Text("You don't have any current tasks..."),
            );

          return ListView.builder(
            itemCount: snap.data.length,
            itemBuilder: (context, index) {
              final element = snap.data[index];
              return NotesCard(
                element: element,
              );
            },
          );
        },
      ),
    );
  }
}
