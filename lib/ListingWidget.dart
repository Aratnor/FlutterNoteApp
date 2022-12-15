import 'package:flutter/material.dart';

import 'Note.dart';
import 'main.dart';

class ListingWidget extends StatefulWidget {
  const ListingWidget({super.key});

  @override
  State<ListingWidget> createState() => _ListingState();
}

class _ListingState extends State<ListingWidget> {
  List<Note> noteList = List.empty(growable: true);

  Future<void> _navigateAddNoteAndAwait(BuildContext context) async {
    final result = await Navigator.push(
        context, 
        MaterialPageRoute(builder: (context) => const MyHomePage())
    );

    if(!mounted) return;

    noteList.add(result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Note App"),
      ),
      body: Center(
        child: ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: noteList.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 50,
                color: Colors.amber[100],
                child: Center(
                  child: Text("Note Title : ${noteList[index].title} Desc : ${noteList[index].desc}"),
                )
              );
            }
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateAddNoteAndAwait(context),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

}