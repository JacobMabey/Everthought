
import 'package:everthought/reminder/reminder.dart';
import 'package:flutter/material.dart';

class RemindersGlobal {
  static List<Reminder> remindersList = [];


  static Widget getWidget() {
    return remindersList.isEmpty
    ? const Center(
        child: Text("No Reminders",
          style: TextStyle(
            fontSize: 32,
            color: Colors.black26
          ),
        )
    )
    : Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: remindersList.length,
        itemBuilder: (context, index) => remindersList[index].getWidget(),
      )
    );
  }
}