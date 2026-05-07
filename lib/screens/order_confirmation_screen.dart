import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../app_theme.dart';
import '../widgets/primary_button.dart';

class OrderConfirmationScreen extends StatelessWidget {
  const OrderConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.alabaster,
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle_outline,
              size: 100,
              color: AppTheme.primaryGreen,
            ),
            const SizedBox(height: 32),
            Text(
              'ORDER CONFIRMED',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    letterSpacing: 4,
                  ),
            ),
            const SizedBox(height: 16),
            Text(
              'THANK YOU FOR YOUR PURCHASE. YOUR BOTANICAL ARRANGEMENT IS BEING PREPARED WITH CARE.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: AppTheme.outline,
                    height: 1.8,
                  ),
            ),
            const SizedBox(height: 60),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                border: Border.all(color: AppTheme.richGold.withValues(alpha: 0.2)),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                children: [
                  _SummaryRow(label: 'ORDER NUMBER', value: '#BB-89012'),
                  const SizedBox(height: 12),
                  _SummaryRow(label: 'ESTIMATED DELIVERY', value: 'MAY 28, 2026'),
                ],
              ),
            ),
            const SizedBox(height: 80),
            PrimaryButton(
              label: 'Track Order',
              onPressed: () => context.go('/track'),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => context.go('/'),
              child: Text(
                'BACK TO HOME',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: AppTheme.primaryGreen,
                      letterSpacing: 2,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;

  const _SummaryRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontSize: 10,
                color: AppTheme.outline,
              ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
      ],
    );
  }
}
