import 'package:everthought/edit_reminder.dart';
import 'package:everthought/reminder/reminder_global.dart';
import 'package:flutter/material.dart';

class RemindersPage extends StatefulWidget {
  const RemindersPage({super.key});
  
  @override
  State<StatefulWidget> createState() => RemindersState();
}

class RemindersState extends State<RemindersPage> {

  void _addReminder() {
    setState(() {
      Route route = MaterialPageRoute(builder: (context) => const EditReminderPage());
      Navigator.push(context, route).then((value) => setState(() => {}));
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Column(
        children: [
          RemindersGlobal.getWidget(),
        ]
      ),



      floatingActionButton: FloatingActionButton(
        onPressed: _addReminder,
        shape: const CircleBorder(eccentricity: 0.0),
        elevation: 4,
        tooltip: 'Add Reminder',
        child: const Icon(Icons.add),
      )
    );
  }
}