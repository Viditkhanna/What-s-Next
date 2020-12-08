import 'package:flutter/material.dart';
import 'package:whats_next/db_helper/db_helper.dart';
import 'package:whats_next/ui/create_task/create_task.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final dbHelper = DatabaseHelper.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await CreateTask.open(context);
          setState(() {});
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(title: Text("What's Next")),
      body: FutureBuilder<List<Map<String, dynamic>>>(
          future: dbHelper.queryAllRows(),
          builder: (context, snap) {
            if (snap.hasError) return Center(child: Text('${snap.error}'));
            if (!snap.hasData)
              return Center(
                child: CircularProgressIndicator(),
              );
            if (snap.data.isEmpty)
              return Center(child: Text("You don't have any current tasks..."));

            return ListView.builder(
              itemCount: snap.data.length,
              itemBuilder: (context, index) {
                final element = snap.data[index];
                return NotesCard(
                  element: element,
                  onChanged: () {
                    setState(() {});
                  },
                );
              },
            );
          }),
    );
  }
}

class NotesCard extends StatelessWidget {
  final dbHelper = DatabaseHelper.instance;
  final Map<String, dynamic> element;
  final Function onChanged;

  NotesCard({Key key, this.element, this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                      dbHelper.update({
                        DatabaseHelper.columnId: element['id'],
                        DatabaseHelper.columnNote: val,
                      });
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
                    onTap: () async {
                      await dbHelper.update({
                        DatabaseHelper.columnId: element['id'],
                        DatabaseHelper.columnStatus: 'complete',
                      });
                      onChanged();
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
                    onTap: () async {
                      await dbHelper.update({
                        DatabaseHelper.columnId: element['id'],
                        DatabaseHelper.columnStatus: 'pending',
                      });
                      onChanged();
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
                  onPressed: () async {
                    await dbHelper.delete(id);
                    onChanged();
                    Navigator.pop(context);
                  },
                  child: Text('Yes')),
            ],
          );
        });
  }
}
