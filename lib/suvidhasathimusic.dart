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
    title: "01 - Offo - [Songsmp3.Com]",
    artist: "Unknown",
    url: "assets/music/01 - Offo - [SongsMp3.Com].mp3",
    coverImage: "assets/md.gif",
  ),
  Song(
    title: "01 Ae Dil Hai Mushkil - Title Track (Ae Dil Hai Mushkil)",
    artist: "Unknown",
    url: "assets/music/01 Ae Dil Hai Mushkil - Title Track (Ae Dil Hai Mushkil).mp3",
    coverImage: "assets/md.gif",
  ),
  Song(
    title: "01 Badri Ki Dulhania - Title Track",
    artist: "Unknown",
    url: "assets/music/01 Badri Ki Dulhania - Title Track.mp3",
    coverImage: "assets/md.gif",
  ),
  Song(
    title: "01 Disco Disco - A Gentleman",
    artist: "Unknown",
    url: "assets/music/01 Disco Disco - A Gentleman.mp3",
    coverImage: "assets/md.gif",
  ),
  Song(
    title: "01 Galla Goriyan - Baa Baa Black Sheep (Songsmp3.Com)",
    artist: "Unknown",
    url: "assets/music/01 Galla Goriyan - Baa Baa Black Sheep (SongsMp3.Com).mp3",
    coverImage: "assets/md.gif",
  ),
  Song(
    title: "01 Jabra Fan",
    artist: "Unknown",
    url: "assets/music/01 Jabra Fan.mp3",
    coverImage: "assets/md.gif",
  ),
  Song(
    title: "01 Kala Chashma",
    artist: "Unknown",
    url: "assets/music/01 Kala Chashma.mp3",
    coverImage: "assets/md.gif",
  ),
  Song(
    title: "01 Lae Dooba - Aiyaary",
    artist: "Unknown",
    url: "assets/music/01 Lae Dooba - Aiyaary.mp3",
    coverImage: "assets/md.gif",
  ),
  Song(
    title: "01 Luv U Zindaggi",
    artist: "Unknown",
    url: "assets/music/01 Luv u Zindaggi.mp3",
    coverImage: "assets/md.gif",
  ),
  Song(
    title: "01 Mere Rashke Qamar - Baadshaho",
    artist: "Unknown",
    url: "assets/music/01 Mere Rashke Qamar - Baadshaho.mp3",
    coverImage: "assets/md.gif",
  ),
  Song(
    title: "01 Mundiyan - Baaghi 2 (Songsmp3.Com)",
    artist: "Unknown",
    url: "assets/music/01 Mundiyan - Baaghi 2 (SongsMp3.Com).mp3",
    coverImage: "assets/md.gif",
  ),
  Song(
    title: "01 Nachle Na (Songsmp3.Com)",
    artist: "Unknown",
    url: "assets/music/01 Nachle Na (SongsMp3.Com).mp3",
    coverImage: "assets/md.gif",
  ),
  Song(
    title: "01 Soch Na Sake - Airlift",
    artist: "Unknown",
    url: "assets/music/01 Soch Na Sake - Airlift.mp3",
    coverImage: "assets/md.gif",
  ),
  Song(
    title: "01 Sweety Tera Drama - Bareilly Ki Barfi 190Kbps",
    artist: "Unknown",
    url: "assets/music/01 Sweety Tera Drama - Bareilly Ki Barfi 190Kbps.mp3",
    coverImage: "assets/md.gif",
  ),
  Song(
    title: "02 - Locha-E-Ulfat - [Songsmp3.Com]",
    artist: "Unknown",
    url: "assets/music/02 - Locha-E-Ulfat - [SongsMp3.Com].mp3",
    coverImage: "assets/md.gif",
  ),
  Song(
    title: "02 Bawara Mann (Jolly Ll.B 2)",
    artist: "Unknown",
    url: "assets/music/02 Bawara Mann (Jolly Ll.B 2).mp3",
    coverImage: "assets/md.gif",
  ),
  Song(
    title: "02 Dil Cheez Tujhe Dedi (Airlift)",
    artist: "Unknown",
    url: "assets/music/02 Dil Cheez Tujhe Dedi (Airlift).mp3",
    coverImage: "assets/md.gif",
  ),
  Song(
    title: "02 Dum Dum (Phillauri) (Songsmp3.Com)",
    artist: "Unknown",
    url: "assets/music/02 Dum Dum (Phillauri) (SongsMp3.Com).mp3",
    coverImage: "assets/md.gif",
  ),
  Song(
    title: "02 Gazab Ka Hai Din (Songsmp3.Com)",
    artist: "Unknown",
    url: "assets/music/02 Gazab Ka Hai Din (SongsMp3.Com).mp3",
    coverImage: "assets/md.gif",
  ),
  Song(
    title: "02 Peh Gaya Khalara",
    artist: "Unknown",
    url: "assets/music/02 Peh Gaya Khalara.mp3",
    coverImage: "assets/md.gif",
  ),
  Song(
    title: "02 Sau Aasmaan",
    artist: "Unknown",
    url: "assets/music/02 Sau Aasmaan.mp3",
    coverImage: "assets/md.gif",
  ),
  Song(
    title: "02 Toh Dishoom",
    artist: "Unknown",
    url: "assets/music/02 Toh Dishoom.mp3",
    coverImage: "assets/md.gif",
  ),
  Song(
    title: "02 Veeron Ke Veer Aa (Songsmp3.Com)",
    artist: "Unknown",
    url: "assets/music/02 Veeron Ke Veer Aa (SongsMp3.Com).mp3",
    coverImage: "assets/md.gif",
  ),
  Song(
    title: "03 - Mast Magan - [Songsmp3.Com]",
    artist: "Unknown",
    url: "assets/music/03 - Mast Magan - [SongsMp3.Com].mp3",
    coverImage: "assets/md.gif",
  ),
  Song(
    title: "03 Beat Juunglee (Dil Juunglee) (Songsmp3.Com)",
    artist: "Unknown",
    url: "assets/music/03 Beat Juunglee (Dil Juunglee) (SongsMp3.Com).mp3",
    coverImage: "assets/md.gif",
  ),
  Song(
    title: "03 Chandralekha - A Gentleman",
    artist: "Unknown",
    url: "assets/music/03 Chandralekha - A Gentleman.mp3",
    coverImage: "assets/md.gif",
  ),
  Song(
    title: "03 Gilehriyaan - Dangal",
    artist: "Unknown",
    url: "assets/music/03 Gilehriyaan - Dangal.mp3",
    coverImage: "assets/md.gif",
  ),
  Song(
    title: "03 Soja Zara (Songsmp3.Com)",
    artist: "Unknown",
    url: "assets/music/03 Soja Zara (SongsMp3.Com).mp3",
    coverImage: "assets/md.gif",
  ),
  Song(
    title: "03 Tu Mera Bhai Nahi Hai",
    artist: "Unknown",
    url: "assets/music/03 Tu Mera Bhai Nahi Hai.mp3",
    coverImage: "assets/md.gif",
  ),
  Song(
    title: "03 Twist Kamariya",
    artist: "Unknown",
    url: "assets/music/03 Twist Kamariya.mp3",
    coverImage: "assets/md.gif",
  ),
  Song(
    title: "03 Ude Dil Befikre (Befikre)",
    artist: "Unknown",
    url: "assets/music/03 Ude Dil Befikre (Befikre).mp3",
    coverImage: "assets/md.gif",
  ),
  Song(
    title: "04 - Iski Uski - [Songsmp3.Com]",
    artist: "Unknown",
    url: "assets/music/04 - Iski Uski - [SongsMp3.Com].mp3",
    coverImage: "assets/md.gif",
  ),
  Song(
    title: "04 Agar Tu Hota",
    artist: "Unknown",
    url: "assets/music/04 Agar Tu Hota.mp3",
    coverImage: "assets/md.gif",
  ),
  Song(
    title: "04 Bandeya (Dil Juunglee) (Songsmp3.Com)",
    artist: "Unknown",
    url: "assets/music/04 Bandeya (Dil Juunglee) (SongsMp3.Com).mp3",
    coverImage: "assets/md.gif",
  ),
  Song(
    title: "04 Bhangda Pa (A Flying Jatt)",
    artist: "Unknown",
    url: "assets/music/04 Bhangda Pa (A Flying Jatt).mp3",
    coverImage: "assets/md.gif",
  ),
  Song(
    title: "04 Ishq De Fanniyar (Male)",
    artist: "Unknown",
    url: "assets/music/04 Ishq De Fanniyar (Male).mp3",
    coverImage: "assets/md.gif",
  ),
  Song(
    title: "04 Nachde Ne Saare",
    artist: "Unknown",
    url: "assets/music/04 Nachde Ne Saare.mp3",
    coverImage: "assets/md.gif",
  ),
  Song(
    title: "05 Cutiepie (Ae Dil Hai Mushkil)",
    artist: "Unknown",
    url: "assets/music/05 Cutiepie (Ae Dil Hai Mushkil).mp3",
    coverImage: "assets/md.gif",
  ),
  Song(
    title: "05 Dil Jaane Na - Dil Juunglee (Songsmp3.Com)",
    artist: "Unknown",
    url: "assets/music/05 Dil Jaane Na - Dil Juunglee (SongsMp3.Com).mp3",
    coverImage: "assets/md.gif",
  ),
  Song(
    title: "05 Ishq De Fanniyar (Female)",
    artist: "Unknown",
    url: "assets/music/05 Ishq De Fanniyar (Female).mp3",
    coverImage: "assets/md.gif",
  ),
  Song(
    title: "05 Teri Khair Mangdi",
    artist: "Unknown",
    url: "assets/music/05 Teri Khair Mangdi.mp3",
    coverImage: "assets/md.gif",
  ),
  Song(
    title: "06 Dhaakad (Aamir Khan Version)",
    artist: "Unknown",
    url: "assets/music/06 Dhaakad (Aamir Khan Version).mp3",
    coverImage: "assets/md.gif",
  ),
  Song(
    title: "06 Je T Aime",
    artist: "Unknown",
    url: "assets/music/06 Je T aime.mp3",
    coverImage: "assets/md.gif",
  ),
  Song(
    title: "Ajeebdastan",
    artist: "Unknown",
    url: "assets/music/ajeebdastan.mp3",
    coverImage: "assets/md.gif",
  ),
  Song(
    title: "Balam Pichkari Full Song Video Yeh Jawaani Hai Deewani   Pritam   Ranbir Kapoor, Deepika Padukone",      
    artist: "Unknown",
    url: "assets/music/Balam Pichkari Full Song Video Yeh Jawaani Hai Deewani   PRITAM   Ranbir Kapoor, Deepika Padukone.mp3",
    coverImage: "assets/md.gif",
  ),
  Song(
    title: "Bulleya",
    artist: "Unknown",
    url: "assets/music/Bulleya.mp3",
    coverImage: "assets/md.gif",
  ),
  Song(
    title: "Channa Mereya",
    artist: "Unknown",
    url: "assets/music/Channa Mereya.mp3",
    coverImage: "assets/md.gif",
  ),
  Song(
    title: "Ekpyarkanagma",
    artist: "Unknown",
    url: "assets/music/ekpyarkanagma.mp3",
    coverImage: "assets/md.gif",
  ),
  Song(
    title: "Hanumanchalisa",
    artist: "Unknown",
    url: "assets/music/hanumanchalisa.mp3",
    coverImage: "assets/md.gif",
  ),
  Song(
    title: "Maahi Ve Full Video - Kal Ho Naa Ho Shah Rukh Khan Saif Ali Preity Udit Narayan Karan J",
    artist: "Unknown",
    url: "assets/music/Maahi Ve Full Video - Kal Ho Naa Ho Shah Rukh Khan Saif Ali Preity Udit Narayan Karan J.mp3", 
    coverImage: "assets/md.gif",
  ),
  Song(
    title: "Nashe Si Chadh Gayi",
    artist: "Unknown",
    url: "assets/music/Nashe Si Chadh Gayi.mp3",
    coverImage: "assets/md.gif",
  ),
  Song(
    title: "Pretty Woman Full Video - Kal Ho Naa Ho Shah Rukh Khan Preity Shankar Mahadevan Sel",
    artist: "Unknown",
    url: "assets/music/Pretty Woman Full Video - Kal Ho Naa Ho Shah Rukh Khan Preity Shankar Mahadevan SEL.mp3",     
    coverImage: "assets/md.gif",
  ),
  Song(
    title: "Shiv",
    artist: "Unknown",
    url: "assets/music/shiv.mp3",
    coverImage: "assets/md.gif",
  ),
  Song(
    title: "The Breakup Song",
    artist: "Unknown",
    url: "assets/music/The Breakup Song.mp3",
    coverImage: "assets/md.gif",
  ),
  Song(
    title: "Tumhiho",
    artist: "Unknown",
    url: "assets/music/tumhiho.mp3",
    coverImage: "assets/md.gif",
  ),
  Song(
    title: "You And Me",
    artist: "Unknown",
    url: "assets/music/You and Me.mp3",
    coverImage: "assets/md.gif",
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
