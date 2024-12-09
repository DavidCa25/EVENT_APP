class User {
  final String id;
  final String name;
  final String email;
  final bool isEmailSent;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.isEmailSent
  });

  factory User.fromJson(Map<String, dynamic>json){
    return User(id: json["id"],name: json["name"], email: json["email"], isEmailSent: json["isEmailSent"]);
  }

}