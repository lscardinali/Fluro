import 'package:checkout/bloc/cart_cubit.dart';
import 'package:checkout/bloc/promotion_cubit.dart';
import 'package:checkout/models/promotion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartItemTile extends StatelessWidget {
  const CartItemTile({super.key, required this.item});

  final CartItem item;

  @override
  Widget build(BuildContext context) {
    Promotion? promotion =
        context.read<PromotionCubit>().promotionForProduct(item.product);
    DiscountPricing? promotionPricing =
        promotion?.apply(item, context.read<CartCubit>().state);

    return Dismissible(
      background: Container(
        color: Colors.red[300],
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        child: const Icon(Icons.remove_shopping_cart_outlined,
            color: Colors.white),
      ),
      key: Key(item.product.sku),
      onDismissed: (direction) {
        context.read<CartCubit>().removeAllProduct(item.product);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${item.product.name} removed from cart'),
          ),
        );
      },
      child: ListTile(
        leading: Image.network(
          item.product.image,
          width: 64,
        ),
        title: Text(item.product.name),
        subtitle: Row(
          children: [
            if (promotionPricing != null &&
                promotionPricing.discountPrice != null) ...[
              Text(
                '£${promotionPricing.originalPrice.toStringAsFixed(2)}',
                style: const TextStyle(
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              const SizedBox(width: 8),
            ],
            Text(
              '£${(promotionPricing?.discountPrice ?? item.product.price * item.quantity).toStringAsFixed(2)}',
            ),
          ],
        ),
        trailing: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Theme.of(context).cardColor,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () {
                  context.read<CartCubit>().removeProduct(item.product);
                },
              ),
              Text(item.quantity.toString(),
                  style: const TextStyle(fontSize: 16)),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  context.read<CartCubit>().addProduct(item.product);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
