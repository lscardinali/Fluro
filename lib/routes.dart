import 'package:checkout/pages/cart_page.dart';
import 'package:checkout/pages/products_page.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String products = '/products';
  static const String cart = '/cart';

  static Map<String, WidgetBuilder> appRoutes = {
    products: (context) => const ProductsPage(),
    cart: (context) => const CartPage(),
  };
}
