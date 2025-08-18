import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:samad_nursing_home/main.dart';

void main() {
  testWidgets('App launches successfully', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const SamadNursingHomeApp());

    // Verify that the landing page loads
    expect(find.text('Samad'), findsOneWidget);
    expect(find.text('Nursing Home'), findsOneWidget);
  });
}