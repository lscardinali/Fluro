import 'package:checkout/models/product.dart';
import 'package:checkout/models/promotion.dart';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Cart {
  final List<CartItem> items;
  final List<Promotion> promotions;

  Cart({required this.items, required this.promotions});

  double get totalPrice {
    return items.fold<double>(
        0, (total, item) => total + item.product.price * item.quantity);
  }
}

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

class CartCubit extends Cubit<List<CartItem>> {
  CartCubit() : super([]);

  void addProduct(Product product) {
    final existingItem =
        state.firstWhereOrNull((carItem) => carItem.product.sku == product.sku);

    if (existingItem != null) {
      existingItem.quantity++;
      emit([...state]);
    } else {
      emit([...state, CartItem(product: product)]);
    }
  }

  void removeAllProduct(Product product) {
    emit([...state.where((item) => item.product.sku != product.sku)]);
  }

  void removeProduct(Product product) {
    final existingItem =
        state.firstWhereOrNull((carItem) => carItem.product.sku == product.sku);

    if (existingItem != null) {
      if (existingItem.quantity > 1) {
        existingItem.quantity--;
        emit([...state]);
      } else {
        emit([...state.where((item) => item.product.sku != product.sku)]);
      }
    }
  }

  void clearCart() {
    emit([]);
  }
}
