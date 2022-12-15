import 'package:flutter/material.dart';
import 'package:flutter_note_app/addnote/AddNoteWidget.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../Note.dart';

class ListingWidget extends StatefulWidget {
  const ListingWidget({super.key});

  @override
  State<ListingWidget> createState() => _ListingState();
}

class _ListingState extends State<ListingWidget> {
  List<Note> noteList = List.empty(growable: true);

  Future<List<Note>> _getAllNotesFromDatabase() async {
    final database = openDatabase(
      join(await getDatabasesPath(), 'note_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE notes(id INTEGER PRIMARY KEY, title TEXT, desc TEXT, titleDesc TEXT)',
        );
      },
      version: 1,
    );
    final db = await database;

    final List<Map<String,dynamic>> maps = await db.query('notes');

    return List.generate(maps.length, (index) {
        return Note(
          maps[index]['id'],
          maps[index]['title'],
          maps[index]['desc'],
          maps[index]['titleDesc']
        );
    });
  }

  Future<void> _navigateAddNoteAndAwait(BuildContext context) async {
    final result = await Navigator.push(
        context, 
        MaterialPageRoute(builder: (context) => const AddNoteWidget())
    );

    if(!mounted) return;

    setState(() {
      noteList.add(result);
    });
  }

  Widget _getEmptyListView() {
    return const Text("I wish i have some notes");
  }

  Widget _getListView() {
    return ListView.separated(
      padding: const EdgeInsets.all(8.0),
      itemCount: noteList.length,
      itemBuilder: (_, int index) =>
          Container(
              padding: const EdgeInsets.all(8.0),
              color: Colors.amber[100],
              child: Center(
                child: Column(children: [
                  Text(
                    noteList[index].title,
                    style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 24),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    noteList[index].desc,
                    style: const TextStyle(fontSize: 16),
                  )
                ],)
              )
          ),
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Note App"),
      ),
      body: FutureBuilder<List<Note>>(
        future: _getAllNotesFromDatabase(),
        builder: (BuildContext context, AsyncSnapshot<List<Note>> snapshot) {
          if(!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if(snapshot.data == null || snapshot.data!.isEmpty) {
              return _getEmptyListView();
            } else {
              noteList = snapshot.data!;
              return _getListView();
            }
          }
        },
      ) ,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateAddNoteAndAwait(context),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

}