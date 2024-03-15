import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _animation =
        Tween<double>(begin: 1.0, end: 0.0).animate(_animationController);

    // 3 saniye sonra animasyonu başlat
    Timer(
      const Duration(seconds: 3),
      () {
        _animationController.forward();
      },
    );

    // 4 saniye sonra splash ekranını kapat
    Timer(
      const Duration(seconds: 4),
      () {
        Navigator.pushNamed(context, "/loginPage");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FadeTransition(
            opacity: _animation,
            child: Image.asset("assets/images/logo.png"),
          ),
          const SizedBox(height: 20),
          FadeTransition(
            opacity: _animation,
            child: const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
