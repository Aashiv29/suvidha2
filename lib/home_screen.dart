import 'package:flutter/material.dart';
import 'music_list_screen.dart';

class HomeScreen extends StatelessWidget {
  final List<Map<String, dynamic>> moods = [
    {'title': 'Happy', 'icon': Icons.sentiment_satisfied_alt},
    {'title': 'Sad', 'icon': Icons.sentiment_dissatisfied},
    {'title': 'Party', 'icon': Icons.music_note},
    {'title': 'Devotional', 'icon': Icons.self_improvement},
    {'title': '90\'s Hits', 'icon': Icons.radio},
    {'title': 'Random', 'icon': Icons.shuffle},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Music Player"),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Bar
            TextField(
              decoration: InputDecoration(
                hintText: 'Search songs...',
                hintStyle: TextStyle(color: Colors.grey),
                prefixIcon: Icon(Icons.search, color: Colors.white),
                filled: true,
                fillColor: Colors.grey[900],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20),

            // Mood Tiles
            Expanded(
              child: GridView.builder(
                itemCount: moods.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 per row
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 3 / 2,
                ),
                itemBuilder: (context, index) {
                  final mood = moods[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MusicListScreen(mood: mood['title']),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[850],
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(mood['icon'], color: Colors.white, size: 36),
                          SizedBox(height: 8),
                          Text(
                            mood['title'],
                            style: TextStyle(
                                color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
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
