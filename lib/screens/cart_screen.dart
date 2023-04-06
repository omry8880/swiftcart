import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swiftcart/models/bottom_two_nav_bar.dart';
import 'package:swiftcart/providers/cart.dart' show Cart;
import 'package:swiftcart/providers/orders.dart';

import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  static const String routeName = '/cart-screen';
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Cart',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black)),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total:',
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Chip(
                        label: Text(
                          '\$${cart.totalPrice.toStringAsFixed(2)}',
                          style: const TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.blue,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const Divider(
            indent: 100,
            endIndent: 100,
            color: Colors.blue,
            thickness: 0.7,
          ),
          const SizedBox(height: 10),
          Expanded(
              child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return CartItem(
                id: cart.items.values.toList()[index].id,
                productId: cart.items.keys.toList()[index],
                title: cart.items.values.toList()[index].title,
                price: cart.items.values.toList()[index].price,
                quantity: cart.items.values.toList()[index].quantity,
                picUrl: cart.items.values.toList()[index].imageUrl,
              );
            },
            itemCount: cart.items.length,
          )),
          BottomTwoNavBar(
            headingIcon: Icons.home_outlined,
            headerOnPressed: () =>
                Navigator.of(context).pushReplacementNamed('/'),
            trailingLabel: 'Order Now',
            trailingOnPressed: cart.totalPrice > 0
                ? () {
                    Provider.of<Orders>(context, listen: false)
                        .addOrder(cart.items.values.toList(), cart.totalPrice);
                    cart.clear();
                  }
                : null,
          ),
        ],
      ),
    );
  }
}
