import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myapp/screens/home_screen.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'event.dart';
import 'package:myapp/databse/firebase_services.dart';

class CalendarWidget extends StatefulWidget {
  static const routeName = '/calendar';
  const CalendarWidget({Key? key}) : super(key: key);
  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  final CalendarController _controller = CalendarController();
  late Stream<QuerySnapshot> _stream;
  List<Events> list = <Events>[];
  getData() {
    setState(() {
      _stream = FirebaseService()
          .getFirebaseFirestoreInstance()
          .collection('eventInfo')
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
      print(_controller.selectedDate);
      final ind=list.indexWhere((element) => DateTime(element.from.year,element.from.month,element.from.day)==_controller.selectedDate);
      if(ind>=0)
      {
        print("Details:"+list[ind].title+list[ind].description+list[ind].organizer);
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            insetPadding: EdgeInsets.fromLTRB(50, 230,50,230),
            title: Text("Title: "+list[ind].title),
            content:  Column(
              children: [
                Text('Description : ' + list[ind].description, style: TextStyle(
                    color: Colors.black,
                  ),),
                Text('From : ' + list[ind].from.toString(), style: TextStyle(
                    color: Colors.black,
                  ),),
                Text('To : ' + list[ind].to.toString(), style: TextStyle(
                  color: Colors.black,
                ),),
                Text('Department : ' + list[ind].department, style: TextStyle(
                  color: Colors.black,
                ),),
              ],
            ),
          ),
        );
      }
      else
        print("NO");
    } else if (calendarTapDetails.targetElement == CalendarElement.header &&
        _controller.view == CalendarView.schedule) {
      _controller.view = CalendarView.month;

    }
    // showDialog<String>(
    //   context: context,
    //   builder: (BuildContext context) => AlertDialog(
    //     title: Text(list[0].title),
    //     content: Text(list[1].description),
    //   ),
    // );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffff4c29),
      body:
      Column(
        children: [
          IconButton(onPressed:(){
            Navigator.push(context,new MaterialPageRoute(builder: (context)=>new HomeScreen()));print('bak');
          } ,icon:Icon(Icons.arrow_back),color: Colors.white, ),
          StreamBuilder(
            stream: _stream,
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                 //List<Events> list = <Events>[];
                for (var element in snapshot.data!.docs) {

                  list.add(Events(
                      title: element['Title'],
                      organizer: element['Organizer'],
                      description: element['Description'],
                      from: DateTime.parse(element['Start-Date'].toDate().toString()),
                      to: DateTime.parse(element['End-Date'].toDate().toString()),
                      background: Color(0xff082032),
                      department: element['Department']));
                }
                return Container(
                  height: 600,
                  child: SfCalendar(
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
                  ),
                );
              } else {
                return const Text('No data Available');
              }
            },
          ),
        ],
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