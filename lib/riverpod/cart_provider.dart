import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cartify_app/model/items.dart';

// Cart Notifier
class CartNotifier extends StateNotifier<List<Product>> {
  CartNotifier() : super([]);

  void addToCart(Product product) {
    state = [...state, product];  // ✅ Adds item to cart
    print("Added: ${product.title}, Cart now has: ${state.length} items.");
  }

  void removeFromCart(Product product) {
    state = state.where((item) => item.id != product.id).toList();
    print("Removed: ${product.title}, Cart now has: ${state.length} items.");
  }

  void clearCart() {
    state = [];
    print("Cart is now empty.");
  }
}

// Cart Provider
final cartProvider = StateNotifierProvider<CartNotifier, List<Product>>((ref) {
  return CartNotifier();
});

// Total Price Provider
final totalPriceProvider = Provider<double>((ref) {
  final cartItems = ref.watch(cartProvider);
  return cartItems.fold(0, (sum, item) => sum + (item.price! * 85.78));
});
