import 'package:eventify/domain/entities/eventify.dart';
import 'package:eventify/domain/providers/eventify_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';


class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final dateController = TextEditingController();
  final Set<Marker> _markers = {};
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      final provider = Provider.of<EventifyProvider>(context,listen: false);
      provider.getEventos();
    });
  }
  void onLongPress(LatLng position){
    showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.lightBlue.shade50,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        title: const Text(
          "Agregar Incidente",
          style: TextStyle(color: Colors.blueAccent),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.event, color: Colors.blueAccent),
                labelText: "Nombre del Evento",
                labelStyle: const TextStyle(color: Colors.blueAccent),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 20.0),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: dateController,
              readOnly: true, 
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.calendar_today, color: Colors.blueAccent),
                labelText: "Fecha del Evento",
                labelStyle: const TextStyle(color: Colors.blueAccent),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 20.0),
                suffixIcon: const Icon(Icons.arrow_drop_down, color: Colors.blueAccent),
              ),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2101),
                );

                if (pickedDate != null) {
                  String formattedDate =
                      "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                  dateController.text = formattedDate;
                }
              },
            ),
            const SizedBox(height: 20),

            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.description, color: Colors.blueAccent),
                labelText: "Descripción",
                labelStyle: const TextStyle(color: Colors.blueAccent),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 20.0),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: (){
            context.pop();
          }, child: const Text("Cancelar")),
          TextButton(
            onPressed: () async {
              context.pop();
              final provider = Provider.of<EventifyProvider>(context, listen: false);
              try {
                final parsedDate = DateTime.parse(dateController.text);
                final newEvent = Eventify(
                 name: titleController.text,
                 date: parsedDate,
                 description: descriptionController.text,
                 lat: position.latitude,
                 lng: position.longitude,
                 creationDate: DateTime.now(),
                );

                await provider.addEventos(newEvent);

                setState(() {
                  _markers.add(Marker(
                    markerId: MarkerId(position.toString()),
                    position: position,
                    infoWindow: InfoWindow(
                      title: titleController.text,
                      snippet: descriptionController.text,
                    ),
                  ));
                });

                titleController.clear();
                descriptionController.clear();
                dateController.clear();
              } catch (e) {
                print("Error al registrar el evento: $e");
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Error al registrar el evento")),
                );
              }
            },
            child: const Text("Aceptar"),
          ),
        ],
      );
    });
  }

  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: 
        const CameraPosition(target: LatLng(21.128010, -101.687023), 
        zoom: 12),
        onLongPress: onLongPress,
        markers: _markers,
    );
  }
}