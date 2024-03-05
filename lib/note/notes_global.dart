
import 'package:everthought/note/note.dart';
import 'package:flutter/material.dart';

class NotesGlobal {
  static List<Note> notesList = [];
  
  static Widget getWidget() {
    return notesList.isEmpty
    ? const Center(
        child: Text("No Notes",
          style: TextStyle(
            fontSize: 32,
            color: Colors.black26
          ),
        )
    )
    : Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: notesList.length,
        itemBuilder: (context, index) => notesList[index],
      )
    );
  }
}