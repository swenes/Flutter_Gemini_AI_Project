// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechToTextPage extends StatefulWidget {
  const SpeechToTextPage({super.key});

  @override
  _SpeechToTextPageState createState() => _SpeechToTextPageState();
}

class _SpeechToTextPageState extends State<SpeechToTextPage> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = '';

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (status) {
          debugPrint('onStatus: $status');
        },
        onError: (errorNotification) {
          debugPrint('onError: $errorNotification');
        },
      );

      if (available) {
        setState(() {
          _isListening = true;
          _text = 'Dinleniyor...';
        });

        _speech.listen(
          onResult: (result) {
            setState(() {
              _text = result.recognizedWords;
            });
          },
        );
      }
    } else {
      setState(() {
        _isListening = false;
        _text = '';
      });
      _speech.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Hızlı Not Al',
            style:
                TextStyle(fontFamily: 'Cera-Pro', fontWeight: FontWeight.w500)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                _text,
                style: const TextStyle(fontSize: 18.0),
              ),
            ),
            ElevatedButton(
              onPressed: _listen,
              child: Text(_isListening ? 'Dinleme Durdur' : 'Dinlemeye Başla'),
            ),
          ],
        ),
      ),
    );
  }
}
