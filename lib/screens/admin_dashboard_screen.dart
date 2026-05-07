import 'package:flutter/material.dart';
import '../app_theme.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ADMIN DASHBOARD',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            letterSpacing: 4,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stats Row
            Row(
              children: [
                _StatCard(
                  title: 'TODAY\'S SALES',
                  value: '\$1,240',
                  trend: '+12%',
                ),
                const SizedBox(width: 16),
                _StatCard(title: 'NEW ORDERS', value: '18', trend: '+5%'),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _StatCard(
                  title: 'PENDING',
                  value: '4',
                  color: AppTheme.richGold,
                ),
                const SizedBox(width: 16),
                _StatCard(
                  title: 'LOW STOCK',
                  value: '2',
                  color: Colors.redAccent,
                ),
              ],
            ),

            const SizedBox(height: 40),

            Text(
              'RECENT ORDERS',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                letterSpacing: 3,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 16),

            // Orders List
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    'ORDER #BB-${9012 - index}',
                    style: Theme.of(
                      context,
                    ).textTheme.labelLarge?.copyWith(fontSize: 12),
                  ),
                  subtitle: Text(
                    'May 26, 2026 • 2 items',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  trailing: Text(
                    '\$${(120 - index * 10).toStringAsFixed(0)}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String? trend;
  final Color? color;

  const _StatCard({
    required this.title,
    required this.value,
    this.trend,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppTheme.outline.withValues(alpha: 0.1)),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontSize: 8,
                color: AppTheme.outline,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  value,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontSize: 24,
                    color: color ?? AppTheme.primaryGreen,
                  ),
                ),
                if (trend != null)
                  Text(
                    trend!,
                    style: const TextStyle(
                      color: Colors.green,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
