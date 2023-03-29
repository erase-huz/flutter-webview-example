// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nock/nock.dart';
import 'package:widget_test/snippet.dart';

void main() {
  setUpAll(nock.init);

  setUp(() {
    nock.cleanAll();
  });
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    nock('https://run.mocky.io')
        .get('/v3/49c23ebc-c107-4dae-b1c6-5d325b8f8b58')
      .reply(200, json.encode('{"id": "49c23ebc-c107-4dae-b1c6-5d325b8f8b58", "name": "Example campus" }'));    
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

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

class TestApp extends StatelessWidget {
  final Widget child;

  TestApp(this.child);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: child,
    );
  }
}

