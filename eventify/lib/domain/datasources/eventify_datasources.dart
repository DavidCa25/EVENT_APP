import 'package:dio/dio.dart';
import 'package:eventify/domain/entities/eventify.dart';

class EventifyDatasources {
  Future<List<Eventify>> getEventos() async {
    try {
      var dio = Dio();
      dio.options.baseUrl = "http://localhost:4000/api/events";
      final response = await dio.get("/events");
      final data = response.data as List;

      return data.map((item) => Eventify.fromJson(item)).toList();
      print(data);
    } catch (e) {
      print("Error al obtener eventos: $e");
      rethrow;
    }
  }



  Future createEvents(Eventify eventos) async{
    try{
      var dio = Dio();
    dio.options.baseUrl = "http://localhost:4000/api/events";
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