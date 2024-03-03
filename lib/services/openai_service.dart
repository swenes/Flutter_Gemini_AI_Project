import 'dart:convert';

import 'package:err_detector_project/utils/secrets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OpenAIService {
  final List<Map<String, String>> messages = [];

  Future<String> isArtPromptAPI(String prompt) async {
    try {
      final response = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $openAIAPIKey',
        },
        body: jsonEncode(
          {
            "model": "gpt-3.5-turbo",
            "messages": [
              {
                'role': 'user',
                'content':
                    'Does this message want to generate an AI Picture, image art or anything similar? $prompt. Simply answer with a yes or no. '
              }
            ]
          },
        ),
      );
      debugPrint(response.body);

      if (response.statusCode == 200) {
        String content =
            jsonDecode(response.body)['choices'][0]['message']['content'];
        content = content.trim();

        switch (content) {
          case 'Yes':
          case 'yes':
          case 'Yes.':
          case 'yes.':
          case 'YES':
          case 'YES.':
            final res = await chatGPTAPI(prompt);
            return res;

          default:
            final res = dellEtAPI(prompt);
            return res;
        }
      } else {
        return 'An internal error occured.';
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> chatGPTAPI(String prompt) async {
    messages.add({'role': 'user', 'content': prompt});

    try {
      final response = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $openAIAPIKey',
        },
        body: jsonEncode(
          {
            "model": "gpt-3.5-turbo",
            "messages": messages,
          },
        ),
      );
      debugPrint(response.body); // burayı sileceksin testten sonra

      if (response.statusCode == 200) {
        String content =
            jsonDecode(response.body)['choices'][0]['message']['content'];
        content = content.trim();

        messages.add(
          {
            'role': 'assistant',
            'content': content,
          },
        );
        return content;
      } else {
        return 'An internal error occured.';
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> dellEtAPI(String prompt) async {
    return 'Dell-E';
  }
}
