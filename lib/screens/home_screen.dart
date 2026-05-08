import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../app_theme.dart';
import '../providers/app_state.dart';
import '../widgets/product_card.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/image_fallback.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 600;
    final isMediumScreen = screenSize.width >= 600 && screenSize.width < 900;
    final isLargeScreen = screenSize.width >= 900;

    final filteredProducts = _selectedCategory == 'All'
        ? appState.products
        : appState.products
            .where((p) => p.category == _selectedCategory)
            .toList();

    // Responsive hero height
    final double heroHeight = isSmallScreen ? 300.0 : (isMediumScreen ? 350.0 : 400.0);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isSmallScreen ? 'FLORAL ATELIER' : 'THE FLORAL ATELIER',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                letterSpacing: isSmallScreen ? 2 : 4,
                fontWeight: FontWeight.w700,
                fontSize: isSmallScreen ? 14 : null,
              ),
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_bag_outlined),
            onPressed: () => context.push('/cart'),
          ),
          IconButton(
            icon: const Icon(Icons.logout_rounded),
            onPressed: () async {
              final appState = Provider.of<AppState>(context, listen: false);
              await appState.signOut();
              if (context.mounted) {
                context.go('/signin');
              }
            },
          ),
        ],
      ),
      bottomNavigationBar: const BotanicalBottomNavBar(currentIndex: 0),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🌿 PREMIUM HERO (RESPONSIVE)
            SizedBox(
              height: heroHeight,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // background image
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.white, Color(0xFFF3F3F3)],
                      ),
                    ),
                    child: Image.asset(
                      'assets/images/blackrose.webp',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const ImageFallback(iconSize: 64),
                    ),
                  ),
                  // soft overlay
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(0.35),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                  // text content
                  Padding(
                    padding: EdgeInsets.all(isSmallScreen ? 16 : 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isSmallScreen
                              ? 'Ephemeral\nBeauty'
                              : 'Ephemeral\nBeauty',
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge
                              ?.copyWith(
                                color: Colors.white,
                                fontSize: isSmallScreen
                                    ? 32
                                    : (isMediumScreen ? 40 : 48),
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        SizedBox(height: isSmallScreen ? 8 : 12),
                        Text(
                          isSmallScreen
                              ? 'ARTISANAL ARRANGEMENTS'
                              : 'ARTISANAL ARRANGEMENTS FOR THE DISCERNING',
                          style:
                              Theme.of(context).textTheme.labelLarge?.copyWith(
                                    color: Colors.white70,
                                    letterSpacing: isSmallScreen ? 1 : 2,
                                    fontSize: isSmallScreen ? 10 : 12,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: isSmallScreen ? 16 : 24),

            // 🔥 OFFERS SLIDER (RESPONSIVE)
            OffersSlider(
              imageUrls: const [
                'assets/images/offer1.webp',
                'assets/images/offer2.webp',
                'assets/images/offer3.webp',
                'assets/images/offer4.webp',
              ],
              height: isSmallScreen ? 150 : (isMediumScreen ? 180 : 200),
              showIndicator: true,
              onOfferTap: (index) {
                print('Offer $index tapped');
              },
            ),

            SizedBox(height: isSmallScreen ? 20 : 32),

            // Section Title
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: isSmallScreen ? 16 : 24),
              child: Text(
                'COLLECTIONS',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      letterSpacing: isSmallScreen ? 2 : 3,
                      color: AppTheme.richGold,
                      fontSize: isSmallScreen ? 12 : 14,
                    ),
              ),
            ),

            SizedBox(height: isSmallScreen ? 12 : 16),

            // Categories (Responsive horizontal scroll)
            SizedBox(
              height: isSmallScreen ? 36 : 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding:
                    EdgeInsets.symmetric(horizontal: isSmallScreen ? 12 : 20),
                children:
                    ['All', 'Seasonal', 'Boutique', 'Artisanal'].map((cat) {
                  return GestureDetector(
                    onTap: () => setState(() => _selectedCategory = cat),
                    child: _CategoryChip(
                      label: cat,
                      isActive: _selectedCategory == cat,
                      isSmallScreen: isSmallScreen,
                    ),
                  );
                }).toList(),
              ),
            ),

            SizedBox(height: isSmallScreen ? 24 : 32),

            // Product Grid (Responsive grid layout)
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: isSmallScreen ? 16 : 24),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  // Responsive crossAxisCount based on screen width
                  int crossAxisCount;
                  double crossAxisSpacing;
                  double mainAxisSpacing;
                  double childAspectRatio;

                  if (constraints.maxWidth > 1200) {
                    crossAxisCount = 5;
                    crossAxisSpacing = 20;
                    mainAxisSpacing = 28;
                    childAspectRatio = 0.68;
                  } else if (constraints.maxWidth > 900) {
                    crossAxisCount = 4;
                    crossAxisSpacing = 18;
                    mainAxisSpacing = 26;
                    childAspectRatio = 0.67;
                  } else if (constraints.maxWidth > 600) {
                    crossAxisCount = 3;
                    crossAxisSpacing = 16;
                    mainAxisSpacing = 24;
                    childAspectRatio = 0.66;
                  } else if (constraints.maxWidth > 400) {
                    crossAxisCount = 2;
                    crossAxisSpacing = 14;
                    mainAxisSpacing = 22;
                    childAspectRatio = 0.65;
                  } else {
                    crossAxisCount = 2;
                    crossAxisSpacing = 12;
                    mainAxisSpacing = 20;
                    childAspectRatio = 0.62;
                  }

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      childAspectRatio: childAspectRatio,
                      crossAxisSpacing: crossAxisSpacing,
                      mainAxisSpacing: mainAxisSpacing,
                    ),
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];
                      return ProductCard(
                        product: product,
                        onTap: () => context.push('/product/${product.id}'),
                      );
                    },
                  );
                },
              ),
            ),

            SizedBox(height: isSmallScreen ? 30 : 40),
          ],
        ),
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String label;
  final bool isActive;
  final bool isSmallScreen;

  const _CategoryChip({
    required this.label,
    this.isActive = false,
    this.isSmallScreen = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: isSmallScreen ? 8 : 12),
      padding: EdgeInsets.symmetric(
          horizontal: isSmallScreen ? 12 : 20,
          vertical: isSmallScreen ? 6 : 10),
      decoration: BoxDecoration(
        color: isActive ? AppTheme.primaryGreen : Colors.transparent,
        border: Border.all(
          color: isActive
              ? AppTheme.primaryGreen
              : AppTheme.outline.withOpacity(0.3),
        ),
        borderRadius: BorderRadius.circular(9999),
      ),
      child: Center(
        child: Text(
          isSmallScreen ? label : label.toUpperCase(),
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: isActive ? Colors.white : AppTheme.primaryGreen,
                fontSize: isSmallScreen ? 9 : 10,
              ),
        ),
      ),
    );
  }
}

