import 'dart:convert';
import 'package:http/http.dart' as http;
import 'song_model.dart';

class ApiService {
  static Future<List<Song>> fetchMoodSongs(String mood) async {
    final String apiUrl = "https://api.jamendo.com/v3.0/tracks/?client_id=4d9b8b67&format=json&limit=10&search=$mood&include=musicinfo,stats";
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<Song> songs = (data['results'] as List).map((song) => Song.fromJson(song)).toList();
        return songs;
      } else {
        throw Exception("Failed to load songs");
      }
    } catch (e) {
      print("API Error: $e");
      return [];
    }
  }
}