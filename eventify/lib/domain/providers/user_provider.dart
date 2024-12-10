import 'package:dio/dio.dart';
import 'package:eventify/domain/datasources/users_datasources.dart';
import 'package:eventify/domain/entities/user.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  UsersDatasources datasource;
  List<User> usuarios = [];

  UserProvider({
    required this.datasource
  });

  Future<void> getUsuarios() async{
    try{
      var dio = Dio();
      dio.options.baseUrl = "http://localhost:4000/api/events";
      final response = await dio.get("/users");
      print("Respuesta del servidor: ${response.data}");
      final data = response.data as List;
      usuarios = data.map((item) => User.fromJson(item)).toList().toSet().toList();
      print("Eventos únicos: $usuarios");
      notifyListeners();
    }
    catch(e){
        print("Error al obtener usuarios: $e");
    }
  }

}