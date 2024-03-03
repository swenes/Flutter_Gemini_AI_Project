import 'package:err_detector_project/utils/constants.dart';
import 'package:flutter/material.dart';

class SuggestionTextWidget extends StatelessWidget {
  final String text;
  const SuggestionTextWidget({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.only(top: 10, left: 30, right: 30),
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(
            fontFamily: 'Cera Pro',
            color: Constants.mainFontColor,
            fontSize: 18,
            fontWeight: FontWeight.w700),
      ),
    );
  }
}
