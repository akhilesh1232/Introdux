import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({Key? key}) : super(key: key);

  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  final CalendarController _controller = CalendarController();
  void calendarTapped(CalendarTapDetails calendarTapDetails) {
    if (calendarTapDetails.targetElement == CalendarElement.calendarCell &&
        _controller.view == CalendarView.month) {
      _controller.view = CalendarView.schedule;
    } else if (calendarTapDetails.targetElement == CalendarElement.header &&
        _controller.view == CalendarView.schedule) {
      _controller.view = CalendarView.month;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffff4c29),
      body: SfCalendar(
        view: CalendarView.month,
        controller: _controller,
        onTap: calendarTapped,
        dataSource: _getCalendarDataSource(),
        headerHeight: 100.0,
        backgroundColor: const Color(0xff082032),
        cellBorderColor: const Color(0xffff4c29),
        todayHighlightColor: const Color(0xffff4c29),
        showNavigationArrow: true,
        headerStyle: const CalendarHeaderStyle(
          textStyle: TextStyle(
            color: Color(0xffff4c29),
            fontWeight: FontWeight.bold,
            fontSize: 35.0,
          ),
        ),
        viewHeaderStyle: const ViewHeaderStyle(
          dayTextStyle: TextStyle(
            color: Color(0xffff4c29),
          ),
        ),
        scheduleViewSettings: const ScheduleViewSettings(
          monthHeaderSettings: MonthHeaderSettings(
            height: 75.0,
            backgroundColor: Color(0xff2c394b),
          ),
        ),
        monthViewSettings: const MonthViewSettings(
            showTrailingAndLeadingDates: false,
            monthCellStyle: MonthCellStyle(
              textStyle: TextStyle(
                color: Colors.white,
              ),
            )),
      ),
    );
  }
}

_AppointmentDataSource _getCalendarDataSource() {
  List<Appointment> appointments = <Appointment>[];
  appointments.add(Appointment(
      startTime: DateTime.now(),
      endTime: DateTime.now().add(const Duration(hours: 2, minutes: 10))));
  return _AppointmentDataSource(appointments);
}

class _AppointmentDataSource extends CalendarDataSource {
  _AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}
