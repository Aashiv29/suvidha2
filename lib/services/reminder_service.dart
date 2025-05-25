import '../services/text_to_speech_service.dart';

class ReminderService {
  final TextToSpeechService _ttsService = TextToSpeechService();

  void addReminder(String reminder) {
    _ttsService.speak("Reminder added: $reminder");
  }

  void deleteReminder(String reminder) {
    _ttsService.speak("Reminder deleted: $reminder");
  }
}