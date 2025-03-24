import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hava_havai_hiring_challenge/models/product_model.dart';

class CartItem {
  final Product product;
  final int quantity;

  CartItem({required this.product, this.quantity = 1});

  CartItem copyWith({Product? product, int? quantity}) {
    return CartItem(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }

  double get totalPrice => product.discountedPrice * quantity;
}

class Cart {
  final List<CartItem> items;

  Cart({this.items = const []});

  double get totalAmount => items.fold(0, (sum, item) => sum + item.totalPrice);
  
  int get itemCount => items.fold(0, (sum, item) => sum + item.quantity);
}

class CartNotifier extends StateNotifier<Cart> {
  CartNotifier() : super(Cart());

  void addProduct(Product product) {
    final items = [...state.items];
    final index = items.indexWhere((item) => item.product.id == product.id);

    if (index >= 0) {
      items[index] = items[index].copyWith(quantity: items[index].quantity + 1);
    } else {
      items.add(CartItem(product: product));
    }
    
    state = Cart(items: items);
  }

  void removeProduct(int productId) {
    final items = [...state.items];
    items.removeWhere((item) => item.product.id == productId);
    state = Cart(items: items);
  }

  void decreaseQuantity(int productId) {
    final items = [...state.items];
    final index = items.indexWhere((item) => item.product.id == productId);

    if (index >= 0) {
      if (items[index].quantity > 1) {
        items[index] = items[index].copyWith(quantity: items[index].quantity - 1);
      } else {
        items.removeAt(index);
      }
      
      state = Cart(items: items);
    }
  }

  void clearCart() {
    state = Cart();
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, Cart>((ref) {
  return CartNotifier();
});