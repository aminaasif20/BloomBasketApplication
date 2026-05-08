import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../app_theme.dart';
import '../providers/app_state.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final cart = appState.cart;

    return Scaffold(
      backgroundColor: AppTheme.alabaster,
      appBar: AppBar(
        backgroundColor: AppTheme.alabaster,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.primaryGreen),
          onPressed: () {
            context.go('/');
          },
        ),
        title: Column(
          children: [
            Text(
              'MY CART',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                letterSpacing: 4,
                color: AppTheme.primaryGreen,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              '${cart.length} ${cart.length == 1 ? 'item' : 'items'}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppTheme.textSecondary,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),

      // ─── EMPTY STATE ───────────────────────────────────────────────────────
      body: cart.isEmpty
          ? _buildEmptyCart(context)
          : Column(
              children: [
                // divider line
                Divider(height: 1, color: AppTheme.outline.withOpacity(0.15)),

                // ─── CART ITEMS LIST ─────────────────────────────────────────
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 20,
                    ),
                    itemCount: cart.length,
                    separatorBuilder: (_, __) => Divider(
                      height: 32,
                      color: AppTheme.outline.withOpacity(0.12),
                    ),
                    itemBuilder: (context, index) {
                      final item = cart[index];
                      final product = item.product;

                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ── PRODUCT IMAGE ──────────────────────────────
                          Container(
                            width: 88,
                            height: 88,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: AppTheme.outline.withOpacity(0.15),
                              ),
                            ),
                            padding: const EdgeInsets.all(8),
                            child: product.imageUrl.startsWith('assets/')
                                ? Image.asset(
                                    product.imageUrl,
                                    fit: BoxFit.contain,
                                  )
                                : Image.network(
                                    product.imageUrl,
                                    fit: BoxFit.contain,
                                    errorBuilder: (_, __, ___) => const Icon(
                                      Icons.local_florist_outlined,
                                      color: AppTheme.textSecondary,
                                    ),
                                  ),
                          ),

                          const SizedBox(width: 14),

                          // ── DETAILS ────────────────────────────────────
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Name
                                Text(
                                  product.name,
                                  style: Theme.of(context).textTheme.titleSmall
                                      ?.copyWith(
                                        fontWeight: FontWeight.w700,
                                        color: AppTheme.primaryGreen,
                                      ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),

                                const SizedBox(height: 4),

                                // Category
                                Text(
                                  product.category.toUpperCase(),
                                  style: Theme.of(context).textTheme.labelSmall
                                      ?.copyWith(
                                        color: AppTheme.textSecondary,
                                        letterSpacing: 1.5,
                                      ),
                                ),

                                const SizedBox(height: 12),

                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // ── QUANTITY CONTROL ───────────────
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: AppTheme.outline.withOpacity(
                                            0.3,
                                          ),
                                        ),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Row(
                                        children: [
                                          // Decrease / Remove
                                          InkWell(
                                            onTap: () {
                                              if (item.quantity > 1) {
                                                appState.updateQuantity(
                                                  product,
                                                  item.quantity - 1,
                                                );
                                              } else {
                                                // Remove from cart
                                                appState.removeFromCart(
                                                  product,
                                                );
                                              }
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 6,
                                                  ),
                                              child: Icon(
                                                item.quantity == 1
                                                    ? Icons.delete_outline
                                                    : Icons.remove,
                                                size: 16,
                                                color: item.quantity == 1
                                                    ? Colors.red[400]
                                                    : AppTheme.primaryGreen,
                                              ),
                                            ),
                                          ),

                                          // Quantity number
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 12,
                                              vertical: 6,
                                            ),
                                            decoration: BoxDecoration(
                                              border: Border.symmetric(
                                                vertical: BorderSide(
                                                  color: AppTheme.outline
                                                      .withOpacity(0.3),
                                                ),
                                              ),
                                            ),
                                            child: Text(
                                              '${item.quantity}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall
                                                  ?.copyWith(
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                            ),
                                          ),

                                          // Increase
                                          InkWell(
                                            onTap: () {
                                              appState.updateQuantity(
                                                product,
                                                item.quantity + 1,
                                              );
                                            },
                                            child: const Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 10,
                                                vertical: 6,
                                              ),
                                              child: Icon(
                                                Icons.add,
                                                size: 16,
                                                color: AppTheme.primaryGreen,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    // ── ITEM TOTAL PRICE ───────────────
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          '\$${item.totalPrice.toStringAsFixed(2)}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium
                                              ?.copyWith(
                                                fontWeight: FontWeight.w700,
                                                color: AppTheme.primaryGreen,
                                              ),
                                        ),
                                        if (item.quantity > 1)
                                          Text(
                                            '\$${product.price.toStringAsFixed(2)} each',
                                            style: Theme.of(
                                              context,
                                            ).textTheme.bodySmall,
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),

                // ─── ORDER SUMMARY + CHECKOUT ─────────────────────────────────
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(
                        color: AppTheme.outline.withOpacity(0.15),
                      ),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 12,
                        offset: const Offset(0, -4),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
                  child: Column(
                    children: [
                      // Subtotal row
                      _SummaryRow(
                        label: 'Subtotal',
                        value: '\$${appState.cartTotal.toStringAsFixed(2)}',
                        context: context,
                      ),
                      const SizedBox(height: 8),
                      // Shipping row
                      _SummaryRow(
                        label: 'Shipping',
                        value: 'Free',
                        context: context,
                        valueColor: Colors.green[600],
                      ),

                      const SizedBox(height: 12),
                      Divider(
                        color: AppTheme.outline.withOpacity(0.15),
                        height: 1,
                      ),
                      const SizedBox(height: 12),

                      // Grand total
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'TOTAL',
                            style: Theme.of(context).textTheme.labelLarge
                                ?.copyWith(
                                  letterSpacing: 2,
                                  color: AppTheme.primaryGreen,
                                  fontWeight: FontWeight.w800,
                                ),
                          ),
                          Text(
                            '\$${appState.cartTotal.toStringAsFixed(2)}',
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppTheme.primaryGreen,
                                ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // Checkout Button
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: () {
                            if (appState.isAuthenticated) {
                              context.push('/checkout');
                            } else {
                              context.push('/signin');
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primaryGreen,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.shopping_bag_outlined, size: 18),
                              const SizedBox(width: 10),
                              Text(
                                'PROCEED TO CHECKOUT',
                                style: Theme.of(context).textTheme.labelLarge
                                    ?.copyWith(
                                      color: Colors.white,
                                      letterSpacing: 2,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  // ─── EMPTY CART STATE ───────────────────────────────────────────────────────
  Widget _buildEmptyCart(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_bag_outlined,
              size: 80,
              color: AppTheme.outline.withOpacity(0.3),
            ),
            const SizedBox(height: 24),
            Text(
              'YOUR CART IS EMPTY',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                letterSpacing: 3,
                color: AppTheme.textSecondary,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Explore our collections and add\nyour favourite arrangements.',
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppTheme.textSecondary),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () => context.go('/'),
                child: const Text('SHOP NOW'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── HELPER WIDGET ────────────────────────────────────────────────────────────
class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final BuildContext context;
  final Color? valueColor;

  const _SummaryRow({
    required this.label,
    required this.value,
    required this.context,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: AppTheme.textSecondary),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: valueColor ?? AppTheme.primaryGreen,
          ),
        ),
      ],
    );
  }
}
