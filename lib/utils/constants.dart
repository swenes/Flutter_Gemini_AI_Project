import 'package:flutter/material.dart';

class Constants {
  // ignore: constant_identifier_names
  static const GEMINIAPIKEY = "AIzaSyDBHpczB-UMepnPaVLiVl7kSZcubei4BKs";

  static const Color mainFontColor = Color.fromRGBO(19, 61, 95, 1);
  static const Color firstSuggestionBoxColor = Color.fromRGBO(45, 210, 243, 1);
  static const Color secondSuggestionBoxColor =
      Color.fromRGBO(255, 146, 119, 1);
  static const Color thirdSuggestionBoxColor = Color.fromRGBO(139, 243, 98, 1);
  static const Color fourthSuggestionBoxColor = Color.fromRGBO(24, 161, 132, 1);
  static const Color assistantCircleColor = Color.fromRGBO(209, 243, 249, 1);
  static const Color borderColor = Color.fromRGBO(200, 200, 200, 1);
  static const Color blackColor = Colors.black;
  static const Color whiteColor = Colors.white;
  static const String firstBoxHeaderText = 'ERR Code Yakalama';
  static const String secondBoxHeaderText = 'Nesne Tanıma';
  static const String thirdBoxHeaderText = 'Google Gemini';
  static const String fourthBoxHeaderText = 'Sesini Yazıya Dönüştür';

  static const String firstBoxText =
      'İstediğin hata kodunu içeren fotoğrafını yükleyerek karşılaştığın sorun hakkında bilgi alabilirsin.';
  static const String secondBoxText =
      'Ne olduğunu bilmediğin nesnenin fotoğrafını yükleyerek fikir sahibi olabilirsin.';
  static const String thirdBoxText =
      'Dilediğin zaman yapay zeka ile sohbet başlatabilirsin.';
  static const String fourthtBoxText =
      'Hızlı bir şekilde not almak istersen konuşarak da metnini oluşturabilirsin.';
  static const String nonDefinedERRtext =
      "Herhangi bir hata koduna rastlanmadı. Unutma, hata kodları genellikle E ile başlar ve devamında bir sayı gelir. Örnek olarak E07'yi düşünebilirsin.";

  static String? extractTest;
}
