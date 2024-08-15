import 'package:checkout/bloc/cart_cubit.dart';
import 'package:checkout/bloc/promotion_cubit.dart';
import 'package:checkout/components/cart_item_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: BlocBuilder<CartCubit, List<CartItem>>(builder: (context, cart) {
        if (cart.isEmpty) {
          return const Center(
            child: Text('Cart is empty, add some items!'),
          );
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ListView(
                  children:
                      cart.map((item) => CartItemTile(item: item)).toList(),
                ),
              ),
              Card(
                elevation: 4,
                margin: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    cartTotalTile(cart, context),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      child: FilledButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Checkout successful!')));
                            context.read<CartCubit>().clearCart();
                          },
                          child: const Text("Checkout")),
                    )
                  ],
                ),
              ),
            ],
          );
        }
      }),
    );
  }

  ListTile cartTotalTile(List<CartItem> items, BuildContext context) {
    return ListTile(
      title: const Text('Total:'),
      trailing: Text(
          '£${context.read<PromotionCubit>().totalWithDiscounts(items).toStringAsFixed(2)}',
          style: Theme.of(context).textTheme.titleLarge),
    );
  }
}
