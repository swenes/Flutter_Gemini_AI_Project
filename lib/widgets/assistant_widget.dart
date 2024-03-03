import 'package:err_detector_project/utils/constants.dart';
import 'package:flutter/material.dart';

class AssistantWidget extends StatelessWidget {
  final String imagePath;
  const AssistantWidget({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Container(
            height: 120,
            width: 120,
            margin: const EdgeInsets.only(top: 6),
            decoration: const BoxDecoration(
                color: Constants.assistantCircleColor, shape: BoxShape.circle),
          ),
        ),
        Container(
          height: 125,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(image: AssetImage(imagePath))),
        )
      ],
    );
  }
}
