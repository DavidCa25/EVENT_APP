import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  final String title;
  final DateTime date;
  final String description;
  final double lat;
  final double lng;

  const EventCard({
    super.key,
    required this.title,
    required this.date,
    required this.description,
    required this.lat,
    required this.lng,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 5.0),

          
          Text(
            'Fecha: ${date.toLocal()}.split(' ')[0]',
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 5.0),

          
          Text(
            description,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
            overflow: TextOverflow.ellipsis,
          ),

          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.location_on, size: 20, color: Colors.red),
              const SizedBox(width: 5.0),
              Expanded(
                child: Text(
                  'Lat: $lat, Long: $lng',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}