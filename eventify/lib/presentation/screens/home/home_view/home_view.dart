import 'package:eventify/domain/providers/eventify_provider.dart';
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
    });
  }

    void openUserPopUp(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => PopUpUser(),
    );
  }

  void onEventSelected(BuildContext context, String name) {
    openUserPopUp(context);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EventifyProvider>(context);

    print("Eventos en el HomeView: ${provider.eventos}");


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
              child: provider.eventos.isNotEmpty
                  ? ListView.builder(
                      itemCount: provider.eventos.length,
                      itemBuilder: (context, index) {
                        final evento = provider.eventos[index];

                        return GestureDetector(
                          onTap: () => onEventSelected(context, evento.name),
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
                      child: CircularProgressIndicator(), 
                    ),
            ),
          ],
        ),
      ),
    );
  }
}


