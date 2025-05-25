import 'package:flutter/material.dart';
import 'screen.dart';
import 'sps_game.dart';

class GameSelectionPage extends StatelessWidget {
  void navigateToGame(BuildContext context, Widget gamePage) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => gamePage),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 150,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Color(0xFFF4B9B9),
        title: Text(
          'SELECT A GAME',
          style: TextStyle(fontSize: 35,
              fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body:Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xFFF6E5C3),Color(0xFFFBD995),Color(0xFFFDC556),Color(
                  0xFFFBB732)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          ),
        ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GameTile(
              imagePath: 'assets/sps.jpg',
              gameName: 'STONE PAPER SCISSOR',
              onTap: () => navigateToGame(context, GamePage()), // Navigates to sps_game.dart
            ),
            SizedBox(height: 20),
            GameTile(
              imagePath: 'assets/zx.png',
              gameName: 'TIC TAC TOE',
              onTap: () => navigateToGame(context, Screen()), // Navigates to screen.dart
            ),
          ],
        ),
      ),
      ),
    );
  }
}

class GameTile extends StatelessWidget {
  final String imagePath;
  final String gameName;
  final VoidCallback onTap;

  GameTile({required this.imagePath, required this.gameName, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xFFF4B9B9),
        ),
        child: Align(
        alignment: Alignment.center, // Centers the tile
        child: Row(
          children: [
            Image.asset(imagePath, width: 100, height: 100, fit: BoxFit.cover),
            SizedBox(width: 20),
            Text(
              gameName,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),),
    );
  }
}
