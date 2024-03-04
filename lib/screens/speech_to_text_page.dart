import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class Note {
  String text;
  DateTime timestamp;

  Note(this.text) : timestamp = DateTime.now();
}

class SpeechToTextPage extends StatefulWidget {
  const SpeechToTextPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SpeechToTextPageState createState() => _SpeechToTextPageState();
}

class _SpeechToTextPageState extends State<SpeechToTextPage> {
  TextEditingController noteNameController = TextEditingController();
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = '';
  // ignore: prefer_final_fields
  List<Note> _notes = [];
  bool _isFirstWord = true;

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
          _text = 'Şuan seni duyabiliyorum..';
          _isFirstWord = true;
        });

        _speech.listen(
          onResult: (result) {
            setState(() {
              if (_isFirstWord) {
                _text = result.recognizedWords;
                _isFirstWord = false;
              } else {
                _text += ' ${result.recognizedWords}';
              }
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

  void _showSaveNoteDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Notu Kaydet'),
          content: Column(
            children: [
              TextField(
                controller: noteNameController,
                decoration: const InputDecoration(labelText: 'Not Adı'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                if (noteNameController.text.isNotEmpty) {
                  _saveNote(noteNameController.text);
                  Navigator.pop(context);
                }
              },
              child: const Text('Kaydet'),
            ),
          ],
        );
      },
    );
  }

  void _saveNote(String noteName) {
    setState(() {
      _notes.add(Note(noteNameController.text));
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Not kaydedildi: $noteName'),
    ));
  }

  void _navigateToSavedNotesPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SavedNotesPage(notes: _notes),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Hızlı Not Al',
            style:
                TextStyle(fontFamily: 'Cera-Pro', fontWeight: FontWeight.w500)),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _showSaveNoteDialog,
          ),
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: _navigateToSavedNotesPage,
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          if (!_isListening && _text.isEmpty)
            Container(
              margin: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 0.4, color: Colors.blueGrey),
              ),
              padding: const EdgeInsets.all(16.0),
              child: const Text(
                'Sizi duyamadım. Sanırım henüz bir şey söylemediniz.',
                style: TextStyle(fontSize: 18.0),
                textAlign: TextAlign.center,
              ),
            ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.all(16.0),
            alignment: Alignment.center, // İçeriği ortalamak için
            child: Text(
              _text,
              style: const TextStyle(fontSize: 18.0),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _listen,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            child: Text(
              _isListening ? 'Dinleme Durdur' : 'Dinlemeye Başla',
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}

class SavedNotesPage extends StatelessWidget {
  final List<Note> notes;

  SavedNotesPage({required this.notes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kayıtlı Notlar'),
      ),
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 2,
            margin: const EdgeInsets.all(8),
            child: ListTile(
              title: Text(notes[index].text),
              subtitle: Text(
                'Kaydedilen Tarih: ${notes[index].timestamp}',
                style: const TextStyle(fontSize: 12),
              ),
            ),
          );
        },
      ),
    );
  }
}
