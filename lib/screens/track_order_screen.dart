import 'package:flutter/material.dart';
import '../app_theme.dart';

class TrackOrderScreen extends StatelessWidget {
  const TrackOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'TRACK ORDER',
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
            // Order Info Card
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppTheme.primaryGreen,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'ORDER #BB-89012',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: Colors.white,
                          letterSpacing: 2,
                        ),
                      ),
                      Text(
                        'IN PROGRESS',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: AppTheme.pinkContainer,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 32, color: Colors.white24),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        color: Colors.white,
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          '123 BOTANICAL GARDENS, LONDON, UK',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: Colors.white.withValues(alpha: 0.8),
                              ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 48),

            Text(
              'STATUS',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                letterSpacing: 3,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 24),

            // Vertical Stepper
            _StatusStep(
              title: 'ORDER CONFIRMED',
              time: 'MAY 26, 10:30 AM',
              isCompleted: true,
              isFirst: true,
            ),
            _StatusStep(
              title: 'PREPARING ARRANGEMENT',
              time: 'MAY 26, 11:45 AM',
              isCompleted: true,
              isCurrent: true,
            ),
            _StatusStep(
              title: 'OUT FOR DELIVERY',
              time: 'ESTIMATED 2:00 PM',
              isCompleted: false,
            ),
            _StatusStep(
              title: 'DELIVERED',
              time: 'ESTIMATED 2:30 PM',
              isCompleted: false,
              isLast: true,
            ),

            const SizedBox(height: 48),

            // Map Placeholder
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppTheme.outline.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: AppTheme.outline.withValues(alpha: 0.2),
                ),
              ),
              child: const Center(
                child: Icon(
                  Icons.map_outlined,
                  size: 48,
                  color: AppTheme.outline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusStep extends StatelessWidget {
  final String title;
  final String time;
  final bool isCompleted;
  final bool isCurrent;
  final bool isFirst;
  final bool isLast;

  const _StatusStep({
    required this.title,
    required this.time,
    required this.isCompleted,
    this.isCurrent = false,
    this.isFirst = false,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Column(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isCompleted
                      ? AppTheme.primaryGreen
                      : Colors.transparent,
                  border: Border.all(
                    color: isCompleted
                        ? AppTheme.primaryGreen
                        : AppTheme.outline.withValues(alpha: 0.3),
                    width: 2,
                  ),
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: isCompleted
                        ? AppTheme.primaryGreen
                        : AppTheme.outline.withValues(alpha: 0.1),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: isCompleted
                          ? AppTheme.primaryGreen
                          : AppTheme.outline,
                      fontWeight: isCurrent ? FontWeight.w700 : FontWeight.w400,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    time,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 12,
                      color: AppTheme.outline.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
