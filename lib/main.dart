import 'package:err_detector_project/screens/err_detect_page.dart';
import 'package:err_detector_project/screens/gemini_page.dart';
import 'package:err_detector_project/screens/home_page.dart';
import 'package:err_detector_project/screens/login/routes.dart';
import 'package:err_detector_project/screens/login/screens/login_screen.dart';
import 'package:err_detector_project/screens/login/screens/register_screen.dart';
import 'package:err_detector_project/screens/login/utils/helpers/navigation_helper.dart';
import 'package:err_detector_project/screens/login/utils/helpers/snackbar_helper.dart';
import 'package:err_detector_project/screens/object_recognition_page.dart';
import 'package:err_detector_project/screens/speech_to_text_page.dart';
import 'package:err_detector_project/screens/splash_screen.dart';
import 'package:err_detector_project/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark),
  );

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) => runApp(const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: NavigationHelper.key,
      onGenerateRoute: Routes.generateRoute,
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: SnackbarHelper.key,
      title: 'Enes',
      theme: ThemeData.light(useMaterial3: true).copyWith(
          appBarTheme: const AppBarTheme(backgroundColor: Constants.whiteColor),
          scaffoldBackgroundColor: Constants.whiteColor),
      routes: {
        '/homePage': (context) => const HomePage(),
        '/errPage': (context) => const ErrDetectorPage(),
        '/ocrPage': (context) => const OcrPage(),
        '/geminiPage': (context) => const GeminiPage(),
        '/speechPage': (context) => const SpeechToTextPage(),
        '/loginPage': (context) => const LoginPage(),
        '/registerPage': (context) => const RegisterPage(),
      },
      home: const SplashScreen(),
    );
  }
}
