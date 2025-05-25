import 'dart:convert';
import 'package:http/http.dart' as http;

class LastFmService {
  final String apiKey = '04ef2120c913fb60b1b6c168291abd74';  // Replace with your actual API key
  final String baseUrl = 'https://ws.audioscrobbler.com/2.0/';

  // Function to search for songs/artists on Last.fm
  Future<Map<String, dynamic>> searchSong(String query) async {
    final response = await http.get(
      Uri.parse('$baseUrl?method=track.search&track=$query&api_key=$apiKey&format=json'),
    );

    if (response.statusCode == 200) {
      // Parse the JSON data
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load song data');
    }
  }
}
