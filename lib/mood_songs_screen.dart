import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MoodSongsScreen extends StatefulWidget {
  final String mood;

  const MoodSongsScreen({required this.mood, super.key});

  @override
  State<MoodSongsScreen> createState() => _MoodSongsScreenState();
}

class _MoodSongsScreenState extends State<MoodSongsScreen> {
  List<dynamic> songs = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchSongs();
  }

  Future<void> fetchSongs() async {
    final url = Uri.parse("https://saavn.dev/api/search/songs?query=${widget.mood}");
    final res = await http.get(url);

    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      setState(() {
        songs = data['data'] ?? [];
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      debugPrint("Failed to load songs");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.mood} Songs')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : songs.isEmpty
              ? const Center(child: Text("No songs found."))
              : ListView.builder(
                  itemCount: songs.length,
                  itemBuilder: (_, index) {
                    final song = songs[index];
                    return ListTile(
                      leading: Image.network(song['image'][0]['link'], width: 50, height: 50),
                      title: Text(song['name']),
                      subtitle: Text(song['primaryArtists']),
                      trailing: IconButton(
                        icon: const Icon(Icons.play_arrow),
                        onPressed: () {
                          // Navigate to player screen and pass the URL
                          // You can create a music player screen for this
                        },
                      ),
                    );
                  },
                ),
    );
  }
}
