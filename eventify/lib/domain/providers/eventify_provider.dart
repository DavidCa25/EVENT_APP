import 'package:eventify/domain/datasources/eventify_datasources.dart';
import 'package:eventify/domain/entities/eventify.dart';
import 'package:flutter/material.dart';

class EventifyProvider extends ChangeNotifier{
  EventifyDatasources datasource;
  List<Eventify> eventos = [];

  EventifyProvider({
    required this.datasource
  });

  Future getEventos() async{
    final eventos = await datasource.getEventos();
    print(eventos);
    notifyListeners();
  }

  Future addEventos(Eventify eventos) async {
    final newEvento = await datasource.createEvents(eventos);
    
  }
}