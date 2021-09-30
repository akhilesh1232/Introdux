import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'event.dart';
import './firebase_services.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({Key? key}) : super(key: key);
  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  final CalendarController _controller = CalendarController();
  late Stream<QuerySnapshot> _stream;
  getData() {
    setState(() {
      _stream = FirebaseService()
          .getFirebaseFirestoreInstance()
          .collection('EventData')
          .snapshots();
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

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
      body: StreamBuilder(
        stream: _stream,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            List<Events> list = <Events>[];
            // list.add(Events(
            //     background: Color(0xffffc0cb),
            //     title: 'a',
            //     to: DateTime.now().add(Duration(hours: 3)),
            //     from: DateTime.now(),
            //     clubName: 'cs',
            //     description: 'nothing just timepass'));
            for (var element in snapshot.data!.docs) {
              list.add(Events(
                  title: element['title'],
                  organizer: element['organizer'],
                  description: element['description'],
                  from: DateTime.parse(element['from'].toDate().toString()),
                  to: DateTime.parse(element['to'].toDate().toString()),
                  background: Color(element['background']),
                  department: element['department']));
            }
            return SfCalendar(
              view: CalendarView.month,
              controller: _controller,
              onTap: calendarTapped,
              dataSource: EventDataSource(list),
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
            );
          } else {
            return const Text('No data Available');
          }
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //     child: const Icon(Icons.upload_file_outlined),
      //     onPressed: FirebaseService().uploadEventData(
      //       Events(
      //         title: 'CS meet',
      //         organizer: 'acm',
      //         description: 'gim',
      //         to: DateTime.now().add(const Duration(hours: 2)),
      //         from: DateTime.now(),
      //         background: const Color(0xffffc08b),
      //          department: 'IT',
      //       ),
      //     ))
    );
  }
}
