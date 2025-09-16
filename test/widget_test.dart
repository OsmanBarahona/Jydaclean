import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jydaclean/main.dart';

void main() {
  testWidgets('Login screen is displayed', (WidgetTester tester) async {
    // Build our app
    await tester.pumpWidget(MyApp());
    
    // Verify that the login screen is displayed
    expect(find.text('jydaclean'), findsOneWidget);
    expect(find.text('Ingresar'), findsOneWidget);
  });
}