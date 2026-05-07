import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/cart_item.dart';

class AppState extends ChangeNotifier {
  final List<Product> _products = [
    Product(
      id: '1',
      name: 'Midnight Peony',
      description:
          'A deep, mysterious arrangement of dark peonies and forest greens.',
      price: 85.0,
      imageUrl:
          'https://images.unsplash.com/photo-1670757055850-f07c9352dfe4?q=80&w=774&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      category: 'Seasonal',
      tags: ['Luxury', 'Dark'],
    ),
    Product(
      id: '2',
      name: 'Alabaster Lily',
      description: 'Pure white lilies paired with delicate eucalyptus.',
      price: 65.0,
      imageUrl:
          'https://images.unsplash.com/photo-1690121013896-828f1b536dd6?q=80&w=735&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      category: 'Boutique',
      tags: ['Elegant', 'White'],
    ),
    Product(
      id: '3',
      name: 'Gilded Rose',
      description: 'Classic red roses with a touch of gold-sprayed foliage.',
      price: 95.0,
      imageUrl:
          'https://plus.unsplash.com/premium_photo-1751294863710-75a34d6f50e8?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      category: 'Artisanal',
      tags: ['Romance', 'Gold'],
    ),
    Product(
      id: '4',
      name: 'Sunset Tulip',
      description: 'Vibrant orange tulips reminiscent of a warm sunset.',
      price: 55.0,
      imageUrl:
          'https://images.unsplash.com/photo-1530092285049-1c42085fd395?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      category: 'Seasonal',
      tags: ['Bright', 'Warm'],
    ),
    Product(
      id: '5',
      name: 'Lavender Dream',
      description: 'Soft purple lavender bouquets for a calming ambience.',
      price: 70.0,
      imageUrl:
          'https://images.unsplash.com/photo-1651047292794-8de51dd0ae66?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      category: 'Boutique',
      tags: ['Calm', 'Purple'],
    ),
    Product(
      id: '6',
      name: 'Rose Gold Delight',
      description: 'Rose gold colored roses with delicate accents.',
      price: 90.0,
      imageUrl:
          'https://plus.unsplash.com/premium_photo-1667308529211-a6f84b19050b?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      category: 'Artisanal',
      tags: ['Luxury', 'Gold'],
    ),
    Product(
      id: '7',
      name: 'Cherry Blossom',
      description: 'Delicate pink blossoms evoking springtime elegance.',
      price: 60.0,
      imageUrl:
          'https://plus.unsplash.com/premium_photo-1676478746561-8feeaa7a307a?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      category: 'Seasonal',
      tags: ['Pink', 'Spring'],
    ),
    Product(
      id: '8',
      name: 'White Orchid',
      description: 'Pure white orchid arrangement for sophisticated décor.',
      price: 80.0,
      imageUrl:
          'https://plus.unsplash.com/premium_photo-1673120765126-066ad8fedc9d?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      category: 'Boutique',
      tags: ['Elegant', 'White'],
    ),
    Product(
      id: '9',
      name: 'Golden Sunflower',
      description: 'Bright sunflowers with golden accents for a cheerful vibe.',
      price: 58.0,
      imageUrl:
          'https://plus.unsplash.com/premium_photo-1675873580364-8845f681b4ed?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      category: 'Seasonal',
      tags: ['Sunny', 'Yellow'],
    ),
    Product(
      id: '10',
      name: 'Mystic Orchid',
      description: 'Deep violet orchids with a mysterious allure.',
      price: 85.0,
      imageUrl:
          'https://media.istockphoto.com/id/1133528716/photo/water-lily-flower-fully-blossomed-in-blue-green-water.webp?s=612x612&w=is&k=20&c=yB0Cy59nE953JoWJf5uI6OIc3JqGyRDTzFtnalJR2qs=',
      category: 'Artisanal',
      tags: ['Violet', 'Mystic'],
    ),
    Product(
      id: '11',
      name: 'Coral Peony',
      description: 'Soft coral peonies perfect for romantic occasions.',
      price: 78.0,
      imageUrl:
          'https://images.unsplash.com/photo-1538998073820-4dfa76300194?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      category: 'Boutique',
      tags: ['Romantic', 'Coral'],
    ),
    Product(
      id: '12',
      name: 'Emerald Fern',
      description: 'Lush green fern arrangements bringing nature indoors.',
      price: 45.0,
      imageUrl:
          'https://images.unsplash.com/photo-1470364610780-b5ec575a77a0?w=700&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTV8fG5hdHVyZSUyMGZsb3dlcnxlbnwwfHwwfHx8MA%3D%3D',
      category: 'Seasonal',
      tags: ['Green', 'Nature'],
    ),
    Product(
      id: '13',
      name: 'Blush Rose',
      description: 'Gentle pink roses for subtle elegance.',
      price: 68.0,
      imageUrl: 'https://picsum.photos/seed/blush/400/500',
      category: 'Boutique',
      tags: ['Pink', 'Elegant'],
    ),
    Product(
      id: '14',
      name: 'Royal Amaranth',
      description: 'Vibrant red amaranth for a bold statement.',
      price: 62.0,
      imageUrl: 'https://picsum.photos/seed/amaranth/400/500',
      category: 'Artisanal',
      tags: ['Bold', 'Red'],
    ),
    Product(
      id: '15',
      name: 'Silk Tulip',
      description: 'Elegant silk tulip arrangement for lasting beauty.',
      price: 73.0,
      imageUrl: 'https://picsum.photos/seed/silktulip/400/500',
      category: 'Boutique',
      tags: ['Silk', 'Elegant'],
    ),
    Product(
      id: '16',
      name: 'Amber Daisy',
      description: 'Cheerful amber daisies adding sunny vibes.',
      price: 50.0,
      imageUrl: 'https://picsum.photos/seed/daisy/400/500',
      category: 'Seasonal',
      tags: ['Sunny', 'Daisy'],
    ),
    Product(
      id: '17',
      name: 'Midnight Orchid',
      description: 'Dark orchid arrangement for an exotic night look.',
      price: 88.0,
      imageUrl: 'https://picsum.photos/seed/darkflower/400/500',
      category: 'Artisanal',
      tags: ['Dark', 'Exotic'],
    ),
    Product(
      id: '18',
      name: 'Pearl Lily',
      description: 'Luminous white lilies with pearl accents.',
      price: 77.0,
      imageUrl: 'https://picsum.photos/seed/pearllily/400/500',
      category: 'Boutique',
      tags: ['Luminous', 'White'],
    ),
    Product(
      id: '19',
      name: 'Cobalt Iris',
      description: 'Deep cobalt iris bouquets for striking visual impact.',
      price: 69.0,
      imageUrl: 'https://picsum.photos/seed/iris/400/500',
      category: 'Seasonal',
      tags: ['Cobalt', 'Bold'],
    ),
    Product(
      id: '20',
      name: 'Golden Magnolia',
      description: 'Radiant golden magnolia blossoms for luxurious gifting.',
      price: 92.0,
      imageUrl: 'https://picsum.photos/seed/magnolia/400/500',
      category: 'Artisanal',
      tags: ['Luxury', 'Gold'],
    ),
    Product(
      id: '21',
      name: 'Ruby Amaryllis',
      description: 'Stunning deep red petals for a grand holiday feel.',
      price: 82.0,
      imageUrl: 'https://picsum.photos/seed/amaryllis/400/500',
      category: 'Seasonal',
      tags: ['Holiday', 'Red'],
    ),
    Product(
      id: '22',
      name: 'Azure Hydrangea',
      description: 'Lush clouds of blue petals for a refreshing look.',
      price: 64.0,
      imageUrl: 'https://picsum.photos/seed/hydrangea/400/500',
      category: 'Boutique',
      tags: ['Blue', 'Fresh'],
    ),
    Product(
      id: '23',
      name: 'Velvet Anemone',
      description: 'Striking black-centered flowers with white petals.',
      price: 72.0,
      imageUrl: 'https://picsum.photos/seed/anemone/400/500',
      category: 'Artisanal',
      tags: ['Contrast', 'Elegant'],
    ),
    Product(
      id: '24',
      name: 'Peach Carnation',
      description: 'Soft ruffled petals in a warm pastel peach hue.',
      price: 48.0,
      imageUrl: 'https://picsum.photos/seed/carnation/400/500',
      category: 'Seasonal',
      tags: ['Pastel', 'Warm'],
    ),
    Product(
      id: '25',
      name: 'Imperial Protea',
      description: 'Exotic king protea for a bold, architectural statement.',
      price: 110.0,
      imageUrl: 'https://picsum.photos/seed/protea/400/500',
      category: 'Artisanal',
      tags: ['Exotic', 'Premium'],
    ),
    Product(
      id: '26',
      name: 'Tuscan Poppy',
      description: 'Bright red wild poppies for a rustic touch.',
      price: 52.0,
      imageUrl: 'https://picsum.photos/seed/poppy/400/500',
      category: 'Seasonal',
      tags: ['Rustic', 'Red'],
    ),
    Product(
      id: '27',
      name: 'Snowdrop Trio',
      description: 'Delicate bell-shaped blooms for winter elegance.',
      price: 45.0,
      imageUrl: 'https://picsum.photos/seed/snowdrop/400/500',
      category: 'Seasonal',
      tags: ['Winter', 'White'],
    ),
    Product(
      id: '28',
      name: 'Indigo Delphinium',
      description: 'Tall spires of deep blue blossoms.',
      price: 75.0,
      imageUrl: 'https://picsum.photos/seed/delphinium/400/500',
      category: 'Boutique',
      tags: ['Tall', 'Blue'],
    ),
    Product(
      id: '29',
      name: 'Antique Ranunculus',
      description: 'Layered petals in a vintage dusty rose shade.',
      price: 88.0,
      imageUrl: 'https://picsum.photos/seed/ranunculus/400/500',
      category: 'Artisanal',
      tags: ['Vintage', 'Rose'],
    ),
    Product(
      id: '30',
      name: 'Lemon Zest Freesia',
      description: 'Highly fragrant yellow blooms to brighten any room.',
      price: 58.0,
      imageUrl: 'https://picsum.photos/seed/freesia/400/500',
      category: 'Boutique',
      tags: ['Fragrant', 'Yellow'],
    ),
    Product(
      id: '31',
      name: 'Midnight Calla',
      description: 'Dark purple, almost black calla lilies for high drama.',
      price: 98.0,
      imageUrl: 'https://picsum.photos/seed/calla/400/500',
      category: 'Artisanal',
      tags: ['Dark', 'Luxury'],
    ),
    Product(
      id: '32',
      name: 'Sweet Pea Cloud',
      description: 'Whimsical and fragrant pastel sweet pea mix.',
      price: 62.0,
      imageUrl: 'https://picsum.photos/seed/sweetpea/400/500',
      category: 'Boutique',
      tags: ['Soft', 'Scented'],
    ),
    Product(
      id: '33',
      name: 'Dahlia Fire',
      description: 'Complex geometric petals in fiery orange and red.',
      price: 76.0,
      imageUrl: 'https://picsum.photos/seed/dahlia/400/500',
      category: 'Seasonal',
      tags: ['Geometric', 'Vibrant'],
    ),
    Product(
      id: '34',
      name: 'Silver Sage Eucalyptus',
      description: 'Aromatic silver-green leaves to complement any space.',
      price: 40.0,
      imageUrl: 'https://picsum.photos/seed/eucalyptus/400/500',
      category: 'Seasonal',
      tags: ['Green', 'Modern'],
    ),
    Product(
      id: '35',
      name: 'Blushing Astilbe',
      description: 'Feathery plumes of pink for a fairytale garden vibe.',
      price: 68.0,
      imageUrl: 'https://picsum.photos/seed/astilbe/400/500',
      category: 'Boutique',
      tags: ['Feathery', 'Pink'],
    ),
    Product(
      id: '36',
      name: 'Gothic Tulip',
      description: 'Deep maroon tulips for an alternative aesthetic.',
      price: 65.0,
      imageUrl: 'https://picsum.photos/seed/gothictulip/400/500',
      category: 'Artisanal',
      tags: ['Gothic', 'Unique'],
    ),
    Product(
      id: '37',
      name: 'Champagne Lisianthus',
      description: 'Creamy champagne blooms that look like silk.',
      price: 85.0,
      imageUrl: 'https://picsum.photos/seed/lisianthus/400/500',
      category: 'Boutique',
      tags: ['Silk', 'Cream'],
    ),
    Product(
      id: '38',
      name: 'Marigold Glow',
      description: 'Traditional bright orange marigolds for festivities.',
      price: 42.0,
      imageUrl: 'https://picsum.photos/seed/marigold/400/500',
      category: 'Seasonal',
      tags: ['Orange', 'Culture'],
    ),
    Product(
      id: '39',
      name: 'Starry Jasmine',
      description: 'Clusters of white flowers with a heavenly scent.',
      price: 55.0,
      imageUrl: 'https://picsum.photos/seed/jasmine/400/500',
      category: 'Boutique',
      tags: ['White', 'Fragrant'],
    ),
    Product(
      id: '40',
      name: 'Obsidian Calla',
      description: 'The ultimate luxury in deep black floral design.',
      price: 120.0,
      imageUrl: 'https://picsum.photos/seed/obsidian/400/500',
      category: 'Artisanal',
      tags: ['Black', 'Elite'],
    ),
    Product(
      id: '41',
      name: 'Wild Bluebells',
      description: 'Woodland charm in a delicate bunch.',
      price: 49.0,
      imageUrl: 'https://picsum.photos/seed/bluebells/400/500',
      category: 'Seasonal',
      tags: ['Wild', 'Blue'],
    ),
    Product(
      id: '42',
      name: 'Lemon Grass Lily',
      description: 'Pale yellow lilies with fresh citrus undertones.',
      price: 70.0,
      imageUrl: 'https://picsum.photos/seed/lemonly/400/500',
      category: 'Boutique',
      tags: ['Yellow', 'Zesty'],
    ),
    Product(
      id: '43',
      name: 'Frosty Succulent',
      description: 'Long-lasting silver-toned succulent arrangement.',
      price: 45.0,
      imageUrl: 'https://picsum.photos/seed/succulent/400/500',
      category: 'Artisanal',
      tags: ['Modern', 'Durable'],
    ),
    Product(
      id: '44',
      name: 'Vintage Violet',
      description: 'Classic violets in a handcrafted ceramic pot.',
      price: 53.0,
      imageUrl: 'https://picsum.photos/seed/vintageviolet/400/500',
      category: 'Boutique',
      tags: ['Vintage', 'Purple'],
    ),
    Product(
      id: '45',
      name: 'Crimson Clover',
      description: 'Bohemian style wild clover for a free spirit.',
      price: 38.0,
      imageUrl: 'https://picsum.photos/seed/clover/400/500',
      category: 'Seasonal',
      tags: ['Boho', 'Red'],
    ),
    Product(
      id: '46',
      name: 'Snowy Camellia',
      description: 'Perfectly round white blooms with glossy leaves.',
      price: 89.0,
      imageUrl: 'https://picsum.photos/seed/camellia/400/500',
      category: 'Artisanal',
      tags: ['Glossy', 'White'],
    ),
    Product(
      id: '47',
      name: 'Copper Chrysanthemum',
      description: 'Metallic-toned petals perfect for autumn decor.',
      price: 61.0,
      imageUrl: 'https://picsum.photos/seed/chrysanth/400/500',
      category: 'Seasonal',
      tags: ['Autumn', 'Copper'],
    ),
    Product(
      id: '48',
      name: 'Peppermint Orchid',
      description: 'White orchids with striking pink stripes.',
      price: 94.0,
      imageUrl: 'https://picsum.photos/seed/peppermintor/400/500',
      category: 'Artisanal',
      tags: ['Striped', 'Exotic'],
    ),
    Product(
      id: '49',
      name: 'Honey Banksia',
      description: 'Unique Australian native flower with golden texture.',
      price: 105.0,
      imageUrl: 'https://picsum.photos/seed/banksia/400/500',
      category: 'Artisanal',
      tags: ['Wild', 'Native'],
    ),
    Product(
      id: '50',
      name: 'Morning Glories',
      description: 'Fast-blooming vibrant climbers in rich blue.',
      price: 35.0,
      imageUrl: 'https://picsum.photos/seed/morningglory/400/500',
      category: 'Seasonal',
      tags: ['Morning', 'Blue'],
    ),
  ]; // keep your existing list

