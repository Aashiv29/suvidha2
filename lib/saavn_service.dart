import 'dart:convert';
import 'package:http/http.dart' as http;

class SaavnService {
  static Future<List<Map<String, String>>> searchSongs(String query) async {
    final url = Uri.parse('https://jiosaavn-unofficial-api.vercel.app/search/songs?query=$query');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      final List results = data['data']['results'] ?? [];

      return results.map<Map<String, String>>((song) {
        return {
          'title': song['title'] ?? '',
          'artist': song['artist'] ?? '',
          'url': song['downloadUrl'] ?? '',
          'cover': song['image'] ?? '',
        };
      }).toList();
    } else {
      throw Exception('Failed to load songs');
    }
  }
}
