
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'song_model.dart';

class PlayerScreen extends StatefulWidget {
  final List<Song> songs;

  PlayerScreen({required this.songs});

  @override
  _PlayerScreenState createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  int _currentIndex = 0;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    playCurrentSong();
  }

  void playCurrentSong() async {
    await _audioPlayer.play(UrlSource(widget.songs[_currentIndex].audioUrl));
    setState(() => isPlaying = true);
  }

  void stopSong() async {
    await _audioPlayer.stop();
    setState(() => isPlaying = false);
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final song = widget.songs[_currentIndex];

    return Scaffold(
      appBar: AppBar(title: Text(song.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (song.imageUrl.isNotEmpty)
              Image.network(song.imageUrl, height: 250, fit: BoxFit.cover),
            SizedBox(height: 20),
            Text(song.title, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text(song.artist),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.play_arrow),
                  iconSize: 40,
                  onPressed: playCurrentSong,
                ),
                IconButton(
                  icon: Icon(Icons.stop),
                  iconSize: 40,
                  onPressed: stopSong,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}