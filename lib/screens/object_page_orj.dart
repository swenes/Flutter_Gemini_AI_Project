// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:err_detector_project/widgets/assistant_widget.dart';
import 'package:err_detector_project/widgets/border_container.dart';
import 'package:err_detector_project/widgets/selected_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class OcrPage extends StatefulWidget {
  const OcrPage({super.key});

  @override
  State<OcrPage> createState() => _OcrPageState();
}

class _OcrPageState extends State<OcrPage> {
  File? selectedMedia;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nesne Tanıma",
            style:
                TextStyle(fontFamily: 'Cera-Pro', fontWeight: FontWeight.w500)),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const AssistantWidget(
              imagePath: 'assets/images/object.jpg',
            ),
            const BorderContainer(
              text: 'Bilgi sahibi olmak istediğin nesnenin fotoğrafını yükle.',
              fontSize: 18,
            ),
            const SizedBox(
              height: 30,
            ),
            selectedImageWidget(selectedMedia),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: const Icon(Icons.camera),
                    title: const Text('Kamera'),
                    onTap: () async {
                      final media = await ImagePicker()
                          .pickImage(source: ImageSource.camera);

                      if (media != null) {
                        var data = File(media.path);
                        setState(() {
                          selectedMedia = data;
                        });
                        Navigator.pop(context);
                      }
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.image),
                    title: const Text('Galeri'),
                    onTap: () async {
                      final media = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);

                      if (media != null) {
                        var data = File(media.path);
                        setState(() {
                          selectedMedia = data;
                        });
                        Navigator.pop(context);
                      }
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
