import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'product.dart';

class Products with ChangeNotifier {
  // ignore: prefer_final_fields
  List<Product> _items = [];
  final String authToken;
  final String userId;

  Products(this.authToken, this.userId, this._items);

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((element) => element.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  Future<void> fetchProducts([bool filterByUser = false]) async {
    final filterString =
        filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';
    try {
      final response = await http.get(Uri.parse(
          'https://swiftcart-3463d-default-rtdb.firebaseio.com/products.json?auth=$authToken&$filterString'));
      final data = json.decode(response.body) as Map<String, dynamic>;
      final favoriteResponse = await http.get(Uri.parse(
          'https://swiftcart-3463d-default-rtdb.firebaseio.com/userFavorites/$userId.json?auth=$authToken'));
      final favoriteData = json.decode(favoriteResponse.body);
      final List<Product> loadedProducts = [];
      data.forEach((productId, productData) {
        loadedProducts.insert(
            0,
            Product(
              id: productId,
              title: productData['title'],
              description: productData['description'],
              price: productData['price'],
              imageUrl: productData['imageUrl'],
              isFavorite: favoriteData == null
                  ? false
                  : favoriteData[productId] ?? false,
            ));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> addProduct(Product p) async {
    try {
      final response = await http.post(
          Uri.parse(
              'https://swiftcart-3463d-default-rtdb.firebaseio.com/products.json?auth=$authToken'),
          body: json.encode({
            'title': p.title,
            'description': p.description,
            'price': p.price,
            'imageUrl': p.imageUrl,
            //'isFavorite': p.isFavorite
            'creatorId': userId,
          }));

      final newProduct = Product(
          id: json.decode(response.body)['name'],
          title: p.title,
          description: p.description,
          price: p.price,
          imageUrl: p.imageUrl);
      _items.insert(0, newProduct);
      notifyListeners();
    } catch (error) {
      //
    }
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = _items.indexWhere((element) => element.id == id);
    final url = Uri.parse(
        'https://swiftcart-3463d-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken');
    await http.patch(url,
        body: json.encode({
          'title': newProduct.title,
          'description': newProduct.description,
          'price': newProduct.price,
          'imageUrl': newProduct.imageUrl,
        }));
    _items[prodIndex] = newProduct;
    notifyListeners();
  }

  Future<void> deleteProduct(String productId) async {
    final url = Uri.parse(
        'https://swiftcart-3463d-default-rtdb.firebaseio.com/products/$productId.json?auth=$authToken');
    final existingProductIndex =
        _items.indexWhere((element) => element.id == productId);
    Product? existingProduct = _items[existingProductIndex];

    _items.removeAt(existingProductIndex);
    notifyListeners();

    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw const HttpException('Could not delete product.');
    }
    existingProduct = null;
  }
}
