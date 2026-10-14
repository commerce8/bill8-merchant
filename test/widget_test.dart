// SPDX-FileCopyrightText: Copyright Logically Magic Inc. <hello@logicallymagic.com>
// SPDX-FileCopyrightText: Copyright Hamid Jahanzad <Hamid@Jahanzad.com>
// SPDX-FileCopyrightText: Copyright Contributors to the Bill8:Merchant
// SPDX-License-Identifier: Apache-2.0

// Merchant widget tests — the shell renders and the SDK theme applies.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sentin8/sentin8.dart';

void main() {
  testWidgets('GlassPanel renders child under the sentin8 theme',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: sentin8Theme(),
        home: const Scaffold(body: GlassPanel(child: Text('Test'))),
      ),
    );
    expect(find.text('Test'), findsOneWidget);
  });

  test('sentin8Theme builds a Material 3 theme', () {
    final theme = sentin8Theme();
    expect(theme.useMaterial3, isTrue);
  });
}