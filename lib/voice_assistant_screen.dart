import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VoiceAssistant extends StatefulWidget {
  const VoiceAssistant({super.key});

  @override
  VoiceAssistantState createState() => VoiceAssistantState();
}

class VoiceAssistantState extends State<VoiceAssistant> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _command = "";
  FlutterTts _tts = FlutterTts();

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _greetUser();
  }

  Future<void> _greetUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      String name = userDoc["name"] ?? "User";
      String greeting = _getGreeting();
      await _tts.speak("$greeting, $name. How can I help you?");
    }
  }

  String _getGreeting() {
    int hour = DateTime.now().hour;
    if (hour < 12) {
      return "Good morning";
    } else if (hour < 18) {
      return "Good afternoon";
    } else {
      return "Good evening";
    }
  }

  void _startListening() async {
    bool available = await _speech.initialize(
      onStatus: (status) {
        print("Speech Status: $status");
        if (status == "notListening") {
          setState(() => _isListening = false);
        }
      },
      onError: (error) {
        print("Speech Error: $error");
        setState(() => _isListening = false);
        _tts.speak("An error occurred with speech recognition.");
      },
    );

    if (available) {
      setState(() => _isListening = true);
      _speech.listen(
        onResult: (result) {
          if (result.finalResult) {
            setState(() {
              _command = result.recognizedWords;
            });
            _processCommand(_command);
          }
        },
        listenFor: Duration(seconds: 15), // Increased listening time
        pauseFor: Duration(seconds: 5),
        localeId: "en_US",
        cancelOnError: false,
        partialResults: true,
      );
    } else {
      _tts.speak("Microphone is not available.");
    }
  }

  void _stopListening() {
    setState(() => _isListening = false);
    _speech.stop();
  }

  void _processCommand(String command) {
    if (command.isEmpty) {
      return;
    }

    String lowerCommand = command.toLowerCase();

    if (lowerCommand.contains("open sos")) {
      if (mounted) Navigator.pushNamed(context, "/sos");
    } else if (lowerCommand.contains("open medicine reminder")) {
      if (mounted) Navigator.pushNamed(context, "/medicineReminder");
    } else if (lowerCommand.contains("open games")) {
      if (mounted) Navigator.pushNamed(context, "/games");
    } else if (lowerCommand.contains("open music player")) {
      if (mounted) Navigator.pushNamed(context, "/musicPlayer");
    } else if (lowerCommand.contains("add reminder")) {
      _addReminder(lowerCommand);
    } else {
      _tts.speak("Sorry, I didn't understand that command.");
    }
  }

  void _addReminder(String command) async {
    String task = command.replaceAll("add reminder", "").trim();
    if (task.isNotEmpty) {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        try {
          await FirebaseFirestore.instance.collection('reminders').add({
            'userId': user.uid,
            'task': task,
            'timestamp': Timestamp.now(),
          });
          _tts.speak("Reminder added successfully.");
          print("🔥 Reminder added: $task");
        } catch (e) {
          print("❌ Error adding reminder: $e");
          _tts.speak("Failed to add the reminder.");
        }
      } else {
        _tts.speak("User not logged in.");
      }
    } else {
      _tts.speak("Please specify the reminder.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _isListening ? _stopListening : _startListening,
        child: Icon(_isListening ? Icons.mic : Icons.mic_none),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Say a command...",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              _command,
              style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}
