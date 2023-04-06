import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swiftcart/providers/cart.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final String title;
  final double price;
  final int quantity;
  final String picUrl;

  const CartItem(
      {super.key,
      required this.productId,
      required this.id,
      required this.title,
      required this.price,
      required this.quantity,
      required this.picUrl});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      onDismissed: ((direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      }),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        color: Theme.of(context).colorScheme.error,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      direction: DismissDirection.endToStart,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                picUrl,
                height: 50,
                width: 40,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(
              title,
              style: const TextStyle(color: Colors.black),
            ),
            subtitle: Text('\$${(price * quantity).toStringAsFixed(2)}',
                style: const TextStyle(color: Colors.grey)),
            trailing: Text('$quantity x',
                style: const TextStyle(color: Colors.black)),
          ),
        ),
      ),
    );
  }
}
