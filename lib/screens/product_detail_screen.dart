import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';

class ProductDetailScreen extends StatefulWidget {
  final String productId;

  const ProductDetailScreen({super.key, required this.productId});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final product = appState.products.firstWhere(
      (p) => p.id == widget.productId,
    );

    final isFav = appState.isFavorite(product);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // 🔥 IMAGE (FULL WIDTH - NO PINK)
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: double.infinity,
                    color: Colors.white,
                    padding: const EdgeInsets.all(24),
                    child: Center(
                      child: product.imageUrl.startsWith('assets/')
                          ? Image.asset(
                              product.imageUrl,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Center(
                                    child: Icon(
                                      Icons.broken_image,
                                      size: 64,
                                      color: Colors.grey,
                                    ),
                                  ),
                            )
                          : Image.network(
                              product.imageUrl,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Center(
                                    child: Icon(
                                      Icons.broken_image,
                                      size: 64,
                                      color: Colors.grey,
                                    ),
                                  ),
                            ),
                    ),
                  ),

                  // 🔙 WHITE BACK BUTTON
                  Positioned(
                    top: 20,
                    left: 16,
                    child: GestureDetector(
                      onTap: () => context.pop(),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // TITLE + LIKE
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            product.name,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            appState.toggleFavorite(product);
                          },
                          icon: Icon(
                            isFav ? Icons.favorite : Icons.favorite_border,
                            color: isFav ? Colors.red : Colors.grey,
                          ),
                        ),
                      ],
                    ),

                    Text(
                      product.category,
                      style: const TextStyle(color: Colors.grey),
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      "Product Details",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      product.description,
                      style: TextStyle(color: Colors.grey[700]),
                    ),

                    const SizedBox(height: 20),

                    // 💰 PRICE + QUANTITY
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "\$${product.price}",
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                if (quantity > 1) {
                                  setState(() => quantity--);
                                }
                              },
                              icon: const Icon(Icons.remove),
                            ),
                            Text(
                              "$quantity",
                              style: const TextStyle(fontSize: 16),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() => quantity++);
                              },
                              icon: const Icon(Icons.add),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    // 🛒 ADD TO CART
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // 1. Direct quantity update karein (Behtar approach)
                          final cartItemIndex = appState.cart.indexWhere(
                            (item) => item.product.id == product.id,
                          );

                          if (cartItemIndex >= 0) {
                            // Agar pehle se cart mein hai to purani quantity + nayi quantity
                            appState.updateQuantity(
                              product,
                              appState.cart[cartItemIndex].quantity + quantity,
                            );
                          } else {
                            // Agar naya hai to add karein aur phir quantity set karein
                            appState.addToCart(product);
                            if (quantity > 1) {
                              appState.updateQuantity(product, quantity);
                            }
                          }

                          // 2. Feedback SnackBar
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.green[800],
                              content: Text(
                                '$quantity x ${product.name} added!',
                              ),
                              action: SnackBarAction(
                                label: 'VIEW CART',
                                textColor: Colors.white,
                                onPressed: () => context.push('/cart'),
                              ),
                            ),
                          );
                        },
                        child: const Text("Add To Cart"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
