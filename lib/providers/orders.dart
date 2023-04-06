import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:swiftcart/providers/cart.dart';
import 'package:http/http.dart' as http;

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem(
      {required this.id,
      required this.amount,
      required this.products,
      required this.dateTime});
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  final db = Uri.parse(
      'https://swiftcart-3463d-default-rtdb.firebaseio.com/orders.json');

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchOrders() async {
    try {
      final response = await http.get(db);
      final data = json.decode(response.body) as Map<String, dynamic>;
      final List<OrderItem> loadedOrders = [];
      data.forEach((orderId, orderData) {
        loadedOrders.add(OrderItem(
          id: orderId,
          amount: orderData['price'],
          dateTime: DateTime.parse(orderData['time']),
          products: (orderData['products'] as List<dynamic>)
              .map((e) => CartItem(
                  id: e.id,
                  title: e.title,
                  quantity: e.quantity,
                  price: e.price,
                  imageUrl: e.imageUrl))
              .toList(),
        ));
      });
      _orders = loadedOrders;
      notifyListeners();
    } catch (error) {
      const HttpException('Could not manage to fetch orders from server.');
    }
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final timestamp = DateTime.now();
    try {
      final response = await http.post(db,
          body: json.encode({
            'price': total,
            'time': timestamp.toIso8601String(),
            'products': cartProducts
                .map((e) => json.encode({
                      'id': e.id,
                      'title': e.title,
                      'price': e.price,
                      'quantity': e.quantity,
                      'imageUrl': e.imageUrl
                    }))
                .toList(),
          }));

      _orders.insert(
          0,
          OrderItem(
              id: json.decode(response.body)['name'],
              amount: total,
              dateTime: timestamp,
              products: cartProducts));
      notifyListeners();
    } catch (error) {
      const HttpException('Could not manage to add order.');
    }
  }
}
