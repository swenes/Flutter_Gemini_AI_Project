import 'package:err_detector_project/screens/login/screens/login_screen.dart';
import 'package:err_detector_project/screens/login/values/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Email validation test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: LoginPage(),
      ),
    );

    // Boş bir e-posta girildiğinde doğrulama hatası oluşmalı
    await tester.tap(find.byKey(const Key('email'))); // E-posta alanına tıkla
    await tester.pump(); // Yeniden oluşturulmayı bekleyin

    expect(find.text(AppStrings.email), findsOneWidget);

    // Geçersiz bir e-posta girildiğinde doğrulama hatası oluşmalı
    await tester.enterText(find.byKey(const Key('email')), 'invalidEmail');
    await tester.pump();
    expect(find.text(AppStrings.invalidEmailAddress), findsOneWidget);

    // Geçerli bir e-posta girildiğinde doğrulama hatası olmamalı
    await tester.enterText(find.byKey(const Key('email')), 'valid@email.com');
    await tester.pump();
    expect(find.text(AppStrings.invalidEmailAddress), findsNothing);
  });
}