  final List<CartItem> _cart = [];
  final List<Product> _favorites = [];

  List<Product> get products => _products;
  List<CartItem> get cart => _cart;
  List<Product> get favorites => _favorites;

  double get cartTotal => _cart.fold(0, (sum, item) => sum + item.totalPrice);

  // ✅ CART
  void addToCart(Product product) {
    final index = _cart.indexWhere((i) => i.product.id == product.id);
    if (index >= 0) {
      _cart[index].quantity++;
    } else {
      _cart.add(CartItem(product: product));
    }
    notifyListeners();
  }

  void removeFromCart(Product product) {
    _cart.removeWhere((i) => i.product.id == product.id);
    notifyListeners();
  }

  void clearCart() {
    _cart.clear();
    notifyListeners();
  }

  void updateQuantity(Product product, int quantity) {
    final index = _cart.indexWhere((i) => i.product.id == product.id);
    if (index >= 0) {
      if (quantity <= 0) {
        _cart.removeAt(index);
      } else {
        _cart[index].quantity = quantity;
      }
      notifyListeners();
    }
  }

  // ✅ FAVORITES
  bool isFavorite(Product product) {
    return _favorites.any((p) => p.id == product.id);
  }

  void toggleFavorite(Product product) {
    if (isFavorite(product)) {
      _favorites.removeWhere((p) => p.id == product.id);
    } else {
      _favorites.add(product);
    }
    notifyListeners();
  }
}
