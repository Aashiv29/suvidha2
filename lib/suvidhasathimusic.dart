import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

void main() => runApp(SuvidhaSathiMusicApp());

class SuvidhaSathiMusicApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MusicSearchScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Song {
  final String title;
  final String artist;
  final String url;
  final String coverImage;

  Song({required this.title, required this.artist, required this.url, required this.coverImage});
}

final List<Song> songList = [
  Song(
    title: "Tum Hi Ho",
    artist: "Arijit Singh",
    url: "assets/tumhiho.mp3",
    coverImage: "assets/tumhiho.jpg",
  ),
  Song(
    title: "Ajeeb Dastan",
    artist: "Lata Mangeshkar",
    url: "assets/ajeebdastan.mp3",
    coverImage: "assets/ajeb.jpg",
  ),
  Song(
    title: "Ek Pyar Ka Nagma Hai",
    artist: "Mukesh",
    url: "assets/ekpyarkanagma.mp3",
    coverImage: "assets/pyarkanagma.jpg",
  ),
  Song(
    title: "Shiv Tandav Stotram",
    artist: "Devotional",
    url: "assets/shiv.mp3",
    coverImage: "assets/sts.jpg",
  ),
  Song(
    title: "Hanuman Chalisa",
    artist: "Devotional",
    url: "assets/hanumanchalisa.mp3",
    coverImage: "assets/hunuman.jpg",
  ),
];

class MusicSearchScreen extends StatefulWidget {
  @override
  _MusicSearchScreenState createState() => _MusicSearchScreenState();
}

class _MusicSearchScreenState extends State<MusicSearchScreen> {
  String query = "";
  List<Song> searchResults = [];

  void searchSong(String input) {
    setState(() {
      query = input;
      searchResults = songList
          .where((song) => song.title.toLowerCase().contains(input.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Suvidha Sathi Music")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              onChanged: searchSong,
              decoration: InputDecoration(
                hintText: "Search for a song...",
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                final song = searchResults[index];
                return ListTile(
                  leading: Image.asset(song.coverImage, width: 50, height: 50, fit: BoxFit.cover),
                  title: Text(song.title),
                  subtitle: Text(song.artist),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MusicPlayerScreen(song: song),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MusicPlayerScreen extends StatefulWidget {
  final Song song;

  MusicPlayerScreen({required this.song});

  @override
  _MusicPlayerScreenState createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen> {
  final AudioPlayer _player = AudioPlayer();
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    currentIndex = songList.indexOf(widget.song);
    _playCurrent();
  }

  void _playCurrent() async {
    await _player.setAsset(songList[currentIndex].url);
    _player.play();
    setState(() {});
  }

  void _playNext() {
    if (currentIndex < songList.length - 1) {
      currentIndex++;
      _playCurrent();
    }
  }

  void _playPrevious() {
    if (currentIndex > 0) {
      currentIndex--;
      _playCurrent();
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentSong = songList[currentIndex];

    return Scaffold(
      appBar: AppBar(title: Text(currentSong.title)),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(currentSong.coverImage, height: 250, fit: BoxFit.cover),
          SizedBox(height: 20),
          Text(currentSong.title, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          Text(currentSong.artist, style: TextStyle(fontSize: 16, color: Colors.grey)),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(icon: Icon(Icons.skip_previous), iconSize: 40, onPressed: _playPrevious),
              StreamBuilder<PlayerState>(
                stream: _player.playerStateStream,
                builder: (context, snapshot) {
                  final isPlaying = snapshot.data?.playing ?? false;
                  return IconButton(
                    icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                    iconSize: 50,
                    onPressed: () => isPlaying ? _player.pause() : _player.play(),
                  );
                },
              ),
              IconButton(icon: Icon(Icons.skip_next), iconSize: 40, onPressed: _playNext),
            ],
          )
        ],
      ),
    );
  }
}
