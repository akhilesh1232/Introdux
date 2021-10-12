class LocationsCollege {
  static List<Map<String, dynamic>> list = [
    {"title": 'WCE Playground', "id": 1, "lat": 16.84305, "lon": 74.60092},
    {"title": 'Lipton', "id": 2, "lat": 16.844476, "lon": 74.602337},
    {"title": 'Library', "id": 3, "lat": 16.84480, "lon": 74.60193},
    {"title": 'Vision Office', "id": 11, "lat": 16.84344, "lon": 74.60181},
    {"title": "Badminton Court", "id": 4, "lat": 16.84378, "lon": 74.60099},
    {"title": "Gymkhana", "id": 5, "lat": 16.84397, "lon": 74.60159},
    {"title": "Physics Department", "id": 6, "lat": 16.84359, "lon": 74.60170},
    {"title": "WCE Quadrangle", "id": 7, "lat": 16.844557, "lon": 74.60098},
    {"title": "Tilak Hall", "id": 8, "lat": 16.84443, "lon": 74.60123},
    {"title": "Open Air theatre", "id": 9, "lat": 16.84462, "lon": 74.60063},
    {"title": "VolleyBall court", "id": 10, "lat": 16.84395, "lon": 74.60058},
    {"title": "Canteen", "id": 12, "lat": 16.84339, "lon": 74.60214},
    {"title": "Sarswati Idol", "id": 13, "lat": 16.844056, "lon": 74.601775},
    {"title": "CCF", "id": 14, "lat": 16.845783, "lon": 74.600320},
    {"title": "Chemistry Lab", "id": 15, "lat": 16.845995, "lon": 74.600399},
  ];
  var a = [];

  List getList() {
    List<String> options=[];
    for (var i = 0; i < list.length; i++) {
      options.add(list[i]['title']);
    }
    return options;
  }

  List findLocation(String location) {
    for (var i = 0; i < list.length; i++) {
      if (list[i]['title'] == location) {
        a.add(list[i]['title']);
        a.add(list[i]['id']);
        a.add(list[i]['lat']);
        a.add(list[i]['lon']);
      }
    }
    return a;
  }
}