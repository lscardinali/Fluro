import 'package:checkout/bloc/cart_cubit.dart';
import 'package:checkout/bloc/promotion_cubit.dart';
import 'package:checkout/models/product.dart';
import 'package:checkout/models/promotion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductTile extends StatelessWidget {
  const ProductTile({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    Promotion? promotion =
        context.read<PromotionCubit>().promotionForProduct(product);

    return Card(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(child: Image.network(product.image)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(product.name, style: Theme.of(context).textTheme.labelLarge),
              if (promotion != null) promotionBadge(promotion.promotionLabel)
            ],
          ),
        ),
        Row(children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('£${product.price.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.titleLarge),
              )),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: 8.0, bottom: 8.0),
            child: FilledButton(
              child: const Icon(
                Icons.add_shopping_cart,
                size: 20,
              ),
              onPressed: () {
                context.read<CartCubit>().addProduct(product);
              },
            ),
          ),
        ]),
      ],
    ));
  }

  Widget promotionBadge(String text) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
        color: Colors.red,
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 8.0,
          ),
        ),
      ),
    );
  }
}
