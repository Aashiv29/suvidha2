
import 'package:flutter/material.dart';
import 'api_service.dart';
import 'song_model.dart';
import 'music_player_screen.dart';

class HomeScreen extends StatelessWidget {
  final List<String> moods = ['Happy', 'Sad', 'Party', 'Devotional'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Music Player')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Select Mood', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              padding: EdgeInsets.all(10),
              children: moods.map((mood) {
                return GestureDetector(
                  onTap: () async {
                    List<Song> songs = await ApiService.fetchMoodSongs(mood);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => PlayerScreen(songs: songs)),
                    );
                  },
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    child: Center(child: Text(mood, style: TextStyle(fontSize: 18))),
                  ),
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}