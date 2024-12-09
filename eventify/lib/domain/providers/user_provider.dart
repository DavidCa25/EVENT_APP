import 'package:eventify/domain/datasources/users_datasources.dart';
import 'package:eventify/domain/entities/user.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  UsersDatasources datasource;
  List<User> eventos = [];

  UserProvider({
    required this.datasource
  });

  Future getEventos() async{
    final eventos = await datasource.getUsers();
    print(eventos);
    notifyListeners();
  }

}