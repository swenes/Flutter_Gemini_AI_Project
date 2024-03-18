import 'package:err_detector_project/screens/login/screens/login_screen.dart';
import 'package:err_detector_project/screens/login/values/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Kayıt Şifresi Özel Karakterler İçermeli',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: LoginPage(),
      ),
    );

    // Boş bir şifre girildiğinde doğrulama hatası oluşmalı
    await tester.tap(find.byKey(const Key('password'))); // Şifre alanına tıkla
    await tester.pump(); // Yeniden oluşturulmayı bekleyin

    expect(find.text(AppStrings.password), findsOneWidget);

    // Geçersiz bir şifre girildiğinde doğrulama hatası oluşmalı
    await tester.enterText(find.byKey(const Key('password')), 'short');
    await tester.pump();
    expect(find.text(AppStrings.invalidPassword), findsOneWidget);

    // Geçerli bir şifre girildiğinde doğrulama hatası olmamalı
    await tester.enterText(
        find.byKey(const Key('password')), 'validPassword123.*');
    await tester.pump();
    expect(find.text(AppStrings.invalidPassword), findsNothing);
  });
}
