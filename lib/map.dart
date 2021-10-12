//import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';

class GoogleMapScreen extends StatefulWidget {
  final String? title;
  final int? id;
  final double? lat, lon;
  const GoogleMapScreen({Key? key, this.title, this.id, this.lat, this.lon})
      : super(key: key);
  @override
  _GoogleMapScreenState createState() => _GoogleMapScreenState(
        title: this.title,
        id: this.id,
        lat: this.lat,
        lon: this.lon,
      );
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  String? title;
  int? id;
  double? lat, lon;
  _GoogleMapScreenState({this.title, this.id, this.lat, this.lon});

  Set<Marker> _markers = {};
  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _markers.add(Marker(
          markerId: MarkerId(id!.toString()),
          position: LatLng(lat!, lon!),
          icon: BitmapDescriptor.defaultMarker,
          onTap: () {
            InfoWindow(title: title!);
          }));
    });
  }

  //Completer<GoogleMapController> _controller = Completer();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('College Map'),
        backgroundColor: Color.fromRGBO(225, 76, 41, 0.9),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        markers: _markers,
        initialCameraPosition:
            CameraPosition(target: LatLng(lat!, lon!), zoom: 17),
        mapToolbarEnabled: true,
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        mapType: MapType.satellite,
      ),
    );
  }
}

// onMapCreated: (GoogleMapController controller) {
//           _controller.complete(controller);
//         },
