import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavbarWidget extends StatelessWidget {
  final int index;

  const NavbarWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 30,
      left: 40,
      right: 40,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 75,
        decoration: BoxDecoration(
          color: Colors.blueGrey[300],
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(
              context,
              icon: Icons.home,
              selected: index == 0,
              onTap: () => context.go("/home/0"),
            ),
            _buildNavItem(
              context,
              icon: Icons.chat_bubble_outline,
              selected: index == 1,
              onTap: () => context.go("/home/1"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required IconData icon,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return ScaleTransition(
            scale: animation,
            child: child,
          );
        },
        child: Container(
          key: ValueKey<int>(selected ? 1 : 0),
          width: 45,
          height: 45,
          decoration: BoxDecoration(
            color: selected ? Colors.white : Colors.transparent,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: selected ? Colors.black : Colors.white,
            size: 24,
          ),
        ),
      ),
    );
  }
}

