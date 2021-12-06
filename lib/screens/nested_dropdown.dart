import 'package:flutter/material.dart';
import 'package:myapp/screens/get_current_location.dart';
import 'package:myapp/screens/home_screen.dart';import 'college_locations.dart';

class StaticDropDown extends StatefulWidget {
  const StaticDropDown({Key? key}) : super(key: key);
  static const routeName = '/staticDD';
  @override
  _StaticDropDownState createState() => _StaticDropDownState();
}

class _StaticDropDownState extends State<StaticDropDown> {
  List<String> departments = ['Civil','CSE','IT','Electronics','Electrical','Mechanical','First year labs','Other'];
  List<String> cseSub = ['Mini CCF','Database Lab','Computer network lab'];
  List<String> civilSub = ['Drawing hall','Geo-technical lab','Surveying Lab','Civil Library'];
  List<String> otherSub = ['WCE Playground','Badminton court','VolleyBall court','Lipton','Canteen','WCE Quadrangle','Vision Office','Girls hostel'];
  List<String> eleSub = ['Ele. Department building'];
  List<String> mechSub = ['Heat transfer lab','Black Smithy'];
  List<String> otherLabs = ['Chemistry lab','Physics Department','Mechanics lab','Workshop'];

  List<String> provinces = [];
  String ?selectedCountry;
  String ?selectedProvince;
  String ?dropdownValue;
  LocationsCollege obj = LocationsCollege();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(44, 57, 75, 1),
      body:  Column(
        children: [
          SizedBox(height: 30,),
          Row(
            children: [
              IconButton(onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => new HomeScreen()));
              },
                icon: Icon(Icons.arrow_back),
                color: Color.fromRGBO(255, 76, 41, 0.8),
                padding: EdgeInsets.all(20),),
              SizedBox(width: 30,),
              Text('Search Location', textAlign: TextAlign.left,
                style: TextStyle(color: Colors.white,
                  fontSize: 30, fontWeight: FontWeight.bold,
                ),),

            ],
          ),
      SizedBox(
        height: 400,

        child: ListView(
          padding: const EdgeInsets.all(40.0),
          children: [
            // Country Dropdown
            DropdownButton<String>(
              hint: const Text('Department',style: TextStyle(color:Color.fromRGBO(255, 76, 41, 1), fontSize: 20),),
              value: selectedCountry,
              dropdownColor: Colors.white,
              isExpanded: true,
              items: departments.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value,style: const TextStyle(color:Color.fromRGBO(255, 76, 41, 1), fontSize: 20),),
                );
              }).toList(),
              onChanged: (country) {
                if (country == 'Civil') {
                  provinces = civilSub;
                } else if (country == 'CSE') {
                  provinces = cseSub;
                } else if (country == 'Electrical') {
                  provinces = eleSub;
                } else if (country == 'Mechanical'){
                  provinces = mechSub;
                } else if (country == 'First year labs'){
                  provinces = otherLabs;
                } else if (country == 'Other') {
                  provinces = otherSub;
                } else {
                  provinces = [];
                }
                setState(() {
                  selectedProvince = null;
                  selectedCountry = country;
                });
              },
            ),
            // Country Dropdown Ends here
            const SizedBox(height: 60.0),
            // Province Dropdown
            DropdownButton<String>(
              hint: const Text('Locations', style: TextStyle(color:Color.fromRGBO(255, 76, 41, 1), fontSize: 20),),
              value: selectedProvince,
              dropdownColor: Colors.white,
              isExpanded: true,
              items: provinces.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value,style: const TextStyle(color:Color.fromRGBO(255, 76, 41, 1), fontSize: 20),),
                );
              }).toList(),
              onChanged: (province) {
                setState(() {
                  dropdownValue = province;
                  selectedProvince = province;
                });
              },
            ),
            // Province Dropdown Ends here
            const SizedBox(height: 60,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: const Color.fromRGBO(255, 76, 41, 0.8),
                elevation: 10,
              ),

              onPressed: () {
                List inputValue = obj.findLocation(dropdownValue!);
                print(inputValue);
                UserLocation().getCurrentPosition(inputValue[2].toString(), inputValue[3].toString());
                inputValue.clear();
              },
              child: const Text(
                'Search',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
                ],
    ),
      ),
    ],
    ),
    );
  }
}