import '../services/text_to_speech_service.dart';
import 'package:flutter/material.dart';

class CommandHandler {
  final TextToSpeechService _ttsService = TextToSpeechService();

  void handleCommand(String command, BuildContext context) {
    if (command.toLowerCase().contains("open")) {
      String component = command.replaceFirst("open ", "").trim();
      _navigateTo(component, context);
    } else {
      _ttsService.speak("Sorry, I didn't understand that.");
    }
  }

  void _navigateTo(String component, BuildContext context) {
    switch (component.toLowerCase()) {
      case 'sos':
        Navigator.pushNamed(context, '/sos');
        break;
      case 'medicine reminder':
        Navigator.pushNamed(context, '/medicine_reminder');
        break;
      case 'games':
        Navigator.pushNamed(context, '/games');
        break;
      case 'music player':
        Navigator.pushNamed(context, '/music_player');
        break;
      case 'connect':
        Navigator.pushNamed(context, '/connect');
        break;
      default:
        _ttsService.speak("I couldn't find the $component section.");
    }
  }
}