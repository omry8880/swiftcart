import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swiftcart/providers/products.dart';
import 'package:swiftcart/widgets/product_item.dart';

class ProductsGridView extends StatelessWidget {
  final bool showFav;
  const ProductsGridView({super.key, this.showFav = false});

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = showFav ? productsData.favoriteItems : productsData.items;

    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
          crossAxisSpacing: 10,
          mainAxisSpacing: 20),
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
          value: products[i], child: const ProductItem()),
      itemCount: products.length,
      padding: const EdgeInsets.all(10.0),
    );
  }
}
