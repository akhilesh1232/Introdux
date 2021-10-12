import 'package:flutter/material.dart';
import 'package:myapp/screens/map.dart';
import 'locations.dart';

class Dropdownsearch extends StatefulWidget {
  const Dropdownsearch({Key? key}) : super(key: key);

  @override
  _DropdownsearchState createState() => _DropdownsearchState();
}

class _DropdownsearchState extends State<Dropdownsearch> {
  LocationsCollege obj = LocationsCollege();
  String? dropdownValue;
  List?option;

  @override
  Widget build(BuildContext context) {
    option =  obj.getList();
    return Scaffold(
      backgroundColor: Color.fromRGBO(44, 57, 75, 1),
      appBar: AppBar(
        title: Text('College Map'),
        backgroundColor: Color.fromRGBO(255, 76, 41, 0.8),
      ),
      body: Center(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 30,),
              DropdownButton<String>(
                hint: Text(
                  'Choose location',
                  style: TextStyle(color:Color.fromRGBO(255, 76, 41, 1), fontSize: 20),
                ),
                value: dropdownValue,
                dropdownColor: Colors.white,
                icon: const Icon(
                  Icons.arrow_downward_rounded,
                  color: Colors.red,
                  size: 20,
                ),
                iconSize: 24,
                elevation: 10,
                style: const TextStyle(color: Colors.blueGrey, fontSize: 20),
                underline: Container(
                  height: 1,
                  color: Color.fromRGBO(51, 71, 86, 0.3),
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
                items: <String>['WCE Playground','Lipton','Library','Vision Office','Badminton Court','Gymkhana',
                  'Physics Department','WCE Quadrangle','Tilak Hall','Open Air theatre','VolleyBall court',
                  'Canteen','Sarswati Idol','CCF','Chemistry Lab'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(255, 76, 41, 0.8),
                  elevation: 10,
                ),
                onPressed: () {
                  List inputValue = obj.findLocation(dropdownValue!);
                  //print(option);
                  //inputValue.clear();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => GoogleMapScreen(
                        title: inputValue.length>0?inputValue[0]:'Walchand College of Engineering,Sangli',
                        id: inputValue.length>0?inputValue[1]:3,
                        lat: inputValue.length>0?inputValue[2]:16.8457,
                        lon: inputValue.length>0?inputValue[3]:74.6015,
                      ),
                    ),
                  );
                },
                child: Text(
                  'Search',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
