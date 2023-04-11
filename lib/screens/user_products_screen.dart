import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swiftcart/providers/products.dart';
import 'package:swiftcart/widgets/user_product_item.dart';

import 'edit_product_screen.dart';

class UserProductsScreen extends StatelessWidget {
  static const String routeName = '/user-products-screen';
  const UserProductsScreen({super.key});

  Future<void> refreshPage(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).fetchProducts(true);
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.black),
          title: const Text(
            'My Products',
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(EditProductScreen.routeName);
                },
                icon: const Icon(Icons.add)),
          ],
        ),
        body: FutureBuilder(
          future: refreshPage(context),
          builder: (context, snapshot) => snapshot.connectionState ==
                  ConnectionState.waiting
              ? const Center(child: CircularProgressIndicator())
              : RefreshIndicator(
                  onRefresh: () => refreshPage(context),
                  child: Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: Consumer(
                      builder: (BuildContext context, value, Widget? child) {
                        return ListView.builder(
                            itemCount: productsData.items.length,
                            itemBuilder: ((context, index) {
                              return UserProductItem(
                                  id: productsData.items[index].id,
                                  title: productsData.items[index].title,
                                  imageUrl: productsData.items[index].imageUrl);
                            }));
                      },
                    ),
                  ),
                ),
        ));
  }
}
