import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swiftcart/models/bottom_two_nav_bar.dart';
import 'package:swiftcart/providers/cart.dart';
import 'package:swiftcart/providers/products.dart';
import 'package:swiftcart/screens/cart_screen.dart';

class ProductDetailScreen extends StatelessWidget {
  static const String routeName = '/product-detail';
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)?.settings.arguments as String;
    final loadedProduct =
        Provider.of<Products>(context, listen: false).findById(productId);
    final cart = Provider.of<Cart>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Product Details',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          height: 380,
                          child: Image.network(
                            loadedProduct.imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '\$${loadedProduct.price}',
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            loadedProduct.title,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 94, 88, 88),
                                fontSize: 25),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          const Text(
                            'Select Size',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.start,
                            spacing: 20,
                            children: [
                              FilterChip(
                                label: const Text(
                                  'S',
                                  style: TextStyle(fontSize: 15),
                                ),
                                padding: const EdgeInsets.all(10.0),
                                onSelected: (bool value) {},
                              ),
                              FilterChip(
                                label: const Text(
                                  'M',
                                  style: TextStyle(fontSize: 15),
                                ),
                                autofocus: true,
                                padding: const EdgeInsets.all(10.0),
                                onSelected: (bool value) {},
                              ),
                              FilterChip(
                                label: const Text(
                                  'L',
                                  style: TextStyle(fontSize: 15),
                                ),
                                autofocus: true,
                                padding: const EdgeInsets.all(10.0),
                                onSelected: (bool value) {},
                              ),
                              FilterChip(
                                label: const Text(
                                  'XL',
                                  style: TextStyle(fontSize: 15),
                                ),
                                autofocus: true,
                                padding: const EdgeInsets.all(10.0),
                                onSelected: (bool value) {},
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          const Text(
                            'Description',
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            loadedProduct.description,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 17),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          BottomTwoNavBar(
              headingIcon: Icons.add_shopping_cart_outlined,
              headerOnPressed: () {
                cart.addItem(loadedProduct.id, loadedProduct.title,
                    loadedProduct.price, loadedProduct.imageUrl);
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  behavior: SnackBarBehavior.floating,
                  duration: const Duration(seconds: 1),
                  margin: const EdgeInsets.only(
                      bottom: 55, top: 0, left: 0, right: 0),
                  backgroundColor: Colors.blue,
                  content: Text('${loadedProduct.title} added to cart.'),
                  action: SnackBarAction(
                    textColor: Colors.white,
                    label: 'UNDO',
                    onPressed: () {
                      cart.removeSingleItem(loadedProduct.id);
                    },
                  ),
                ));
              },
              trailingLabel: 'Buy Now',
              trailingOnPressed: (() => {
                    cart.addItem(loadedProduct.id, loadedProduct.title,
                        loadedProduct.price, loadedProduct.imageUrl),
                    Navigator.of(context)
                        .pushReplacementNamed(CartScreen.routeName)
                  }))
        ],
      ),
    );
  }
}
