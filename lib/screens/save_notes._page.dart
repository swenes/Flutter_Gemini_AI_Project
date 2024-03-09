import 'package:err_detector_project/screens/speech_to_text_page.dart';
import 'package:flutter/material.dart';

class SavedNotesPage extends StatelessWidget {
  final List<Note> notes;

  const SavedNotesPage({super.key, required this.notes});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
      ),
    );
  }
}
