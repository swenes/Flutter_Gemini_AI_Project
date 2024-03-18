import 'dart:io';

import 'package:err_detector_project/widgets/suggestion_text_widget.dart';
import 'package:flutter/material.dart';

Widget selectedImageWidget(File? file) {
  if (file == null) {
    return const Align(
      child: SuggestionTextWidget(
        text: "Henüz resim seçmediniz..",
      ),
    );
  } else {
    return Center(
        child: Image.file(
      file,
      width: 200,
      height: 200,
    ));
  }
}
