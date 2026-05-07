import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../app_theme.dart';
import '../providers/app_state.dart';
import '../widgets/product_card.dart';
import '../widgets/bottom_nav_bar.dart';

class DiscoveryScreen extends StatefulWidget {
  const DiscoveryScreen({super.key});

  @override
  State<DiscoveryScreen> createState() => _DiscoveryScreenState();
}

class _DiscoveryScreenState extends State<DiscoveryScreen> {
  String _selectedCategory = 'All';
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    // Step 1: First filter by category
    final categoryFilteredProducts = _selectedCategory == 'All'
        ? appState.products
        : appState.products
              .where((p) => p.category == _selectedCategory)
              .toList();

    // Step 2: Then apply search filter on category-filtered products
    final filteredProducts = categoryFilteredProducts.where((p) {
      if (_searchQuery.isEmpty) return true;

      final searchWords = _searchQuery.toLowerCase().trim().split(' ');

      // Search in product properties
      return searchWords.every(
        (word) =>
            p.name.toLowerCase().contains(word) ||
            p.description.toLowerCase().contains(word) ||
            p.category.toLowerCase().contains(word) ||
            p.tags.any((tag) => tag.toLowerCase().contains(word)),
      );
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'DISCOVER',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            letterSpacing: 4,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      bottomNavigationBar: const BotanicalBottomNavBar(currentIndex: 1),
      body: Column(
        children: [
          // SEARCH BOX
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText:
                    'Search in ${_selectedCategory == 'All' ? 'all products' : _selectedCategory}...',
                prefixIcon: const Icon(Icons.search, size: 20),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: AppTheme.outline.withValues(alpha: 0.2),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: AppTheme.primaryGreen),
                ),
              ),
            ),
          ),

          // CATEGORY CHIPS
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                _DiscoveryCategoryChip(
                  label: 'All',
                  isActive: _selectedCategory == 'All',
                  onTap: () {
                    setState(() {
                      _selectedCategory = 'All';
                      _searchQuery =
                          ''; // Optional: Clear search when changing category
                    });
                  },
                ),
                _DiscoveryCategoryChip(
                  label: 'Seasonal',
                  isActive: _selectedCategory == 'Seasonal',
                  onTap: () {
                    setState(() {
                      _selectedCategory = 'Seasonal';
                      _searchQuery =
                          ''; // Optional: Clear search when changing category
                    });
                  },
                ),
                _DiscoveryCategoryChip(
                  label: 'Boutique',
                  isActive: _selectedCategory == 'Boutique',
                  onTap: () {
                    setState(() {
                      _selectedCategory = 'Boutique';
                      _searchQuery =
                          ''; // Optional: Clear search when changing category
                    });
                  },
                ),
                _DiscoveryCategoryChip(
                  label: 'Artisanal',
                  isActive: _selectedCategory == 'Artisanal',
                  onTap: () {
                    setState(() {
                      _selectedCategory = 'Artisanal';
                      _searchQuery =
                          ''; // Optional: Clear search when changing category
                    });
                  },
                ),
              ],
            ),
          ),

          // RESULTS COUNT
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${filteredProducts.length} products found',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                ),
                if (_searchQuery.isNotEmpty)
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _searchQuery = '';
                      });
                    },
                    child: const Text('Clear Search'),
                  ),
              ],
            ),
          ),

          // GRID RESULTS
          Expanded(
            child: filteredProducts.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: AppTheme.textSecondary.withValues(alpha: 0.5),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No products found',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(color: AppTheme.textSecondary),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Try adjusting your search or category filter',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: AppTheme.textSecondary),
                        ),
                      ],
                    ),
                  )
                : LayoutBuilder(
                    builder: (context, constraints) {
                      int crossAxisCount = 2;

                      if (constraints.maxWidth > 1200) {
                        crossAxisCount = 5;
                      } else if (constraints.maxWidth > 900) {
                        crossAxisCount = 4;
                      } else if (constraints.maxWidth > 600) {
                        crossAxisCount = 3;
                      }

                      return GridView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          childAspectRatio: 0.65,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 24,
                        ),
                        itemCount: filteredProducts.length,
                        itemBuilder: (context, index) {
                          final product = filteredProducts[index];
                          return ProductCard(
                            product: product,
                            onTap: () => context.go('/product/${product.id}'),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

// CATEGORY CHIP WIDGET
class _DiscoveryCategoryChip extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _DiscoveryCategoryChip({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? AppTheme.primaryGreen : Colors.transparent,
          border: Border.all(
            color: isActive
                ? AppTheme.primaryGreen
                : AppTheme.outline.withValues(alpha: 0.3),
          ),
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text(
          label.toUpperCase(),
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: isActive ? Colors.white : AppTheme.primaryGreen,
            fontSize: 10,
          ),
        ),
      ),
    );
  }
}
