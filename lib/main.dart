import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:provider/provider.dart';
// import 'package:just_audio_background/just_audio_background.dart';
// import 'package:provider/provider.dart'; // 👈 Add this
// import 'package:suvidha_sathi/music_home_screen.dart';
// import 'music_player_screen.dart';
import 'package:suvidha_sathi/taskManager.dart';
import 'firebase_options.dart';
import 'homepage.dart';
import 'sos_page.dart';
import 'medicine_reminder.dart';
import 'game_selection.dart';
// import 'music_provider.dart'; // 👈 Add this
import 'splash.dart';
import 'suvidhasathimusic.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print("🔥 Firebase Initialized Successfully");
  } catch (e) {
    print("❌ Firebase Initialization Error: $e");
  }

  // ✅ Wrap MyApp in MultiProvider
 runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Suvidha Sathi',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SplashScreen(),
      routes: {
        '/home': (context) => HomePage(),
        '/sos': (context) => SOSButton(),
        '/medicineReminder': (context) => MedicineReminder(),
        '/games': (context) => GameSelectionPage(),
        '/musicPlayer': (context) => SuvidhaSathiMusicApp(),
        '/taskManger': (context) => TaskManager(),
      },
    );
  }
}
