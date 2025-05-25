// lib/screens/player_screen.dart
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class PlayerScreen extends StatefulWidget {
  final String title;
  final String artist;
  final String url;
  final String cover;

  const PlayerScreen({
    Key? key,
    required this.title,
    required this.artist,
    required this.url,
    required this.cover,
  }) : super(key: key);

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  late AudioPlayer _player;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    _player.setUrl(widget.url).then((_) => _player.play());
    isPlaying = true;
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  void togglePlayPause() {
    setState(() {
      if (isPlaying) {
        _player.pause();
      } else {
        _player.play();
      }
      isPlaying = !isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(widget.cover, height: 300),
            ),
          ),
          SizedBox(height: 30),
          Text(
            widget.title,
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
          SizedBox(height: 10),
          Text(
            widget.artist,
            style: TextStyle(color: Colors.grey, fontSize: 18),
          ),
          SizedBox(height: 30),
          IconButton(
            icon: Icon(
              isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill,
              color: Colors.white,
              size: 64,
            ),
            onPressed: togglePlayPause,
          ),
        ],
      ),
    );
  }
}
