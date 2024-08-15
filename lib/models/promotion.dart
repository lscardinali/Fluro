import 'package:checkout/bloc/cart_cubit.dart';

class DiscountPricing {
  final double originalPrice;
  final double? discountPrice;

  DiscountPricing({required this.originalPrice, this.discountPrice});
}

abstract class Promotion {
  final String sku;

  Promotion({required this.sku});
  String get promotionLabel;
  DiscountPricing Function(CartItem item, List<CartItem> cart) get apply;
}

class MultiPricedRule extends Promotion {
  final int quantityRequired;
  final double newPrice;

  MultiPricedRule(
      {required this.quantityRequired,
      required this.newPrice,
      required super.sku});

  @override
  DiscountPricing Function(CartItem item, List<CartItem> cart) get apply =>
      (item, cartItems) {
        if (item.quantity >= quantityRequired) {
          double discountPrice = 0;

          if (item.quantity % quantityRequired == 0) {
            discountPrice = (item.quantity / quantityRequired) * newPrice;
          } else {
            discountPrice = (item.quantity ~/ quantityRequired) * newPrice +
                item.product.price * (item.quantity % quantityRequired);
          }
          return DiscountPricing(
              originalPrice: item.product.price * item.quantity,
              discountPrice: discountPrice);
        } else {
          return DiscountPricing(
              originalPrice: item.product.price * item.quantity);
        }
      };

  @override
  String get promotionLabel => "Multi";
}

class BuyGetOneRule extends Promotion {
  final int quantityRequired;

  BuyGetOneRule({required this.quantityRequired, required super.sku});

  @override
  DiscountPricing Function(CartItem item, List<CartItem> cart) get apply =>
      (item, cartItems) {
        if (item.quantity >= quantityRequired) {
          if (item.quantity % quantityRequired == 0) {
            return DiscountPricing(
                originalPrice: item.product.price * item.quantity,
                discountPrice: item.quantity * item.product.price -
                    (item.product.price * (item.quantity / quantityRequired)));
          } else {
            return DiscountPricing(
                originalPrice: item.product.price * item.quantity,
                discountPrice: item.quantity * item.product.price -
                    (item.product.price * (item.quantity ~/ quantityRequired)));
          }
        } else {
          return DiscountPricing(
              originalPrice: item.product.price * item.quantity);
        }
      };

  @override
  String get promotionLabel => "Buy Get One";
}

class MealDealRule extends Promotion {
  final List<String> skuCombination;
  final double newPrice;

  MealDealRule(
      {required this.skuCombination,
      required this.newPrice,
      required super.sku});

  @override
  DiscountPricing Function(CartItem item, List<CartItem> cart) get apply =>
      (item, cartItems) {
        final items = cartItems
            .where((item) => skuCombination.contains(item.product.sku));

        if (items.length == skuCombination.length) {
          final groups = items.fold<int>(
              double.maxFinite.toInt(),
              (previous, item) =>
                  item.quantity < previous ? item.quantity : previous);

          return DiscountPricing(
              originalPrice: item.product.price * item.quantity,
              discountPrice:
                  ((groups * newPrice) / skuCombination.length.floor()) +
                      ((item.quantity - groups) * item.product.price));
        } else {
          return DiscountPricing(
              originalPrice: item.product.price * item.quantity);
        }
      };

  @override
  String get promotionLabel => "Meal Deal";
}
