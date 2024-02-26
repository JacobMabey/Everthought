import 'package:flutter/material.dart';

class RemindersPage extends StatefulWidget {
  const RemindersPage({super.key});
  
  @override
  State<StatefulWidget> createState() => RemindersState();
}

class RemindersState extends State<RemindersPage> {

  void _addReminder() {
    setState(() {
      // Add Reminder
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: const Text('Welcome to Reminders!'),

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