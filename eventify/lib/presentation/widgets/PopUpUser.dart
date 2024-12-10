import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eventify/domain/entities/user.dart';
import 'package:http/http.dart' as http;


class PopUpUser extends StatelessWidget {
  final List<User> users;
  final String eventId; // Agrega el eventId como parámetro

  PopUpUser({super.key, required this.users, required this.eventId});

  Future<void> sendInvitation(BuildContext context, String? userId, String eventId) async {
    final url = Uri.parse('http://localhost:4000/api/events/schedule-email-job'); // Cambia por tu URL base

      try {
        // Enviar la petición POST al backend
        final response = await http.post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'userId': userId,
            'eventId': eventId,
          }),
        );
      if (response.statusCode == 200) {
        showCustomSnackBar(context, eventId);
      } else {
        print("Error al programar el correo: ${response.body}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Error al programar el correo'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      print("Error de conexión: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Error de conexión'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void showCustomSnackBar(BuildContext context, String eventId) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 28),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Invitation sent to $eventId',
                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Search Users',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(height: 8),
          TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[200],
              hintText: 'Search...',
              prefixIcon: const Icon(Icons.search),
              contentPadding: const EdgeInsets.symmetric(vertical: 15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
      content: SizedBox(
        width: double.maxFinite,
        height: 300,
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: users.length,
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 5,
              shadowColor: Colors.black.withOpacity(0.2),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.blueAccent,
                  child: const Icon(Icons.person, color: Colors.white),
                ),
                title: Text(users[index].name),
                subtitle: Text(users[index].email),
                trailing: IconButton(
                    icon: const Icon(Icons.send, color: Colors.green),
                    onPressed: () {
                      // Llamar la función para enviar el correo
                      sendInvitation(context, users[index].id, eventId);
                      Navigator.of(context).pop();
                    },
                ),
              ),
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Close', style: TextStyle(color: Colors.black)),
        ),
      ],
    );
  }
}
