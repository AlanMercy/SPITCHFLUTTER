import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'D.I.O. SPEACH',
      theme: ThemeData.dark(), // Тёмная тема
      home: const TtsScreen(),
    );
  }
}

class TtsScreen extends StatefulWidget {
  const TtsScreen({super.key});

  @override
  _TtsScreenState createState() => _TtsScreenState();
}

class _TtsScreenState extends State<TtsScreen> {
  final FlutterTts flutterTts = FlutterTts();
  final TextEditingController textController = TextEditingController();
  double speechRate = 0.5;
  double pitch = 1.0;

  @override
  void initState() {
    super.initState();
    initTts();
  }

  Future<void> initTts() async {
    await flutterTts.setLanguage("ru-RU");
    await flutterTts.setPitch(pitch);
    await flutterTts.setSpeechRate(speechRate);
  }

  Future<void> speak(String text) async {
    await flutterTts.speak(text);
  }

  Future<void> stop() async {
    await flutterTts.stop();
  }

  Future<void> saveToFile(String text) async {
    await flutterTts.synthesizeToFile(text, "sdcard/Download/audio.wav");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Чёрный фон
      appBar: AppBar(
        title: const Text(
          'D.I.O. SPEACH',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.grey[900], // Тёмный фон для AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: textController,
              decoration: const InputDecoration(
                labelText: 'Введите текст',
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
              style: const TextStyle(color: Colors.white),
              maxLines: 5,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const FaIcon(FontAwesomeIcons.play, color: Colors.white),
                  onPressed: () async {
                    String text = textController.text;
                    if (text.isNotEmpty) {
                      await speak(text);
                    }
                  },
                ),
                IconButton(
                  icon: const FaIcon(FontAwesomeIcons.stop, color: Colors.white),
                  onPressed: () async {
                    await stop();
                  },
                ),
                IconButton(
                  icon: const FaIcon(FontAwesomeIcons.save, color: Colors.white),
                  onPressed: () async {
                    String text = textController.text;
                    if (text.isNotEmpty) {
                      await saveToFile(text);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Аудио сохранено в файл')),
                      );
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'Скорость речи: ${speechRate.toStringAsFixed(2)}',
              style: const TextStyle(color: Colors.white),
            ),
            Slider(
              value: speechRate,
              min: 0.1,
              max: 1.0,
              onChanged: (double value) {
                setState(() {
                  speechRate = value;
                  flutterTts.setSpeechRate(value);
                });
              },
              activeColor: Colors.blue,
              inactiveColor: Colors.grey,
            ),
            const SizedBox(height: 20),
            Text(
              'Тон голоса: ${pitch.toStringAsFixed(2)}',
              style: const TextStyle(color: Colors.white),
            ),
            Slider(
              value: pitch,
              min: 0.5,
              max: 2.0,
              onChanged: (double value) {
                setState(() {
                  pitch = value;
                  flutterTts.setPitch(value);
                });
              },
              activeColor: Colors.blue,
              inactiveColor: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}