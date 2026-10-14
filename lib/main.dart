// SPDX-FileCopyrightText: Copyright Logically Magic Inc. <hello@logicallymagic.com>
// SPDX-FileCopyrightText: Copyright Hamid Jahanzad <Hamid@Jahanzad.com>
// SPDX-FileCopyrightText: Copyright Contributors to the Bill8:Merchant
// SPDX-License-Identifier: Apache-2.0

// Bill8:Merchant — main entry point.
//
// Bootstrap flow (the platform app pattern, bill8 README.md §4):
// 1. App starts; calls GET /v1/app/runtime/context (routed through TLS).
// 2. TLS injects X-Sentin8-App-Id / X-Sentin8-Env-Id headers.
// 3. The runtime context carries the BFF domain + branding.
// 4. The dashboard pages proxy everything through BffApiClient →
//    Sentin8:BFF /proxy/{service}/... — the app NEVER calls a backend
//    service directly (tokens never reach the client).

import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:sentin8/sentin8.dart';
import 'pages/dashboard_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Semantics for e2e/Playwright ARIA access.
  SemanticsBinding.instance.ensureSemantics();
  runApp(const MerchantApp());
}

/// Root widget — the bootstrap loader resolves the runtime context,
/// then the dashboard mounts.
class MerchantApp extends StatelessWidget {
  const MerchantApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bill8 Merchant',
      debugShowCheckedModeBanner: false,
      theme: sentin8Theme(),
      home: const DashboardPage(),
    );
  }
}