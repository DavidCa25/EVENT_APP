class User {
  final String? id;
  final String name;
  final String email;
  final bool? isEmailSent;

  User({
    this.id,
    required this.name,
    required this.email,
    this.isEmailSent
  });
  // Constructor de fábrica para crear un objeto User a partir de un JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] as String,  // Aquí se asegura que el '_id' se asigna a 'id'
      name: json['name'] as String,
      email: json['email'] as String,
      isEmailSent: json['isEmailSent'] as bool,
    );
  }

  // Método para convertir el objeto User a un mapa JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'isEmailSent': isEmailSent,
    };
  }

}