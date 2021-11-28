
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:myapp/databse/databaseManager.dart';
import 'package:myapp/screens/EventBooking.dart';
import 'package:myapp/screens/check_status_screen.dart';
import 'package:myapp/screens/home_screen.dart';
class BookingStudentScreen extends StatefulWidget {
  static const routeName = '/booking_stu';
  @override
  _BookingStudentScreenState createState() => _BookingStudentScreenState();
}
//
enum DateValues { date1,date2,date3,date4,date5 }
class _BookingStudentScreenState extends State<BookingStudentScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final FirebaseAuth auth = FirebaseAuth.instance;
   late String uid ;
  String textString='';
   late DatabaseManager _db;
  DateValues? _character = DateValues.date1;
  String dropdownValue = 'Please Select';
  Color color=Color.fromRGBO(255, 76, 41, 0.8);
  void initState() {
    final User? user = auth.currentUser;
    uid = user!.uid;
    _db = DatabaseManager(uid);
  }
  Future getPRN() async {
    var snapshot=await FirebaseFirestore.instance.collection('studentInfo').doc(uid).get();
    return snapshot.get('PRN');
  }
  Future getToken() async {
    var snapshot=await FirebaseFirestore.instance.collection('studentInfo').doc(uid).get();
    return snapshot.get('tokenId');
  }
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  DateTime startDateTime=DateTime.now();
  DateTime endDateTime=DateTime.now();
  var duration;
  TextEditingController _titleController = new TextEditingController();
  TextEditingController _clubnmController = new TextEditingController();
  TextEditingController _descController = new TextEditingController();
  TextEditingController _venueController = new TextEditingController();
  TextEditingController _addInfoController = new TextEditingController();
  _selectStartDate(BuildContext context) async
  {

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(selectedDate.year,selectedDate.month,selectedDate.day+7),
      firstDate: selectedDate,
      lastDate: DateTime(selectedDate.year,selectedDate.month+3,selectedDate.day),);
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
    final TimeOfDay? pick = await showTimePicker(
        context: context, initialTime: selectedTime);
    if (pick != null && pick != selectedTime) {
      setState(() {
        selectedTime = pick;
      });
      startDateTime=DateTime(selectedDate.year,selectedDate.month,selectedDate.day,selectedTime.hour,selectedTime.minute);
      print('Start:'+startDateTime.toString());
    }
  }
  _selectEndDate(BuildContext context) async
  {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: startDateTime,
      firstDate: startDateTime,
      lastDate: DateTime(startDateTime.year,startDateTime.month,startDateTime.day+7),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
     TimeOfDay? pick = await showTimePicker(
        context: context, initialTime: selectedTime);
    if (pick != null && pick != selectedTime) {
      setState(() {
        selectedTime = pick;
      });
      endDateTime=DateTime(selectedDate.year,selectedDate.month,selectedDate.day,selectedTime.hour,selectedTime.minute);
      print('End:'+endDateTime.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(44, 57, 75,0.4),
      body: Stack(
        children: <Widget>[
          Center(
            child: Container(
              width: 370,
              padding: EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: [
                          IconButton(onPressed:(){
                            Navigator.push(context,new MaterialPageRoute(builder: (context)=>new HomeScreen()));print('back');
                          } ,icon:Icon(Icons.arrow_back),color: Colors.white,padding: EdgeInsets.all(40), ),
                          Text('Book Hall', textAlign: TextAlign.left,
                            style: TextStyle(color: Colors.white,
                              fontSize: 30, fontWeight: FontWeight.bold,
                            ),),
                        ],
                      ),
                        SizedBox(height:10),
                      Text('Fill the Details about event the below',
                        style: TextStyle(color: Colors.grey, fontSize: 20),),
SizedBox(height:20),
                      TextFormField(
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: 'Event title', labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                            prefixIcon: Icon(Icons.animation_rounded,
                              color: Color.fromRGBO(255, 76, 41, 0.8),
                            ), enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white,),
                          ),),
                          controller: _titleController,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return 'Please enter title of the event';
                            }
                          }
                      ),
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Club Name (if applicable)', labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                          prefixIcon: Icon(Icons.add_circle_outline_rounded,
                            color: Color.fromRGBO(255, 76, 41, 0.8),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                        controller: _clubnmController,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.multiline,maxLines: null,maxLength: 400,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: 'Description', labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                            prefixIcon: Icon(Icons.view_headline_sharp,
                              color: Color.fromRGBO(255, 76, 41, 0.8),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          controller: _descController,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return 'Please enter what the event is about';
                            }}
                      ),
                          Row(
                            children: [
                              Text('Department (Event Location) : ',style:
    TextStyle(color: Colors.white,fontSize:16,),
    ),
                              new Theme(
                                data: Theme.of(context).copyWith(
                                  canvasColor: Color.fromRGBO(44, 57, 75,1),
                                ),
                              child:DropdownButton<String>(
                                value: dropdownValue,
                                icon: const Icon(Icons.arrow_drop_down_sharp,color: Colors.red,),
                                iconSize: 24,
                                elevation: 1,
                                style: const TextStyle(color: Colors.white,fontSize: 16),
                                underline: Container(
                                  height: 1,
                                  color: Colors.white,
                                ),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownValue = newValue!;
                                  });
                                },
                                items: <String>['Please Select','CSE','IT', 'Electronics', 'Electrical', 'Mechanical','Civil','Other'].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );}).toList(),),
                              ),
                            ],
                          ),
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Exact Venue', labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                          prefixIcon: Icon(Icons.location_on_outlined,
                            color: Color.fromRGBO(255, 76, 41, 0.8),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                        controller: _venueController,
    validator: (value) {
    if (value!.trim().isEmpty) {
    return 'Please enter location of the event';}}
                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Text('Date & Time : ',style:
                          TextStyle(color: Colors.white,fontSize:16,),
                          ),
                          TextButton.icon(   onPressed: () {
                            _selectStartDate(context);
                          }, icon:Icon(Icons.access_time_rounded,size: 22,color: Color.fromRGBO(255, 76, 41, 0.8),),
                            style: TextButton.styleFrom(
                                padding: EdgeInsets.all(15)
                            ),
                            label: Text('Starting',style: TextStyle(
                              shadows: [
                                Shadow(
                                    color: Colors.white,
                                    offset: Offset(0, -4))
                              ],
                              color: Colors.transparent,
                              decoration:
                              TextDecoration.underline,
                              decorationColor: Color.fromRGBO(255, 76, 41, 0.8),
                              decorationThickness: 4,
                              decorationStyle:
                              TextDecorationStyle.solid,
                            ),),
                          ),

                          TextButton.icon(   onPressed: () {
                            _selectEndDate(context);
                          }, icon:Icon(Icons.access_time_rounded,size: 22,color: Color.fromRGBO(255, 76, 41, 0.8),),
                            style: TextButton.styleFrom(
                                padding: EdgeInsets.all(15)
                            ),
                            label: Text('Ending',style: TextStyle(
                              shadows: [
                                Shadow(
                                    color: Colors.white,
                                    offset: Offset(0, -4))
                              ],
                              color: Colors.transparent,
                              decoration:
                              TextDecoration.underline,
                              decorationColor: Color.fromRGBO(255, 76, 41, 0.8),
                              decorationThickness: 4,
                              decorationStyle:
                              TextDecorationStyle.solid,
                            ),),
                          ),

    ],
                      ),
                      OutlinedButton.icon(onPressed:()=> pickColor(context),
                        icon:Icon(Icons.add_circle,size: 22,color: Color.fromRGBO(255, 76, 41, 0.8),),
                        label: Text(
                            'Color',style:
                        TextStyle(color: Colors.white,) ),
                        style: OutlinedButton.styleFrom(
                        side: BorderSide(width: 2.0, color: Color.fromRGBO(255, 76, 41, 0.8),),
                      ),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.multiline,maxLines: 3,maxLength: 400,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Additional information/requirement', labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                          prefixIcon: Icon(Icons.edit,
                            color: Color.fromRGBO(255, 76, 41, 0.8),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                        controller: _addInfoController,
                      ),
                      SizedBox(
                        width: double.maxFinite,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              //permission();
                              bool val = await toUpload(
                                  dropdownValue, startDateTime, endDateTime);
                              if (val == false) {
                                print(
                                    'Permission is asked...wait for authorities to see it');
                                permission();
                              } else {
                                print('Permission can not be asked');
                                List <DateTime> ls=await suggestion(dropdownValue, startDateTime, endDateTime);
                                showDialog<String>(
                                                                    context: context,
                                                                    builder: (BuildContext context) => AlertDialog(
                                                                  title: const Text('Choose a different time slot'),
                                                                   content: const Text('Time slot you have chosen is already booked. Choose other convenient start time from below.. '),
                                                                  actions: <Widget>[
                                                                    Container(
                                                                      height:400, width: 300,
                                                                      child: new ListView(
                                                                        shrinkWrap: true,
                                                        children: new List.generate(ls.length,
                                    (index) => new ListTile(
                                    title: ElevatedButton(   onPressed: () {
                                      startDateTime=ls[index];
                                      endDateTime=startDateTime.add(duration);
                                      print('chosen start:'+startDateTime.toString());
                                      print('chosen end:'+endDateTime.toString());
                                      permission();
                                    },
                                      style: ElevatedButton.styleFrom(
                                          primary: Color.fromRGBO(255, 76, 41,0.8),
                                          padding: EdgeInsets.all(15)
                                      ),
                                      // child: Text(ls[index].toString().substring(0,ls[index].toString().length-7)),
                                      child:Text(ls[index].toString().substring(0,11)+"at "+ls[index].toString().substring(12,ls[index].toString().length-7)),
                                    ),
                                    ),
                                    ),
                                    ),
                                ),
                            ],
                                ),
                                );
                              }
                            }
                           },
                          style: ElevatedButton.styleFrom(
                              primary: Color.fromRGBO(255, 76, 41, 0.8),
                              padding: EdgeInsets.all(15)),
                          child: Text(
                            'Ask for Permission',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(textString,style: TextStyle(color: Colors.grey),textAlign:TextAlign.center,),
                      ),
                      SizedBox(height:10),
                      OutlinedButton(onPressed:()async{
                        dynamic res=await getPRN();
                        print('PRN:'+res.toString());
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CheckStatus(
                                org: res.toString(),
                              )),
                        );
                      },
                        child: Text(
                            'Check Status',style:
                        TextStyle(color: Colors.white,) ),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(width: 2.0, color: Color.fromRGBO(255, 76, 41, 0.8),),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  void permission() async {
      await _db.addEvent(
          _titleController.text, _clubnmController.text,_descController.text,dropdownValue,_venueController.text,startDateTime,endDateTime,color.toString(),_addInfoController.text);
      print('asked for permission');
      setState(() {
        textString='Asked for permission. You will receive a notification once authority acknowledges';
      });
    }
  Widget buildColorPicker()=>BlockPicker(pickerColor: color,
    availableColors: [Colors.red,Colors.green,Colors.blue,Colors.yellow,Colors.orange,Colors.pink,Colors.purple,Colors.grey,Colors.brown,Colors.cyan]
    ,onColorChanged: (color)=>setState(() =>this.color=color),);
  void pickColor(BuildContext context) =>showDialog(context: context, builder:(context)=>
  AlertDialog(insetPadding: EdgeInsets.all(50),
    title: Text('Choose color to show the event in calender!'),content: Column(mainAxisSize: MainAxisSize.min,
    children: [
      buildColorPicker(),
      TextButton(
        child:Text('SELECT'),onPressed: (){Navigator.of(context).pop();print('Color chosen:'+color.toString());}),
    ],
  ),),
  );
    suggestion(String dropdownValue, DateTime startDateTime, DateTime endDateTime) async {
     duration=endDateTime.difference(startDateTime);
    print('duration:'+duration.toString());
    List <DateTime> arr=[];int myVar=1;
    for(int i=0;i<4;i++)
    {
      var suggestion;
      if(i%2==0)
        suggestion=DateTime(startDateTime.year,startDateTime.month,startDateTime.day-myVar,9,00);
      else{
        suggestion=DateTime(startDateTime.year,startDateTime.month,startDateTime.day-myVar,15,30);
        myVar++;}
      bool val = await toUpload(dropdownValue,suggestion,suggestion.add(duration));
      if(val==false)
        arr.add(suggestion);
    }
    myVar=0;
    for(int i=0;i<6;i++)
      {
        var suggestion;
        if(i%2==0)
          suggestion=DateTime(startDateTime.year,startDateTime.month,startDateTime.day+myVar,9,00);
        else{
          suggestion=DateTime(startDateTime.year,startDateTime.month,startDateTime.day+myVar,15,30);
          myVar++;}
        bool val = await toUpload(dropdownValue,suggestion,suggestion.add(duration));
        if(val==false)
          arr.add(suggestion);
      }
    return arr;
  }
}
