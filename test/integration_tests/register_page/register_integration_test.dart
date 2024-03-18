import 'package:err_detector_project/screens/login/screens/login_screen.dart';
import 'package:err_detector_project/screens/login/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Login Integration Test', (WidgetTester tester) async {
    // MaterialApp widget'ını oluştur
    await tester.pumpWidget(
      const MaterialApp(
        home: RegisterPage(), // LoginPage'i ekleyin
      ),
    );
    // Kullanıcı adı ve şifre alanlarını doldur
    await tester.enterText(find.byKey(const Key('name')), 'Enes Aydoğdu');
    await tester.enterText(
        find.byKey(const Key('email')), 'enes_aydogdu2001@hotmail.com');
    await tester.enterText(find.byKey(const Key('password')), 'Swenes1.*');

    // Kayıt ol butonuna tıkla
    await tester.tap(find.text('Register'));

    // Butona tıklanmasını bekleyin
    await tester.pump();

    // Yönlendirilen sayfanın HomePage olup olmadığını kontrol et
    expect(find.byType(LoginPage), findsNothing);
  });
}
