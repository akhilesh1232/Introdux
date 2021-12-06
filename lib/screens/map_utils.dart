import 'package:url_launcher/url_launcher.dart';

class MapUtils{
  MapUtils._();

  static Future<void>openMap(String str1,String str2,String str3,String str4)async{

    String googleMapUrl = 'https://www.google.com/maps/dir/?api=1&destination=$str3,$str4 &origin=$str1,$str2 &travelmode=walking&dir_action=navigate';

    if(await canLaunch(googleMapUrl)){
      await launch(googleMapUrl,forceWebView: false);
    }
    else{
      print( googleMapUrl);
    }
  }
}

//'https://www.google.com/maps/dir/?api=1&query=16.8457,74.6015';