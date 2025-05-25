import 'package:flutter/material.dart';
import '../services/speech_recognition_service.dart';
import '../services/command_handler.dart';

class VoiceAssistantController {
  final SpeechRecognitionService _speechService = SpeechRecognitionService();
  final CommandHandler _commandHandler = CommandHandler();

  void initializeVoiceAssistant(BuildContext context) async {
    bool available = await _speechService.initialize();
    if (available) {
      _speechService.startListening((text) {
        _commandHandler.handleCommand(text, context);
      });
    }
  }

  void stopVoiceAssistant() {
    _speechService.stopListening();
  }
}