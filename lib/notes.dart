import 'dart:convert';

import 'package:everthought/edit_note.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

  Future<String> fetchApiData(String path) async {
    var response = await http.get(Uri.https('swapi.dev', "/api/$path"));
    return response.body;
  }

  dynamic getApiPerson(int id) async {
    dynamic jsonData;
    await fetchApiData('people/$id').then((value) => {
      jsonData = jsonDecode(value) as Map<String, dynamic>
    });
    return jsonData;
  }

  Future<String> getApiName(int id) async {
    dynamic data = await getApiPerson(id);
    return data['name'];
  }

  @override
  Widget build(BuildContext context) {
    final data = getApiName(1);

    return Scaffold(
      //body: Text(data["name"]),
      body: FutureBuilder(
        future: data,
        initialData: "Code sample",
        builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else {
            final data = snapshot.data as String;
            return Text(data);
          }
        }
        else {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.blue,
            ),
          );
        }
      }),

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