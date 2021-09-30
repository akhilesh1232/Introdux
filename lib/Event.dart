import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Events {
  String title;
  String organizer;
  String description;
  DateTime from;
  DateTime to;
  Color background;
  String department;

  Events(
      {required this.title,
      required this.organizer,
      required this.description,
      required this.to,
      required this.from,
      required this.background,
      required this.department});
}

class EventDataSource extends CalendarDataSource {
  EventDataSource(List<Events> source) {
    appointments = source;
  }
  @override
  DateTime getStartTime(int index) {
    return _getEventData(index).from;
  }

  @override
  DateTime getEndTime(int index) {
    return _getEventData(index).to;
  }

  @override
  String getSubject(int index) {
    return _getEventData(index).title;
  }

  @override
  Color getColor(int index) {
    return _getEventData(index).background;
  }

  @override
  bool isAllDay(int index) {
    return false;
  }

  _getEventData(index) {
    return appointments![index];
  }
}
