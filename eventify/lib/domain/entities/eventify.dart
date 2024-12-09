class Eventify {
  final String id;
  final String name;
  final DateTime date;
  final String description;
  final double lng;
  final double lat;

  Eventify({
    required this.id,
    required this.name,
    required this.date,
    required this.description,
    required this.lng,
    required this.lat
  });

  factory Eventify.fromJson(Map<String, dynamic> json){
    return Eventify(id: json["id"], name: json["name"], date: json["date"], description: json["description"], lng: json["lng"], lat: json["lat"]);
  }
}