// lib/screens/music_list_screen.dart
import 'package:flutter/material.dart';
import 'saavn_service.dart';
import 'player_screen.dart';

class MusicListScreen extends StatefulWidget {
  final String mood;
  const MusicListScreen({Key? key, required this.mood}) : super(key: key);

  @override
  State<MusicListScreen> createState() => _MusicListScreenState();
}

class _MusicListScreenState extends State<MusicListScreen> {
  List<Map<String, String>> songs = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchSongs();
  }

  Future<void> fetchSongs([String? query]) async {
    setState(() => isLoading = true);
    final result = await SaavnService.searchSongs('Arijit Singh');
    setState(() {
      songs = result;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.mood} Songs'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search songs...',
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.grey[900],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                suffixIcon: Icon(Icons.search, color: Colors.white),
              ),
              onSubmitted: fetchSongs,
            ),
          ),
          isLoading
              ? Center(child: CircularProgressIndicator())
              : Expanded(
                  child: ListView.builder(
                    itemCount: songs.length,
                    itemBuilder: (context, index) {
                      final song = songs[index];
                      return ListTile(
                        leading: Image.network(song['cover']!, width: 50),
                        title: Text(song['title']!, style: TextStyle(color: Colors.white)),
                        subtitle: Text(song['artist']!, style: TextStyle(color: Colors.grey)),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PlayerScreen(
                                title: song['title']!,
                                artist: song['artist']!,
                                url: song['url']!,
                                cover: song['cover']!,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
