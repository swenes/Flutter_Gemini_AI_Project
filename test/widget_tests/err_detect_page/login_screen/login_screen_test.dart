import 'package:err_detector_project/screens/login/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('LoginPage UI Test', (WidgetTester tester) async {
    // Widget ağacını oluştur
    await tester.pumpWidget(const MaterialApp(home: LoginPage()));

    // Giriş sayfasının doğru oluşturulup oluşturulmadığını kontrol etmek için bazı widgetlerin var olup olmadığını test et
    expect(find.text('Sign in to your Account'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);

    // Örnek olarak butona tıklama simulasyonu yapabilirsiniz
    await tester.tap(find.text('Login'));
    await tester.pump();

    // Eğer hata almadıysam, sayfa ve widgetleriniz beklediğim gibi çalışıyor demektir.
  });
}
