import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cartify_app/model/items.dart';

// Cart Notifier using a Map to track quantity
class CartNotifier extends StateNotifier<Map<Product, int>> {
  CartNotifier() : super({});

  void addToCart(Product product) {
    state = {
      ...state,
      product: (state[product] ?? 0) + 1, // Increment quantity
    };
  }

  void removeFromCart(Product product) {
    if (!state.containsKey(product)) return;

    final updatedQuantity = state[product]! - 1;
    if (updatedQuantity > 0) {
      state = {...state, product: updatedQuantity};
    } else {
      final newState = {...state};
      newState.remove(product);
      state = newState;
    }
  }

  void clearCart() {
    state = {};
  }
}

// Cart Provider
final cartProvider = StateNotifierProvider<CartNotifier, Map<Product, int>>(
        (ref) => CartNotifier());

// Total Price Provider
final totalPriceProvider = Provider<double>((ref) {
  final cartItems = ref.watch(cartProvider);
  return cartItems.entries.fold(
      0, (sum, entry) => sum + (entry.key.price! * 85.78 * entry.value));
});
