import 'package:dio/dio.dart';
import 'package:eventify/domain/entities/user.dart';

class UsersDatasources {
  Future<List<User>> getUsers() async {

    var dio = Dio();
    dio.options.baseUrl = "https://localhost:4000/api";
    final response = await dio.get("/users");
    final data = response.data as List;
    final eventos = User.fromJson(data[0]);
     return data.map((item) => User.fromJson(item)).toList();
  }
}