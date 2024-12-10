import 'package:dio/dio.dart';
import 'package:eventify/domain/entities/eventify.dart';

class EventifyDatasources {
  Future<List<Eventify>> getEventos() async {
    try {
      var dio = Dio();
      dio.options.baseUrl = "http://localhost:4000/api/events";
      final response = await dio.get("/events");
      final data = response.data as List;

      // Convertir cada elemento en una instancia de Eventify
      return data.map((item) => Eventify.fromJson(item)).toList();
    } catch (e) {
      print("Error al obtener eventos: $e");
      rethrow;
    }
  }



  Future createEvents(Eventify eventos) async{
    try{
      var dio = Dio();
    dio.options.baseUrl = "https://f357-2806-2f0-6020-ae05-e436-29d5-9afe-a03b.ngrok-free.app/api/events";
    final response = await dio.post("/events",
    data: {
      "name": eventos.name,
      "date": eventos.date.toIso8601String(),
      "description": eventos.description,
      "lat": eventos.lat,
      "lng": eventos.lng
      
    });
    return Eventify.fromJson(response.data);
    }catch(e){
      print(e);
      rethrow;
    }
  }
}