List<Map<String, String>> devotionalSongsList = [
  {'title': 'Om Jai Jagdish', 'artist': 'Traditional', 'url': 'https://example.com/song1.mp3'},
  {'title': 'Shree Ram Jai Ram', 'artist': 'Lata Mangeshkar', 'url': 'https://example.com/song2.mp3'},
];

List<Map<String, String>> romanticSongsList = [
  {'title': 'Pehla Nasha', 'artist': 'Udit Narayan', 'url': 'https://example.com/song3.mp3'},
  {'title': 'Tum Mile', 'artist': 'Neeraj Shridhar', 'url': 'https://example.com/song4.mp3'},
];

List<Map<String, String>> popularSongsList = [
  {'title': 'Chaiyya Chaiyya', 'artist': 'Sukhwinder Singh', 'url': 'https://example.com/song5.mp3'},
];

List<Map<String, String>> recommendSongs(String mood) {
  if (mood == 'Devotional') {
    return devotionalSongsList;
  } else if (mood == 'Romantic') {
    return romanticSongsList;
  } else {
    return popularSongsList;
  }
}
