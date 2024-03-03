import 'dart:convert';
import 'package:err_detector_project/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:http/http.dart' as http;

class GeminiPage extends StatefulWidget {
  final String? parameter;
  const GeminiPage({super.key, this.parameter});

  @override
  State<GeminiPage> createState() => _GeminiPageState();
}

class _GeminiPageState extends State<GeminiPage> {
  final url =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=${Constants.GEMINIAPIKEY}';
  final header = {'Content-Type': 'application/json'};
  String apiKey = 'AIzaSyDBHpczB-UMepnPaVLiVl7kSZcubei4BKs';
  ChatUser mySelf = ChatUser(id: '1', firstName: 'Enes');
  ChatUser bot = ChatUser(
      id: '2', firstName: 'Gemini', profileImage: 'assets/images/gemini.jpg');
  List<ChatMessage> allMessages = [];
  List<ChatUser> typing = [];

  @override
  void initState() {
    super.initState();

    if (widget.parameter?.isNotEmpty == true) {
      Future.delayed(Duration.zero, () async {
        String data = await DefaultAssetBundle.of(context)
            .loadString('assets/errorPrompts/errPrompts.json');
        Map<String, dynamic> jsonData = json.decode(data);

        String errorCode = widget.parameter!;
        String prompt = jsonData.containsKey(errorCode)
            ? jsonData[errorCode]
            : 'Bilinmeyen Hata Kodu';

        getData(
            ChatMessage(text: prompt, user: mySelf, createdAt: DateTime.now()));
      });
    }
  }

  getData(ChatMessage m) async {
    typing.add(bot);
    allMessages.insert(0, m);

    setState(() {});
    var data = {
      "contents": [
        {
          "parts": [
            {"text": m.text}
          ]
        }
      ]
    };
    final response = await http.post(Uri.parse(url),
        headers: header, body: jsonEncode(data));

    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      debugPrint(result.toString());
      if (result != null &&
          result['candidates'] != null &&
          result['candidates'].isNotEmpty &&
          result['candidates'][0]['content'] != null &&
          result['candidates'][0]['content']['parts'] != null &&
          result['candidates'][0]['content']['parts'].isNotEmpty &&
          result['candidates'][0]['content']['parts'][0]['text'] != null) {
        ChatMessage botMessage = ChatMessage(
          text: result['candidates'][0]['content']['parts'][0]['text'],
          user: bot,
          createdAt: DateTime.now(),
        );
        allMessages.insert(0, botMessage);
      } else {
        ChatMessage botMessage = ChatMessage(
          text: 'Tam olarak anlayamadım. Biraz daha detaylandırabilir misin ?',
          user: bot,
          createdAt: DateTime.now(),
        );
        allMessages.insert(0, botMessage);
      }
    } else {
      return 'Üzgünüm, beklenmeyen bir hata oluştu';
    }
    typing.remove(bot);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.parameter != null ? "Arçelik Destek" : "Gemini Chat Bot",
          style: const TextStyle(
              fontFamily: 'Cera-Pro', fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: Stack(
        children: [
          DashChat(
              currentUser: mySelf,
              typingUsers: typing,
              onSend: (ChatMessage m) {
                getData(m);
              },
              messages: allMessages),
          if (allMessages
              .isEmpty) // Eğer mesajlar listesi boşsa, bir dekorasyon göster
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 120,
                    width: 280,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black, // Çizgi rengi
                        width: 0.2, // Çizgi kalınlığı
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image.asset(
                      'assets/images/chat.png', // İstediğiniz bir resmin yolunu ekleyin
                    ),
                  ),
                  const SizedBox(height: 16), // Biraz boşluk ekleyelim
                  const Text(
                    'Başlamak için bir mesaj gönder!',
                    style: TextStyle(
                        fontFamily: 'Cera-Pro',
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
        ],
      ),
    );
  }
}
