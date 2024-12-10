import 'package:dio/dio.dart';
import 'package:eventify/domain/datasources/eventify_datasources.dart';
import 'package:eventify/domain/entities/eventify.dart';
import 'package:flutter/material.dart';

class EventifyProvider extends ChangeNotifier{
  EventifyDatasources datasource;
  List<Eventify> eventos = [];

  EventifyProvider({
    required this.datasource
  });

  Future<void> getEventos() async {
  try {
    var dio = Dio();
    dio.options.baseUrl = "http://localhost:4000/api/events";
    final response = await dio.get("/events");

    print("Respuesta del servidor: ${response.data}");

    final data = response.data as List;

    eventos = data.map((item) => Eventify.fromJson(item)).toList().toSet().toList();

    print("Eventos únicos: $eventos");

    notifyListeners();
  } catch (e) {
    print("Error al obtener eventos: $e");
  }
}

  Future addEventos(Eventify evento) async {
    final newEvento = await datasource.createEvents(evento);
    eventos.add(evento);
    notifyListeners();
  }
}