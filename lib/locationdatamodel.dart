import 'dart:ffi';

class LocationDataModel {
  String? title;
  int? id;
  Float? lat;
  Float? long;

  LocationDataModel({
    this.title,
    this.id,
    this.lat,
    this.long,
  });

  LocationDataModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    id = json['is'];
    lat = json['lat'];
    long = json['long'];
  }
}
