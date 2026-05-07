import 'package:flutter/material.dart';

/// A reusable fallback widget shown when a network image fails to load.
/// Displays a white background with the app logo in the center.
class ImageFallback extends StatelessWidget {
  final double? logoHeight;

  const ImageFallback({super.key, this.logoHeight, double? iconSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Image.asset(
          'assets/images/whitelogo.png',
          height: logoHeight ?? 80,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
