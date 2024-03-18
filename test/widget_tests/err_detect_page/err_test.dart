import 'dart:io';

import 'package:err_detector_project/widgets/selected_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:err_detector_project/screens/err_screen/err_detect_page.dart';

void main() {
  testWidgets('Seçilen görüntü uygulamada görüntülenmeli',
      (WidgetTester tester) async {
    // Uygulamayı başlat
    await tester.pumpWidget(const MaterialApp(
      home: ErrDetectorPage(),
    ));

    // FloatingActionButton'a basarak galeriden bir görüntü seçme işlemini simüle ediyorum.
    await tester.tap(find.byType(FloatingActionButton));

    // ModalBottomSheet'in açılmasını bekle
    await tester.pumpAndSettle();

    // Galeri seçeneğine tıkla
    await tester.tap(find.text('Galeri'));
    // Görüntünün yüklenmesini bekle
    await tester.pumpAndSettle();
  });

  testWidgets('FloatingActionButton ile galeriden görüntü seçilebilmeli',
      (WidgetTester tester) async {
    // Uygulamayı başlat
    await tester.pumpWidget(const MaterialApp(
      home: ErrDetectorPage(),
    ));

    // FloatingActionButton'a bas
    await tester.tap(find.byType(FloatingActionButton));

    // ModalBottomSheet'in açılmasını bekle
    await tester.pumpAndSettle();

    // Galeri seçeneğini bul ve tıkla
    final galleryOption = find.text('Galeri');
    await tester.tap(galleryOption);

    // Galeri seçeneğinin tıklandığını kontrol etmek için küçük bir delay.
    await tester.pumpAndSettle();
  });

  testWidgets('Yönlendirme doğru olmalı ve seçilen fotoğraf görüntülenebilmeli',
      (WidgetTester tester) async {
    // Örnek görüntü dosyası
    final File selectedImage = File(
        r"C:\src\Flutter Projects\err_detector_project\assets\test_images\test.png");

    // Uygulamayı başlat
    await tester.pumpWidget(const MaterialApp(
      home: ErrDetectorPage(),
    ));

    // Seçilen görüntüyü widget'a ver
    await tester.pumpWidget(selectedImageWidget(selectedImage));

    // Seçilen görüntünün uygulamada görüntülenip görüntülenmediğini kontrol et
    expect(find.byType(Image), findsOneWidget);
  });
}
