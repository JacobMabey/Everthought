import 'dart:convert';
import 'dart:io';

import 'package:everthought/edit_note.dart';
import 'package:everthought/note/notes_global.dart';
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
      Route route = MaterialPageRoute(builder: (context) => const EditNotePage());
      Navigator.push(context, route).then((value) => setState(() => {}));
    });
  }

  Future<String> fetchApiQuoteOfTheDay() async {
    dynamic jsonData;
    await http.get(Uri.https('dummyjson.com', "/quotes/random"), headers: {
      HttpHeaders.accessControlAllowOriginHeader: "*",
      "Access-Control-Allow-Origin": "*",
    }).then((response) => {
      jsonData = jsonDecode(response.body) as Map<String, dynamic>
    });
    return jsonData["quote"];
  }

  @override
  Widget build(BuildContext context) {
    final quote = fetchApiQuoteOfTheDay();

    return Scaffold(
      //body: Text(data["name"]),
      body: Column(
        children: [
          NotesGlobal.getWidget(),

          FutureBuilder(
            future: quote,
            initialData: "",
            builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else {
                final data = snapshot.data as String;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 50),
                  child:
                    Text(
                      "\"$data\"",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                        color: Colors.black26
                      ),
                    )
                );
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
        ]
      ),



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