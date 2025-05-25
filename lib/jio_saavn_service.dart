import 'dart:convert';
import 'package:http/http.dart' as http;

class JioSaavnService {
  final String baseUrl = 'https://saavn.dev/api';

  Future<List<dynamic>> searchSongs(String query) async {
    final response = await http.get(Uri.parse('\$baseUrl/search/songs?query=\$query'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['data'] ?? [];
    } else {
      throw Exception('Failed to load songs');
    }
  }
}