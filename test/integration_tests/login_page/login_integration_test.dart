import 'package:err_detector_project/screens/home_screen/home_page.dart';
import 'package:err_detector_project/screens/login/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Login Integration Test', (WidgetTester tester) async {
    // MaterialApp widget'ını oluştur
    await tester.pumpWidget(
      const MaterialApp(
        home: LoginPage(), // LoginPage'i ekleyin
      ),
    );
    // Kullanıcı adı ve şifre alanlarını doldur
    await tester.enterText(
        find.byKey(const Key('email')), 'enes.aydogdu2488@gmail.com');
    await tester.enterText(find.byKey(const Key('password')), 'Swenes1.*');

    // Giriş yap butonuna tıkla
    await tester.tap(find.text('Login'));

    // Butona tıklanmasını bekleyin
    await tester.pump();

    // Yönlendirilen sayfanın HomePage olup olmadığını kontrol et
    expect(find.byType(HomePage), findsNothing);
  });
}
