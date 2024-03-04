

import 'package:flutter/material.dart';

enum RepeatType {
  none,
  daily,
  weekly,
  monthly,
  annually
}

class Reminder {
  String title = "";
  String description = "";
  DateTime dateTime;
  RepeatType repeatType;

  final int maxDescDisplayCharCount = 100;

  Reminder(this.title, this.description, this.dateTime, this.repeatType);

  Widget getWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5), 
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.deepPurple, width: 3),
          borderRadius: const BorderRadius.all(Radius.circular(10))
        ),
        child: Column(
          children: [
            Text(
              title.isEmpty ? "Reminder" : title,
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              (description.length >= maxDescDisplayCharCount ? "${description.substring(0, maxDescDisplayCharCount)}..." : description),
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            Text(
              getTimeFullDisplay(),
              style: const TextStyle(
                fontSize: 24,
                fontStyle: FontStyle.italic
              ),
            ),
            Text(
              repeatType.name
            )
          ]
        ),
      )
    );
  }

  String getTimeFullDisplay() {
    String output = "";
    switch(repeatType) {
      case RepeatType.none:
      case RepeatType.daily:
        output = getTimeString();
        break;
      case RepeatType.weekly:
        output = "${getWeekdayString()}   ${getTimeString()}";
        break;
      case RepeatType.monthly:
        output = "${getDateNextMonthString()}   ${getTimeString()}";
        break;
      case RepeatType.annually:
        output = "${getDateString()}   ${getTimeString()}";
        break;
      default:
        output = "";
    }
    return output;
  }

  String getTimeString() {
    return "${dateTime.hour.toInt()}:${dateTime.minute.toInt() < 10 ? "0" : ""}${dateTime.minute.toInt()}";
  }

  String getDateString() {
    return "${dateTime.month}/${dateTime.day}";
  }

  String getDateNextMonthString() {
    return "${DateTime.now().month + 1}/${dateTime.day}";
  }

  final List<String> weekdays = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
  String getWeekdayString() {
    return weekdays[dateTime.weekday];
  }
}