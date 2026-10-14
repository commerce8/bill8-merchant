// SPDX-FileCopyrightText: Copyright Logically Magic Inc. <hello@logicallymagic.com>
// SPDX-FileCopyrightText: Copyright Hamid Jahanzad <Hamid@Jahanzad.com>
// SPDX-FileCopyrightText: Copyright Contributors to the Bill8:Merchant
// SPDX-License-Identifier: Apache-2.0

// Merchant dashboard — the home surface: balances, recent charges, and
// the navigation rail into payments/billing/payouts surfaces.
//
// All data flows through BffApiClient → Sentin8:BFF
// /proxy/ledger/..., /proxy/payments/... (the platform BFF pattern —
// tokens never reach the client; DESIGN.md of this app §2).

import 'package:flutter/material.dart';
import 'package:sentin8/sentin8.dart';

/// Dashboard home.
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  // The runtime context resolves from the app origin (TLS-injected
  // headers) — the BFF domain follows the platform hostname
  // derivation.
  late final Future<AppRuntimeContext> _context;

  @override
  void initState() {
    super.initState();
    _context = fetchRuntimeContext(logPrefix: 'Bill8 Merchant');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bill8 Merchant'),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Chip(label: Text('Test mode')),
          ),
        ],
      ),
      body: FutureBuilder<AppRuntimeContext>(
        future: _context,
        builder: (context, snap) {
          if (snap.hasError) {
            return Center(child: Text('Bootstrap failed: ${snap.error}'));
          }
          if (!snap.hasData) {
            return const BootstrapLoaderPage(appName: 'Bill8 Merchant');
          }
          final ctx = snap.data!;
          return ListView(
            padding: const EdgeInsets.all(Sentin8Spacing.lg),
            children: [
              GlassPanel(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Organization',
                      style: Sentin8Text.labelSmall,
                    ),
                    const SizedBox(height: Sentin8Spacing.xs),
                    Text(
                      ctx.organizationName,
                      style: Sentin8Text.headlineMedium,
                    ),
                    const SizedBox(height: Sentin8Spacing.sm),
                    Text(
                      'Environment: ${ctx.environmentId}',
                      style: Sentin8Text.bodyMedium,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: Sentin8Spacing.md),
              const GlassPanel(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Getting started', style: Sentin8Text.headlineMedium),
                    SizedBox(height: Sentin8Spacing.sm),
                    Text(
                      'Accept a payment from the Payments surface, run an '
                      'invoice cycle from Billing, or check payouts in the '
                      'Ledger. Everything routes through the platform proxy '
                      'with your session — no keys in the browser.',
                      style: Sentin8Text.bodyMedium,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}