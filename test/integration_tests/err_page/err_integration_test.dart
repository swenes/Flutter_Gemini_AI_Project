import 'package:err_detector_project/screens/err_screen/err_detect_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Test Gallery Selection and E07 Detection',
      (WidgetTester tester) async {
    // 1. Uygulamayı başlat
    await tester.pumpWidget(const MaterialApp(home: ErrDetectorPage()));

    // 2. FloatingActionButton'a tıkla (Galeri seçimi)
    final fab = find.byType(FloatingActionButton);
    await tester.tap(fab);
    await tester.pumpAndSettle(); // Animasyon ve işlemlerin bitmesini bekle

    // 3. Galeri seçeneğine tıkla
    final galleryListTile = find.text('Galeri');
    await tester.tap(galleryListTile);
    await tester.pumpAndSettle(); // Animasyon ve işlemlerin bitmesini bekle

    // 5. Hata kodu tespitini bekle
    await tester.pump(const Duration(seconds: 3)); // Yeterli bekleme süresi

    // 6. Ekranda "E07" yazısının olup olmadığını kontrol et
    final e07Text = find.text('E07');
    expect(e07Text, findsOneWidget);
  });

  // Testlerinizi buraya ekleyin
}
