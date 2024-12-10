
import 'package:eventify/domain/datasources/eventify_datasources.dart';
import 'package:eventify/domain/entities/eventify.dart';
import 'package:flutter/material.dart';

class EventifyProvider extends ChangeNotifier{
  EventifyDatasources datasource;
  List<Eventify> eventos = [];

  EventifyProvider({
    required this.datasource
  });

  Future<void> getEventos() async{
    final eventos = await datasource.getEventos();
    print(eventos.toString());
    notifyListeners();
  }

  Future addEventos(Eventify evento) async {
    final newEvento = await datasource.createEvents(evento);
    eventos.add(evento);
    notifyListeners();
  }
}