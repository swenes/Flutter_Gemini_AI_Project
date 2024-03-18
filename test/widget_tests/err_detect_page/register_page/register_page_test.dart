import 'package:err_detector_project/screens/login/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('RegisterPage UI Test', (WidgetTester tester) async {
    // Widget ağacını oluştur
    await tester.pumpWidget(const MaterialApp(home: RegisterPage()));

    // Kayıt sayfasının doğru oluşturulup oluşturulmadığını kontrol etmek için bazı widgetlerin var olup olmadığını test et
    expect(find.text('REGISTER'), findsOneWidget);
    expect(find.text('Name'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Confirm Password'), findsOneWidget);
    expect(find.text('Register'), findsOneWidget);

    // Örnek olarak butona tıklama simulasyonu yapabilirsiniz
    await tester.tap(find.text('Register'));
    await tester.pump();

    // Eğer hata almadıysam, sayfa ve widgetleriniz beklediğim gibi çalışıyor demektir.
  });
}
