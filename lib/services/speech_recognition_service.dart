import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechRecognitionService {
  final stt.SpeechToText _speech = stt.SpeechToText();

  Future<bool> initialize() async {
    return await _speech.initialize();
  }

  void startListening(Function(String) onResult) {
    _speech.listen(
      onResult: (result) {
        if (result.hasConfidenceRating && result.confidence > 0) {
          onResult(result.recognizedWords);
        }
      },
      listenFor: Duration(seconds: 10),
      pauseFor: Duration(seconds: 3),
      partialResults: true,
    );
  }

  void stopListening() {
    _speech.stop();
  }
}