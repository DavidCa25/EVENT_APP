import 'package:eventify/presentation/widgets/event_card.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  final List<Map<String, String>> eventos = []; 

  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Mis eventos",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 15.0),
            Expanded(
              child: eventos.isEmpty
                  ? Center(
                      child: Image.asset('images/no_event.jpg'), 
                    )
                  : ListView.builder(
                      itemCount: eventos.length,
                      itemBuilder: (context, index) {
                        return EventCard(
                          title: eventos[index]['title']!,
                          location: eventos[index]['location']!,
                          time: eventos[index]['time']!,
                          date: eventos[index]['date']!,
                          month: eventos[index]['month']!,
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
