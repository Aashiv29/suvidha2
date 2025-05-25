import os

music_dir = 'assets/music'
songs = os.listdir(music_dir)

for filename in songs:
    name = os.path.splitext(filename)[0]
    print(f'''  Song(
    title: "{name.replace("_", " ").title()}",
    artist: "Unknown",
    url: "assets/music/{filename}",
    coverImage: "assets/default_cover.jpg",
  ),''')
