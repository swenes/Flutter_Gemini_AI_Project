import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:err_detector_project/screens/login/components/app_text_form_field.dart';

//  Bu birim test, AppTextFormField bileşeninin validator alanının doğru şekilde çalışıp çalışmadığını kontrol eder.

// Test, önce AppTextFormField bileşenini ekrana yerleştirir (pumpWidget),
// ardından TextFormField widget'ını bulur (find.byType) ve bu widget'ın validator fonksiyonunu alarak test eder.

// Validator fonksiyonu, değer boşsa "Please enter a value" mesajı döndürmelidir.
// Bu nedenle, validator fonksiyonunu bir boş değerle çağırarak (.call('')) ve dönen sonucun beklendiği gibi "Please enter a value" olup olmadığını kontrol ediyoruz.

// Daha sonra, aynı validator fonksiyonunu bir değerle ('Test') çağırarak, bu sefer dönen sonucun null olup olmadığını kontrol ediyoruz.
// Çünkü bir değer verildiğinde doğru bir şekilde geçerli olmalı ve hiçbir hata mesajı döndürmemelidir.

// Bu test, AppTextFormField bileşeninin doğru şekilde çalışıp çalışmadığını doğrulamak için kullanılır.
// Eğer validator alanı hatalı bir şekilde ayarlanmışsa veya çalışmıyorsa, bu test hata verecek ve problemin çözülmesine yardımcı olacaktır.

void main() {
  testWidgets('Test AppTextFormField validator', (WidgetTester tester) async {
    // AppTextFormField widget'ini ekran üzerine yerleştir
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: AppTextFormField(
      labelText: 'Test Field',
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.text,
      controller: TextEditingController(),
      validator: (value) {
        return value!.isEmpty ? 'Bir validator girmeniz zorunludur !' : null;
      },
    ))));

    // TextFormField'i bul
    final finder = find.byType(TextFormField);

    // TextFormField bulundu mu kontrol et
    expect(finder, findsOneWidget);

    // TextFormField'in validator'unu al ve test et
    final formField = tester.widget<TextFormField>(finder);
    expect(
        formField.validator!.call(''), 'Bir validator girmeniz zorunludur !');
    expect(formField.validator!.call('Test'), isNull);
  });
}
