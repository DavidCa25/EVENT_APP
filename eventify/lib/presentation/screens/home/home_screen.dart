import 'package:eventify/presentation/screens/home/home_view/home_view.dart';
import 'package:eventify/presentation/screens/home/map_view/map_view.dart';
import 'package:eventify/presentation/widgets/Navbar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final int viewIndex;
  const HomeScreen({super.key, required this.viewIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: viewIndex, children: const [
        HomeView(),
        MapView()
      ],),
      bottomNavigationBar: NavbarWidget(index: viewIndex,),
    );
  }
}