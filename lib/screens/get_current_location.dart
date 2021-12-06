import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:myapp/screens/map_utils.dart';


class UserLocation{
  void getCurrentPosition(String str3,String str4)async{
    //check permission
    LocationPermission permission=await Geolocator.checkPermission();
    if(permission==LocationPermission.denied||permission==LocationPermission.deniedForever) {
      print('Permission not given');
      await Geolocator.requestPermission();
    } else{
      Position currentPosition=await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.bestForNavigation
      );
      MapUtils.openMap('16.839799','74.597668' , str3, str4);
    }
  }
}