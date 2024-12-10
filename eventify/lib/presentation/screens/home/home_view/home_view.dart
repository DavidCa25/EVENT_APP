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
      final provider = Provider.of<EventifyProvider>(context, listen: false);
      provider.getEventos(); 
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Eventos"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Mis Eventos",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15.0),
          Expanded(
            child: Consumer<EventifyProvider>(
              builder: (context, provider, child) {
                if (provider.eventos.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }

                return ListView.builder(
                  itemCount: provider.eventos.length,
                  itemBuilder: (context, index) {
                    final evento = provider.eventos[index];
                    return GestureDetector(
                      onTap: () => onEventSelected(context, evento.name),
                      child: EventCard(
                        title: evento.name,
                        date: evento.date,
                        description: evento.description,
                        lat: evento.lat,
                        lng: evento.lng,
                      ),
                    );
                  },
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
