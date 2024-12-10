import 'package:eventify/domain/entities/user.dart';
import 'package:eventify/domain/providers/eventify_provider.dart';
import 'package:eventify/domain/providers/user_provider.dart';
import 'package:eventify/presentation/widgets/PopUpUser.dart';
import 'package:eventify/presentation/widgets/event_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<EventifyProvider>(context, listen: false).getEventos();
      Provider.of<UserProvider>(context, listen: false).getUsuarios();
    });
  }

  // Función para mostrar el popup con la lista de usuarios
  void showUserPopup(BuildContext context, List<User> users, String eventId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return PopUpUser(users: users, eventId: eventId);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final eventifyProvider = Provider.of<EventifyProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Mis Eventos",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15.0),
            Expanded(
              child: eventifyProvider.eventos.isNotEmpty
                  ? ListView.builder(
                      itemCount: eventifyProvider.eventos.length,
                      itemBuilder: (context, index) {
                        final evento = eventifyProvider.eventos[index];

                        return GestureDetector(
                          onTap: () {
                            // Mostrar el popup al hacer clic en la card del evento
                            showUserPopup(context, userProvider.usuarios, evento.id!);
                          },
                          child: EventCard(
                            name: evento.name,
                            date: evento.date,
                            description: evento.description,
                            lat: evento.lat,
                            lng: evento.lng,
                          ),
                        );
                      },
                    )
                  : const Center(
                      child: CircularProgressIndicator(), // Indicador mientras se cargan los datos
                    ),
            ),
          ],
        ),
      ),
    );
  }
}



