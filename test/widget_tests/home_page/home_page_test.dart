import 'package:err_detector_project/screens/home_screen/home_page.dart';
import 'package:err_detector_project/utils/constants.dart';
import 'package:err_detector_project/widgets/assistant_widget.dart';
import 'package:err_detector_project/widgets/border_container.dart';
import 'package:err_detector_project/widgets/suggestion_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('HomePage UI Test', (WidgetTester tester) async {
    // HomePage widget'ını oluştur
    await tester.pumpWidget(MaterialApp(home: HomePage()));

    // HomePage'in doğru oluşturulup oluşturulmadığını kontrol etmek için bazı widgetlerin var olup olmadığını test et
    expect(find.text('Asistan'), findsOneWidget); // AppBar'ın başlığı
    expect(find.byIcon(Icons.menu), findsOneWidget); // Drawer'ı açan icon

    // Drawer'ın doğru oluşturulup oluşturulmadığını kontrol etmek için bazı widgetlerin var olup olmadığını test et
    await tester.tap(find.byIcon(Icons.menu)); // Drawer'ı aç
    await tester.pump(); // Drawer'ın açılmasını bekle
    expect(find.text('Enes Aydoğdu'),
        findsOneWidget); // Drawer içindeki öğelerden biri
    expect(find.text('LinkedIn'),
        findsOneWidget); // Drawer içindeki öğelerden biri

    // HomePage'in içeriğini kontrol etmek için bazı widgetlerin var olup olmadığını test et
    expect(find.byType(AssistantWidget), findsOneWidget); // AssistantWidget
    expect(find.byType(BorderContainer), findsOneWidget); // BorderContainer
    expect(find.byType(SuggestionTextWidget),
        findsOneWidget); // SuggestionTextWidget

    // Features listesini kontrol etmek için bazı widgetlerin var olup olmadığını test et
    expect(find.text(Constants.firstBoxHeaderText),
        findsOneWidget); // Öneri kutusu 1 başlık
    expect(find.text(Constants.firstBoxText),
        findsOneWidget); // Öneri kutusu 1 açıklama
    expect(find.text(Constants.secondBoxHeaderText),
        findsOneWidget); // Öneri kutusu 2 başlık
    expect(find.text(Constants.secondBoxText),
        findsOneWidget); // Öneri kutusu 2 açıklama
    expect(find.text(Constants.thirdBoxHeaderText),
        findsOneWidget); // Öneri kutusu 3 başlık
    expect(find.text(Constants.thirdBoxText),
        findsOneWidget); // Öneri kutusu 3 açıklama
    expect(find.text(Constants.fourthBoxHeaderText),
        findsOneWidget); // Öneri kutusu 4 başlık
    expect(find.text(Constants.fourthtBoxText),
        findsOneWidget); // Öneri kutusu 4 açıklama
  });
}
