import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:err_detector_project/screens/gemini_chat_bot_screen/gemini_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('GeminiPage UI Test', (WidgetTester tester) async {
    // Widget ağacını oluştur
    await tester.pumpWidget(const MaterialApp(home: GeminiPage()));

    // GeminiPage'in doğru oluşturulup oluşturulmadığını kontrol etmek için bazı widgetlerin var olup olmadığını test et
    expect(find.text('Gemini Chat Bot'), findsOneWidget); // Sayfanın başlığı
    expect(find.byIcon(Icons.arrow_back_ios_new),
        findsOneWidget); // Geri gitme butonu
    expect(find.byType(DashChat), findsOneWidget); // DashChat widget'ı

    expect(find.byKey(const ValueKey('start')),
        findsOneWidget); // başlamak için mesaj gönder continerinin keyi = start.

    expect(find.byType(Image),
        findsOneWidget); // chat image yüklendi mi yüklenmedi mi onu test ediyoruz.
    expect(find.text('Başlamak için bir mesaj gönder!'), findsOneWidget);

    // Örnek olarak butona tıklama simulasyonu yapabilirsiniz
    // Örneğin, geri gitme butonuna tıklayarak sayfanın kapatılmasını test edebilirsiniz
    await tester.tap(find.byIcon(Icons.arrow_back_ios_new));
    await tester.pump();

    // Eğer geri gitme butonuna tıklandıktan sonra beklenen davranışların oluşup oluşmadığını kontrol etmek istiyorsanız, buraya ilgili expect fonksiyonlarını ekleyebilirsiniz
  });
}
