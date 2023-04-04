import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../providers/product.dart';
import '../screens/product_detail_screen.dart';
import 'package:http/http.dart' as http;

class ProductItem extends StatelessWidget {
  const ProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: true);
    final cart = Provider.of<Cart>(context, listen: false);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(23)),
      elevation: 3,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(ProductDetailScreen.routeName,
                arguments: product.id);
          },
          child: GridTile(
            header: Container(
              alignment: Alignment.topRight,
              child: Consumer<Product>(
                builder: ((context, value, child) {
                  return IconButton(
                    onPressed: () {
                      product.toggleFavoriteStatus();
                    },
                    icon: Icon(
                      product.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color:
                          product.isFavorite ? Colors.redAccent : Colors.grey,
                    ),
                  );
                }),
              ),
            ),
            footer: GridTileBar(
              backgroundColor: Colors.white,
              title: Text(
                product.title,
                textAlign: TextAlign.start,
                style: const TextStyle(color: Colors.black, fontSize: 17),
              ),
              trailing: IconButton(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 11),
                onPressed: () {
                  cart.addItem(product.id, product.title, product.price,
                      product.imageUrl);
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    duration: const Duration(seconds: 1),
                    backgroundColor: Colors.blue,
                    content: Text('${product.title} added to cart.'),
                    action: SnackBarAction(
                      textColor: Colors.white,
                      label: 'UNDO',
                      onPressed: () {
                        cart.removeSingleItem(product.id);
                      },
                    ),
                  ));
                },
                icon: const Icon(
                  Icons.add_shopping_cart_outlined,
                  color: Colors.blue,
                ),
                alignment: Alignment.bottomRight,
              ),
            ),
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
