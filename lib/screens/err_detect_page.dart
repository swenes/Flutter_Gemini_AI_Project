// ignore_for_file: use_build_context_synchronously
import 'dart:io';
import 'package:err_detector_project/screens/gemini_page.dart';
import 'package:err_detector_project/utils/constants.dart';
import 'package:err_detector_project/widgets/assistant_widget.dart';
import 'package:err_detector_project/widgets/border_container.dart';
import 'package:err_detector_project/widgets/selected_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

class ErrDetectorPage extends StatefulWidget {
  const ErrDetectorPage({super.key});

  @override
  State<ErrDetectorPage> createState() => _ErrDetectorPageState();
}

class _ErrDetectorPageState extends State<ErrDetectorPage> {
  File? selectedMedia;
  static String? goToGeminiParameter;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ERR Code Yakalama",
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
              imagePath: 'assets/images/arcelik.png',
            ),
            const BorderContainer(
              text: 'Merak ettiğin hata kodunu içeren fotoğrafı galerinden seç',
              fontSize: 18,
            ),
            const SizedBox(
              height: 30,
            ),
            selectedImageWidget(selectedMedia),
            extractedTextWidget(),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
            ),
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

  Widget extractedTextWidget() {
    if (selectedMedia == null) {
      return const SizedBox();
    } else {
      return FutureBuilder(
        future: extractText(selectedMedia!),
        builder: (context, snapshot) {
          if (snapshot.data == Constants.nonDefinedERRtext) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(35),
                child: Text(
                  snapshot.data ?? "",
                  style: TextStyle(
                      color: Colors.red[700],
                      fontFamily: 'Cera-Pro',
                      fontSize: 15,
                      fontWeight: FontWeight.w700),
                ),
              ),
            );
          } else {
            return Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 40, bottom: 5),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Tespit Edilen Kod: ",
                          style: TextStyle(
                              color: Constants.mainFontColor,
                              fontFamily: 'Cera-Pro',
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          snapshot.data ?? "",
                          style: TextStyle(
                              color: Colors.red[700],
                              fontFamily: 'Cera-Pro',
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 30),
                        child: ElevatedButton(
                            style: const ButtonStyle(
                                foregroundColor: MaterialStatePropertyAll(
                                    Constants.whiteColor),
                                backgroundColor: MaterialStatePropertyAll(
                                    Color.fromARGB(255, 2, 18, 70))),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => GeminiPage(
                                      parameter: goToGeminiParameter),
                                ),
                              );
                            },
                            child: const Text(
                                'Hata hakkında daha fazla bilgi edinin !'))),
                  ],
                ),
              ),
            );
          }
        },
      );
    }
  }

  Future<String?> extractText(File file) async {
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final InputImage inputImage = InputImage.fromFile(file);
    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);
    String text = recognizedText.text;
    String actualText = cleanText(text);
    textRecognizer.close();
    debugPrint("Tespit edilen metin: $actualText");
    if (actualText.contains('Err')) {
      goToGeminiParameter = 'Err';
      return goToGeminiParameter;
    } else if (actualText.contains('E01')) {
      goToGeminiParameter = 'E01';
      return goToGeminiParameter;
    } else if (actualText.contains('E02')) {
      goToGeminiParameter = 'E02';
      return goToGeminiParameter;
    } else if (actualText.contains('E03')) {
      goToGeminiParameter = 'E03';
      return goToGeminiParameter;
    } else if (actualText.contains('E04')) {
      goToGeminiParameter = 'E04';
      return goToGeminiParameter;
    } else if (actualText.contains('E05')) {
      goToGeminiParameter = 'E05';
      return goToGeminiParameter;
    } else if (actualText.contains('E06')) {
      goToGeminiParameter = 'E06';
      return goToGeminiParameter;
    } else if (actualText.contains('E07')) {
      goToGeminiParameter = 'E07';
      return goToGeminiParameter;
    } else {
      return Constants.nonDefinedERRtext;
    }
  }

  String cleanText(String inputText) {
    // Alt alta inmiş satırları temizle
    String cleanedText = inputText.replaceAll(RegExp(r"\n+"), " ");

    // Birden fazla boşlukları tek bir boşlukla değiştir
    cleanedText = cleanedText.replaceAll(RegExp(r"\s+"), " ");

    // İlk ve sonundaki boşlukları kaldır
    cleanedText = cleanedText.trim();

    return cleanedText;
  }
}
