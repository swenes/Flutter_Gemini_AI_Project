import 'package:err_detector_project/screens/err_detect_page.dart';
import 'package:err_detector_project/screens/gemini_page.dart';
import 'package:err_detector_project/screens/home_page.dart';
import 'package:err_detector_project/screens/object_recognition_page.dart';
import 'package:err_detector_project/screens/speech_to_text_page.dart';
import 'package:err_detector_project/utils/constants.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Enes',
      theme: ThemeData.light(useMaterial3: true).copyWith(
          appBarTheme: const AppBarTheme(backgroundColor: Constants.whiteColor),
          scaffoldBackgroundColor: Constants.whiteColor),
      routes: {
        '/errPage': (context) => const ErrDetectorPage(),
        '/ocrPage': (context) => const OcrPage2(),
        '/geminiPage': (context) => const GeminiPage(),
        '/speechPage': (context) => const SpeechToTextPage(),
      },
      home: const HomePage(),
    );
  }
}
