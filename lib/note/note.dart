

import 'package:everthought/edit_note.dart';
import 'package:everthought/note/notes_global.dart';
import 'package:flutter/material.dart';

class Note extends StatefulWidget {
  const Note({super.key, this.title, this.text});
  
  final String? title;
  final String? text;

  @override
  State<StatefulWidget> createState() => NoteState(title ?? "", text ?? "");
}

class NoteState extends State<Note> {
  String title = "";
  String text = "";

  final int maxNoteDisplayCharCount = 255;
  
  NoteState(this.title, this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      child: GestureDetector(
        onTap: () {
          Route route = MaterialPageRoute(builder: (context) => EditNotePage(title: title, text: text, updateIndex: NotesGlobal.notesList.indexOf(widget)));
          Navigator.push(context, route).then((value) => setState(() => {}));
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue, width: 3),
            borderRadius: const BorderRadius.all(Radius.circular(10))
          ),
          child: Column(
            children: [
              Text(
                title.isEmpty ? "Note" : title,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                (text.length >= maxNoteDisplayCharCount ? "${text.substring(0, maxNoteDisplayCharCount)}..." : text),
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontSize: 16,
                ),
              )
            ]
          ),
        ),
      )
    );
  }
}
