import 'package:flutter_tts/flutter_tts.dart';

class TtsService {
  final FlutterTts flutterTts = FlutterTts();
  List<String> voices = [
    "ru-RU-Standard-A", // Женский голос
    "ru-RU-Standard-B", // Мужской голос
    "ru-RU-Wavenet-C",  // Другой женский голос
  ];
  double speechRate = 0.5; // Скорость речи по умолчанию
  double pitch = 1.0; // Тон голоса по умолчанию

  // Инициализация TTS
  Future<void> initTts() async {
    await flutterTts.setLanguage("ru-RU"); // Устанавливаем русский язык
    await flutterTts.setPitch(pitch); // Настройка тона голоса
    await flutterTts.setSpeechRate(speechRate); // Скорость речи (0.1 - медленно, 1.0 - нормально)
  }

  // Синтез речи
  Future<void> speak(String text) async {
    await flutterTts.speak(text);
  }

  // Остановка речи
  Future<void> stop() async {
    await flutterTts.stop();
  }

  // Установка голоса
  Future<void> setVoice(String voice) async {
    await flutterTts.setVoice({"name": voice});
  }

  // Установка скорости речи
  Future<void> setSpeechRate(double rate) async {
    speechRate = rate;
    await flutterTts.setSpeechRate(rate);
  }

  // Установка тона голоса
  Future<void> setPitch(double newPitch) async {
    pitch = newPitch;
    await flutterTts.setPitch(newPitch);
  }

  // Сохранение аудио в файл
  Future<void> saveToFile(String text, String filePath) async {
    await flutterTts.synthesizeToFile(text, filePath);
  }
}