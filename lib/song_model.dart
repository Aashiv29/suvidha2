
class Song {
  final String title;
  final String artist;
  final String audioUrl;
  final String imageUrl;

  Song({required this.title, required this.artist, required this.audioUrl, required this.imageUrl});

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      title: json['name'] ?? 'Unknown',
      artist: json['artist_name'] ?? 'Unknown Artist',
      audioUrl: json['audio'] ?? '',
      imageUrl: json['album_image'] ?? '',
    );
  }
}