import 'package:everthought/note/note.dart';
import 'package:everthought/note/notes_global.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class EditNotePage extends StatefulWidget {
  const EditNotePage({super.key, this.title, this.text, this.updateIndex});

  final String? title;
  final String? text;
  final int? updateIndex;

  @override
  State<StatefulWidget> createState() => EditNoteState(title ?? "", text ?? "", updateIndex ?? 0);
  
}

class EditNoteState extends State<EditNotePage> {
  SpeechToText stt = SpeechToText();
  bool micEnabled = false;
  bool listening = false;
  int currentTextLength = 0;
  Color micColor = Colors.black;

  bool updateMode = false;
  int updateIndex = 0;

  String title = "";
  String text = "";

  @override
  void initState() {
    super.initState();
    initSpeech();
  }

  void initSpeech() async {
    micEnabled = await stt.initialize();
    setState(() {});
  }

  void startSTT() async {
    listening = true;
    currentTextLength = text.length;
    await stt.listen(onResult: (result) {
      setState(() {
        text = text.substring(0, currentTextLength) + result.recognizedWords;
      });
    });
    setState(() {
      micColor = Colors.red;
    });
  }
  void stopSTT() async {
    listening = false;
    setState(() {
      micColor = Colors.black;
    });
    await stt.stop();
    setState(() {});
  }
  
  EditNoteState(this.title, this.text, this.updateIndex) {
    updateMode = !(title.isEmpty && text.isEmpty);
  }


  void _saveNote() {
    setState(() {
      //Save Note
      if (updateMode) {
        NotesGlobal.notesList.removeAt(updateIndex);
        NotesGlobal.notesList.insert(updateIndex, Note(title: title, text: text));
      } else {
        NotesGlobal.notesList.add(Note(title: title, text: text));
      }
      
      Navigator.pop(context);
      
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Notes'),
        centerTitle: false,
      ),

      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("paper_bg.jpg"),
            fit: BoxFit.cover,
            opacity: 0.5
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body:
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  child: TextField(
                    controller: TextEditingController(text: title),
                    onChanged: (value) {
                      title = value;
                    },
                    maxLength: 25,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Note Title',
                      hintStyle: TextStyle(
                        color: Color.fromARGB(100, 0, 0, 0)
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                      counterText: "",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 1,
                        )
                      ),
                    ),
                  ),
                ),
                
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                  child: SizedBox(
                    height: 400,
                    child: TextField(
                      controller: TextEditingController(text: text),
                      onChanged: (value) {
                        text = value;
                      },
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      expands: true,
                      decoration: const InputDecoration(
                        hintText: 'Input your note here...',
                        hintStyle: TextStyle(
                          color: Color.fromARGB(100, 0, 0, 0)
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                        counterText: "",
                        border: InputBorder.none,
                      ),
                    )
                  )
                ),

                FloatingActionButton(
                  onPressed: () {
                    if (listening) {
                      stopSTT();
                    } else {
                      startSTT();
                    }
                  },
                  foregroundColor: micColor,
                  child: const Icon(Icons.mic),
                )
              ],
            ),

            floatingActionButton: FloatingActionButton.extended(
              
              onPressed: _saveNote,
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50))),
              elevation: 4,
              tooltip: 'Save Note',
              extendedPadding: const EdgeInsets.all(20),
              label: const Text('Save'),
              extendedTextStyle: const TextStyle(
                fontSize: 20
              ),
            ),
        ),
      )
    );
  }
}