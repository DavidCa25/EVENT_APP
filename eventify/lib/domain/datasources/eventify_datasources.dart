import 'package:dio/dio.dart';
import 'package:eventify/domain/entities/eventify.dart';

class EventifyDatasources {
  Future<List<Eventify>> getEventos() async {
   var dio = Dio();
    dio.options.baseUrl = "https://localhost:4000/api";
    final response = await dio.get("/eventos");
    final data = response.data as List;
    final eventos = Eventify.fromJson(data[0]);
     return data.map((item) => Eventify.fromJson(item)).toList();
  }

  Future createEvents(Eventify eventos) async{
    try{
      var dio = Dio();
    dio.options.baseUrl = "https://localhost:4000/api";
    final response = await dio.post("/eventos",
    data: {
      "name": eventos.name,
      "date": eventos.date,
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