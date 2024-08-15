import 'package:checkout/bloc/cart_cubit.dart';
import 'package:checkout/models/product.dart';
import 'package:checkout/models/promotion.dart';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PromotionCubit extends Cubit<List<Promotion>> {
  PromotionCubit() : super([]);

  void setPromotionsForCheckout(List<Promotion> promotions) {
    emit(promotions);
  }

  Promotion? promotionForProduct(Product product) {
    return state.firstWhereOrNull((promotion) => promotion.sku == product.sku);
  }

  double totalWithDiscounts(List<CartItem> cart) {
    double total = 0;
    for (var item in cart) {
      Promotion? promotion = promotionForProduct(item.product);
      DiscountPricing? promotionPricing = promotion?.apply(item, cart);
      if (promotionPricing != null && promotionPricing.discountPrice != null) {
        total += promotionPricing.discountPrice ?? 0;
      } else {
        total += item.product.price * item.quantity;
      }
    }
    return total;
  }
}