// ==================== OFFERS SLIDER WIDGET (RESPONSIVE) ====================
class OffersSlider extends StatefulWidget {
  final List<String> imageUrls;
  final double height;
  final bool showIndicator;
  final void Function(int index)? onOfferTap;

  const OffersSlider({
    super.key,
    required this.imageUrls,
    this.height = 200,
    this.showIndicator = true,
    this.onOfferTap,
  });

  @override
  State<OffersSlider> createState() => _OffersSliderState();
}

class _OffersSliderState extends State<OffersSlider> {
  late PageController _pageController;
  int _currentPage = 0;
  late Duration _autoScrollDuration;
  bool _isAutoScrolling = true;
  bool _isDragging = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _autoScrollDuration = const Duration(seconds: 3);
    _startAutoScroll();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    if (widget.imageUrls.length <= 1) return;

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted && _isAutoScrolling) {
        _autoScrollLoop();
      }
    });
  }

  void _autoScrollLoop() {
    if (!mounted || !_isAutoScrolling || !_pageController.hasClients) return;

    final nextPage = (_currentPage + 1) % widget.imageUrls.length;
    _pageController.animateToPage(
      nextPage,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );

    Future.delayed(_autoScrollDuration, () {
      if (mounted && _isAutoScrolling && !_isDragging) {
        _autoScrollLoop();
      }
    });
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _onUserDragStart() {
    _isDragging = true;
    _isAutoScrolling = false;
  }

  void _onUserDragEnd() {
    _isDragging = false;
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted && !_isDragging) {
        _isAutoScrolling = true;
        _startAutoScroll();
      }
    });
  }

  void _manualNavigation(int newPage) {
    _isAutoScrolling = false;
    _isDragging = true;
    _pageController.animateToPage(
      newPage,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        _isDragging = false;
        _isAutoScrolling = true;
        _startAutoScroll();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 600;
    final navButtonSize = isSmallScreen ? 32.0 : 36.0;
    final navIconSize = isSmallScreen ? 20.0 : 24.0;

    if (widget.imageUrls.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: isSmallScreen ? 4 : 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Slider Container
          Container(
            height: widget.height,
            margin: EdgeInsets.symmetric(horizontal: isSmallScreen ? 12 : 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(isSmallScreen ? 16 : 24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: isSmallScreen ? 8 : 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(isSmallScreen ? 16 : 24),
              child: Stack(
                children: [
                  // PageView for images
                  NotificationListener<ScrollNotification>(
                    onNotification: (notification) {
                      if (notification is ScrollStartNotification) {
                        _onUserDragStart();
                      } else if (notification is ScrollEndNotification) {
                        _onUserDragEnd();
                      }
                      return false;
                    },
                    child: PageView.builder(
                      controller: _pageController,
                      onPageChanged: _onPageChanged,
                      itemCount: widget.imageUrls.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            if (widget.onOfferTap != null) {
                              widget.onOfferTap!(index);
                            }
                          },
                          child: Image.asset(
                            widget.imageUrls[index],
                            fit: BoxFit.cover,
                            width: double.infinity,
                            errorBuilder: (context, error, stackTrace) {
                              print(
                                  'Error loading image: ${widget.imageUrls[index]}');
                              return Container(
                                color: Colors.grey[300],
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.image_not_supported,
                                      size: isSmallScreen ? 32 : 48,
                                      color: Colors.grey,
                                    ),
                                    if (!isSmallScreen) ...[
                                      const SizedBox(height: 8),
                                      Text(
                                        'Image ${index + 1} not found',
                                        style:
                                            const TextStyle(color: Colors.grey),
                                      ),
                                    ],
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  // Offer Badge
                  Positioned(
                    top: isSmallScreen ? 12 : 16,
                    left: isSmallScreen ? 12 : 16,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: isSmallScreen ? 8 : 12,
                        vertical: isSmallScreen ? 4 : 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.local_offer_outlined,
                            color: Colors.white,
                            size: isSmallScreen ? 12 : 16,
                          ),
                          SizedBox(width: isSmallScreen ? 4 : 6),
                          Text(
                            isSmallScreen ? 'OFFER' : 'OFFERS',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: isSmallScreen ? 10 : 12,
                              fontWeight: FontWeight.bold,
                              letterSpacing: isSmallScreen ? 0.5 : 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Gradient Overlay for better text visibility
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(isSmallScreen ? 16 : 24),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.3),
                          ],
                          stops: const [0.5, 1.0],
                        ),
                      ),
                    ),
                  ),
                  // Left/Right navigation arrows (responsive sizing)
                  if (widget.imageUrls.length > 1) ...[
                    Positioned(
                      left: isSmallScreen ? 4 : 8,
                      top: 0,
                      bottom: 0,
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            final prevPage =
                                (_currentPage - 1) % widget.imageUrls.length;
                            _manualNavigation(prevPage);
                          },
                          child: Container(
                            padding: EdgeInsets.all(isSmallScreen ? 6 : 8),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.4),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.chevron_left,
                              color: Colors.white,
                              size: navIconSize,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: isSmallScreen ? 4 : 8,
                      top: 0,
                      bottom: 0,
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            final nextPage =
                                (_currentPage + 1) % widget.imageUrls.length;
                            _manualNavigation(nextPage);
                          },
                          child: Container(
                            padding: EdgeInsets.all(isSmallScreen ? 6 : 8),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.4),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.chevron_right,
                              color: Colors.white,
                              size: navIconSize,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          // Page Indicator
          if (widget.showIndicator && widget.imageUrls.length > 1)
            Padding(
              padding: EdgeInsets.only(top: isSmallScreen ? 8 : 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(widget.imageUrls.length, (index) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin:
                        EdgeInsets.symmetric(horizontal: isSmallScreen ? 3 : 4),
                    height: isSmallScreen ? 3 : 4,
                    width: _currentPage == index
                        ? (isSmallScreen ? 16 : 24)
                        : (isSmallScreen ? 6 : 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: _currentPage == index
                          ? Theme.of(context).primaryColor
                          : Colors.grey.shade300,
                    ),
                  );
                }),
              ),
            ),
        ],
      ),
    );
  }
}
