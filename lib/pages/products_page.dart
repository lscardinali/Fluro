import 'package:checkout/bloc/cart_cubit.dart';
import 'package:checkout/bloc/promotion_cubit.dart';
import 'package:checkout/components/product_tile.dart';
import 'package:checkout/models/promotion.dart';
import 'package:checkout/services/product_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NeighborMarket'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 2, mainAxisSpacing: 2),
            itemBuilder: (context, index) {
              final product = ProductRepository().getProducts()[index];
              return ProductTile(product: product);
            },
            itemCount: ProductRepository().getProducts().length),
      ),
      floatingActionButton: BlocBuilder<CartCubit, List<CartItem>>(
        builder: (context, state) {
          return Badge(
            label: Text(state
                .fold(0, (previous, item) => previous + item.quantity)
                .toString()),
            child: FloatingActionButton(
              onPressed: () {
                // Set a New Set of Promotion Rules for the Checkout
                context.read<PromotionCubit>().setPromotionsForCheckout([
                  MultiPricedRule(
                      quantityRequired: 2, newPrice: 1.25, sku: 'B'),
                  BuyGetOneRule(quantityRequired: 3, sku: 'C'),
                  MealDealRule(
                      skuCombination: ['D', 'E'], newPrice: 3, sku: 'D'),
                  MealDealRule(
                      skuCombination: ['D', 'E'], newPrice: 3, sku: 'E'),
                ]);
                Navigator.pushNamed(context, '/cart');
              },
              child: const Icon(Icons.shopping_cart_outlined),
            ),
          );
        },
      ),
    );
  }
}
