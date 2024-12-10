class Eventify {
  final String? id;
  final String name;
  final DateTime date;
  final String description;
  final double lat;
  final double lng;
  final DateTime creationDate;

  Eventify({
    this.id,
    required this.name,
    required this.date,
    required this.description,
    required this.lat,
    required this.lng,
    required this.creationDate,
  });

   @override
  String toString() {
    return 'Eventify(name: $name, date: $date, description: $description, lat: $lat, lng: $lng)';
  }
  factory Eventify.fromJson(Map<String, dynamic> json) {
    return Eventify(
      id: json['_id'],
      name: json['name'],
      date: DateTime.parse(json['date']),
      description: json['description'],
      lat: json['lat'].toDouble(),
      lng: json['lng'].toDouble(),
      creationDate: DateTime.parse(json['creationDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "date": date.toIso8601String(),
      "description": description,
      "lat": lat,
      "lng": lng
    };
  }
}
