import 'package:flutter/material.dart';

class EditNotePage extends StatefulWidget {
  const EditNotePage({super.key});

  @override
  State<StatefulWidget> createState() => EditNoteState();
  
}

class EditNoteState extends State<EditNotePage> {

  void _saveNote() {
    setState(() {
      //Save Note
      
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
            const Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  child: TextField(
                    maxLength: 25,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                    decoration: InputDecoration(
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
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                  child: SizedBox(
                    height: 400,
                    child: TextField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      expands: true,
                      decoration: InputDecoration(
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
              ],
            ),

            floatingActionButton: FloatingActionButton.extended(
              
              onPressed: _saveNote,
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50))),
              elevation: 4,
              tooltip: 'Add Note',
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