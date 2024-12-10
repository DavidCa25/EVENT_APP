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

  factory User.fromJson(Map<String, dynamic>json){
    return User(id: json["id"],name: json["name"], email: json["email"], isEmailSent: json["isEmailSent"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email
    };
  }

}