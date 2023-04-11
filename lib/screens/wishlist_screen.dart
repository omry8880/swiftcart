import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swiftcart/utils/colors_util.dart';

import '../providers/products.dart';
import '../widgets/products_gridview.dart';

class WishlistScreen extends StatefulWidget {
  // UNFINISHED AND SHOULD BE CHANGED BEFORE RELEASE
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  var _isLoading = false;
  final favLength = 0;

  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });
    //
    Provider.of<Products>(context, listen: false)
        .fetchProducts()
        .then((_) => setState((() => _isLoading = false)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsUtil().backgroundColor,
      appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Wishlist',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black)),
      body: Column(children: [
        Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : const ProductsGridView(
                    showFav: true,
                  ))
      ]),
    );
  }
}
