import 'dart:js_interop_unsafe';

import 'package:everthought/note/note.dart';
import 'package:everthought/note/notes_global.dart';
import 'package:everthought/reminder/reminder.dart';
import 'package:everthought/reminder/reminder_global.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';

class EditReminderPage extends StatefulWidget {
  const EditReminderPage({super.key});

  @override
  State<StatefulWidget> createState() => EditReminderState();
  
}

class EditReminderState extends State<EditReminderPage> {
  SpeechToText stt = SpeechToText();
  bool micEnabled = false;
  bool listening = false;
  int currentTextLength = 0;
  Color micColor = Colors.black;

  String title = "";
  String description = "";
  DateTime date = DateTime.now();
  TimeOfDay time = TimeOfDay.now();
  RepeatType repeatType = RepeatType.none;

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
    currentTextLength = description.length;
    await stt.listen(onResult: (result) {
      setState(() {
        description = description.substring(0, currentTextLength) + result.recognizedWords;
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

  void _saveReminder() {
    setState(() {
      //Save Note
      RemindersGlobal.remindersList.add(Reminder(title, description, DateTime(DateTime.now().year, date.month, date.day, time.hour, time.minute), repeatType));
      if (listening) stopSTT();
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Reminders'),
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
                      hintText: 'Reminder Title',
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
                    height: 200,
                    child: TextField(
                      controller: TextEditingController(text: description),
                      onChanged: (value) {
                        description = value;
                      },
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      expands: true,
                      decoration: const InputDecoration(
                        hintText: 'Input your reminder description here...',
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
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                      child: FloatingActionButton.extended(
                        tooltip: "Select Date",
                        label: const Text("Select Date"),
                        onPressed: () async {
                        date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2100)
                        ) ?? DateTime.now();
                        setState(() {});
                      },),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                      child: FloatingActionButton.extended(
                        tooltip: "Select Time",
                        label: const Text("Select Time"),
                        onPressed: () async {
                        time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        ) ?? TimeOfDay.now();
                        setState(() {});
                      }),
                    )
                  ]
                ),
                DropdownButton(
                  value: repeatType,
                  onChanged: (RepeatType? type) {
                    setState(() {
                      repeatType = type ?? RepeatType.none;
                    });
                  },
                  items: RepeatType.values.map((RepeatType type) {
                    return DropdownMenuItem(
                      value: type,
                      child: Text(type.name)
                    );
                  }).toList()
                ),
                Text(
                  "${date.month}/${date.day}   ${time.hour}:${time.minute < 10 ? "0" : ""}${time.minute}",
                  style: const TextStyle(
                    fontSize: 24,
                    fontStyle: FontStyle.italic
                  ),
                )
              ],
            ),

            floatingActionButton: FloatingActionButton.extended(
              
              onPressed: _saveReminder,
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50))),
              elevation: 4,
              tooltip: 'Save Reminder',
              extendedPadding: const EdgeInsets.all(20),
              label: const Text('Save'),
              extendedTextStyle: const TextStyle(
                fontSize: 20
              ),
          )
        ),
      )
    );
  }
}