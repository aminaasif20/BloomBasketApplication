import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/product.dart';
import '../app_theme.dart';
import 'image_fallback.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;

  const ProductCard({super.key, required this.product, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 7,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFEEEEEE), width: 1),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Center(
                    child: product.imageUrl.startsWith('assets/')
                        ? Image.asset(
                            product.imageUrl,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) =>
                                const ImageFallback(),
                          )
                        : CachedNetworkImage(
                            imageUrl: product.imageUrl,
                            fit: BoxFit.contain,
                            placeholder: (context, url) =>
                                const ImageFallback(),
                            errorWidget: (context, url, error) =>
                                const ImageFallback(),
                          ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            product.name.toUpperCase(),
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              letterSpacing: 1.5,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '\$${product.price.toStringAsFixed(0)}',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.primaryGreen.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }
}
