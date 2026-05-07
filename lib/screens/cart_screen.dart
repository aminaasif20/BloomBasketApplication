import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Cart")),
      body: appState.cart.isEmpty
          ? const Center(child: Text("Cart is empty"))
          : SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: appState.cart.length,
                      itemBuilder: (context, index) {
                        final item = appState.cart[index];

                        return Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              Image.network(
                                item.product.imageUrl,
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(width: 10),

                              // INFO
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.product.name,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      "\$${item.totalPrice.toStringAsFixed(0)}",
                                    ),
                                  ],
                                ),
                              ),

                              // ➕➖ QUANTITY
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      if (item.quantity > 1) {
                                        appState.updateQuantity(
                                          item.product,
                                          item.quantity - 1,
                                        );
                                      }
                                    },
                                    icon: const Icon(Icons.remove),
                                  ),
                                  Text("${item.quantity}"),
                                  IconButton(
                                    onPressed: () {
                                      appState.updateQuantity(
                                        item.product,
                                        item.quantity + 1,
                                      );
                                    },
                                    icon: const Icon(Icons.add),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  // 💰 TOTAL
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Total"),
                            Text("\$${appState.cartTotal.toStringAsFixed(0)}"),
                          ],
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {},
                            child: const Text("Checkout"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
