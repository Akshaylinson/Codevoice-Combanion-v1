import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:codevoice_vision/shared/widgets/status_badge.dart';

void main() {
  testWidgets('Status badge renders label', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: StatusBadge(label: 'Vision Ready'),
        ),
      ),
    );

    expect(find.text('Vision Ready'), findsOneWidget);
  });
}
