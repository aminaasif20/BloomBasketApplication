import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../app_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 2500), () {
      if (mounted) {
        context.go('/');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryGreen,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.local_florist,
              size: 80,
              color: AppTheme.pinkContainer,
            ),
            const SizedBox(height: 24),
            Text(
              'BLOOMBASKET',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                color: Colors.white,
                fontSize: 32,
                letterSpacing: 8,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'BOTANICAL PRESTIGE',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: AppTheme.pinkContainer.withValues(alpha: 0.7),
                letterSpacing: 4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
