import 'package:flutter/material.dart';
// import 'package:suvidha_sathi/music_home_screen.dart';
import 'package:suvidha_sathi/photo_feature.dart';
import 'package:suvidha_sathi/voice_assistant_screen.dart';
import 'sos_page.dart';
import 'medicine_reminder.dart';
import 'game_selection.dart';
import 'login.dart';
import 'contact_us.dart';
import 'taskManager.dart';
import 'suvidhasathimusic.dart';
// import 'music_search_screen.dart';
// import 'music_player_screen.dart';
// import 'api_service.dart';
// import 'song_model.dart';
// import 'home_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade100,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: CircleAvatar(
                      radius: 80,
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage('assets/logo2.png'),
                    ),
                  ),
                  Text(
                    'Welcome to Suvidha Saathi',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Making life easier for you',
                    style: TextStyle(fontSize: 18, color: Colors.black54),
                  ),
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: GridView.count(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      childAspectRatio: 1.2,
                      children: [
                        _buildFeatureButton(
                          context, 'SOS', Colors.red, Icons.warning_rounded,
                          () => Navigator.push(context, MaterialPageRoute(builder: (context) => SOSButton())),
                        ),
                        _buildFeatureButton(
                          context, 'Medicine', Colors.green, Icons.medical_services,
                          () => Navigator.push(context, MaterialPageRoute(builder: (context) => MedicineReminder())),
                        ),
                        _buildFeatureButton(
                          context, 'Games', Colors.blue, Icons.videogame_asset,
                          () => Navigator.push(context, MaterialPageRoute(builder: (context) => GameSelectionPage())),
                        ),
                        _buildFeatureButton(
                          context, 'Voice', Colors.orange, Icons.mic,
                          () => Navigator.push(context, MaterialPageRoute(builder: (context) => VoiceAssistant())),
                        ),
                        _buildFeatureButton(
                          context, 'Music', Colors.purple, Icons.photo,
                          () => Navigator.push(context, MaterialPageRoute(builder: (context) => SuvidhaSathiMusicApp())),
                        ),
                        _buildFeatureButton(
                          context, 'Photos', Colors.yellow.shade700, Icons.photo,
                          () => Navigator.push(context, MaterialPageRoute(builder: (context) => PhotoFeatureApp())),
                        ),
                        _buildFeatureButton(
                          context, 'ToDo', Colors.pink, Icons.photo,
                          () => Navigator.push(context, MaterialPageRoute(builder: (context) => TaskManager())),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'Contact') {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => ContactUsPage()),
                    );
                  } else if (value == 'Logout') {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'Contact',
                    child: Text('Contact the Team'),
                  ),
                  PopupMenuItem(
                    value: 'Logout',
                    child: Text('Logout'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureButton(BuildContext context, String title, Color color, IconData icon, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: Colors.white),
          SizedBox(height: 5),
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ],
      ),
    );
  }
}