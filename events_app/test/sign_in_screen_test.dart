import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:events_app/presentation/screens/sign_in_screen.dart'; // Adjust this import based on your project structure

void main() {
  group('SignInScreen', () {
    testWidgets('buildTextField creates TextFormField',
        (WidgetTester tester) async {
      // Build the widget
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: buildTextField(
              TextEditingController(), 'Email', 'Enter your email'),
        ),
      ));

      // Verify TextFormField is present
      expect(find.byType(TextFormField), findsOneWidget);
    });
  });
}
