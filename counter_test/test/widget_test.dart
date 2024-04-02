// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:counter_test/main.dart';

void main() {
  // Widget Tests
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });

  testWidgets('_MyHomePageState has expected CINS467 text', (WidgetTester tester) async{
    // build the app
    await tester.pumpWidget(const MyApp());

    expect(find.text('CINS467 Hello World'), findsAtLeastNWidgets(1));
  });

  testWidgets('Counter text does not go below 0', (WidgetTester tester) async{
    await tester.pumpWidget(const MyApp());
    expect(find.text('0'), findsOneWidget); // verify start value
    // tap the Decrement button
    await tester.tap(find.text('Decrement'));
    await tester.pump();
    // value should not change (not decrementing below 0)
    expect(find.text('0'), findsOneWidget);
    expect(find.text('-1'), findsNothing);
  });

  testWidgets('Counter text gets decremented for positive values', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('0'), findsOneWidget);
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    expect(find.text('1'), findsOneWidget);
    await tester.tap(find.text('Decrement'));
    await tester.pump();
    expect(find.text('0'), findsOneWidget);
  });



  // Unit tests
  test('Counter value should be incremented', () {
    final counter = Counter();
    expect(counter.value, 0);
    counter.increment();
    expect(counter.value, 1);
  });

  test('Counter value should be decremented', () {
    final counter = Counter();
    expect(counter.value, 0);
    counter.decrement();
    expect(counter.value, -1);
  });
}
