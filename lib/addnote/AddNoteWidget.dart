
import 'package:flutter/material.dart';

import '../Note.dart';

class AddNoteWidget extends StatefulWidget {
  const AddNoteWidget({super.key});

  @override
  State<AddNoteWidget> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNoteWidget> {

  String title = "";
  String desc = "";
  String titleDesc = "";

  void _navigateBackToListingWidget() {
    FocusManager.instance.primaryFocus?.unfocus();
    if(title.isNotEmpty && desc.isNotEmpty) {
      titleDesc = "Title is $title and Desc is $desc";
    } else {
      titleDesc = "";
    }
    Note note = Note(title,desc,titleDesc);

    Navigator.pop(context,note);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Note App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Enter Title',
            ),
            TextField(
              autofocus: true,
              onChanged: (text) {
                title = text;
              },
            ),
            const Text(
                'Enter Description'
            ),
            TextField(
              autofocus: true,
              onChanged: (text) {
                desc = text;
              },),
            Text(titleDesc)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateBackToListingWidget,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

}