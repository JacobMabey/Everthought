import 'package:everthought/edit_note.dart';
import 'package:flutter/material.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});
  
  @override
  State<StatefulWidget> createState() => NotesState();
  
}

class NotesState extends State<NotesPage> {

  void _addNote() {
    setState(() {
      Navigator.push(context, MaterialPageRoute(builder: (context) =>  const EditNotePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: const Text('Welcome to Notes!'),

      floatingActionButton: FloatingActionButton(
        onPressed: _addNote,
        shape: const CircleBorder(eccentricity: 0.0),
        elevation: 4,
        tooltip: 'Add Note',
        child: const Icon(Icons.add),
      )
    );
  }
}