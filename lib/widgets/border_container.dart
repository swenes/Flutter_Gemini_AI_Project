import 'package:err_detector_project/utils/constants.dart';
import 'package:flutter/material.dart';

class BorderContainer extends StatelessWidget {
  final String text;
  final double fontSize;
  const BorderContainer({
    super.key,
    required this.text,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      margin: const EdgeInsets.symmetric(horizontal: 40).copyWith(top: 20),
      decoration: BoxDecoration(
          border: Border.all(color: Constants.borderColor),
          borderRadius:
              BorderRadius.circular(20).copyWith(topLeft: Radius.zero)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text(
          text,
          style: TextStyle(
              color: Constants.mainFontColor,
              fontSize: fontSize,
              fontFamily: 'Cera Pro'),
        ),
      ),
    );
  }
}
