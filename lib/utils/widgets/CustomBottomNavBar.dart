import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onItemSelected;

  CustomBottomNavBar({
    required this.currentIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavyBar(
      mainAxisAlignment: MainAxisAlignment.center,
      backgroundColor: Colors.black,
      selectedIndex: currentIndex,
      onItemSelected: onItemSelected,
      items: [

        BottomNavyBarItem(
          icon: Icon(Icons.person),
          title: Text('Personajes'),
          activeColor: Color(0xFF05C2DC),
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.home_filled),
          title: Text('Inicio'),
          activeColor: Color(0xFF05C2DC),
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.video_label),
          title: Text('Episodios'),
          activeColor: Color(0xFF05C2DC),
        ),
      ],
    );
  }
}
