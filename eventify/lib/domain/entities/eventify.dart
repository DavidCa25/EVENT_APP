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
  // Conversión desde JSON
  factory Eventify.fromJson(Map<String, dynamic> json) {
    return Eventify(
      id: json['_id'], // ID desde la respuesta
      name: json['name'],
      date: DateTime.parse(json['date']), // Convertir cadena a DateTime
      description: json['description'],
      lat: json['lat'].toDouble(), // Asegurarse de que sea double
      lng: json['lng'].toDouble(),
      creationDate: DateTime.parse(json['creationDate']), // Convertir cadena a DateTime
    );
  }

  // Conversión a JSON (si necesitas enviar datos al backend)
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "date": date.toIso8601String(), // Convertir DateTime a ISO 8601
      "description": description,
      "lat": lat,
      "lng": lng
    };
  }
}
