
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Spacer(),
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Title',
                ),
                onChanged: (String value) async {
                  debugPrint('title onSubmitted $value');
                  if(value.isNotEmpty) {
                    title = value;
                  }
                },
              ),
              const SizedBox(height: 24,),
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Desc',
                ),
                onChanged: (String value) async {
                  debugPrint('desc onSubmitted $value');
                  if(value.isNotEmpty) {
                    desc = value;
                  }
                },),
              const Spacer(),
              const Spacer()
            ],
          ),
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