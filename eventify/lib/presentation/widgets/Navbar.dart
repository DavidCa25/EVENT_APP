import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavbarWidget extends StatelessWidget {
  final int index;
  const NavbarWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 375,
      height: 75,
      decoration: BoxDecoration(
        color: Colors.grey[200],
      ),
      child: CurvedNavigationBar(
        index: index,
        backgroundColor: Colors.white, 
        onTap: (value) {
          switch (value) {
            case 0:
              context.go("/home/0"); 
              break;
            case 1:
              context.go("/home/1"); 
              break;
          }
        },
        color: Colors.amber[100]!, 
        items: [
          Icon(
            Icons.home,
            color: index == 0 ? Colors.black : Colors.blue, 
            size: 32,
          ),
          Icon(
            Icons.map_outlined,
            color: index == 1 ? Colors.black : Colors.blue,
            size: 32,
          ),
        ],
      ),
    );
  }
}
