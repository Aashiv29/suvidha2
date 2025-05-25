// track.dart
class Track {
  final String name;
  final String artistName;
  final String audioUrl;
  final String albumImage;

  Track({
    required this.name,
    required this.artistName,
    required this.audioUrl,
    required this.albumImage,
  });

  factory Track.fromJson(Map<String, dynamic> json) {
    return Track(
      name: json['name'] ?? '',
      artistName: json['artist_name'] ?? '',
      audioUrl: json['audio'] ?? '',
      albumImage: json['album_image'] ?? '',
    );
  }
}
