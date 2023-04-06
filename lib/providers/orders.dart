import 'dart:convert';
import 'dart:developer';
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
      if (data.isEmpty) {
        _orders = [];
        notifyListeners();
        return;
      }
      final List<OrderItem> loadedOrders = [];
      data.forEach((orderId, orderData) {
        loadedOrders.add(OrderItem(
          id: orderId,
          amount: orderData['price'],
          products: (orderData['products'] as List<dynamic>)
              .map((item) => CartItem(
                  id: item['id'],
                  title: item['title'],
                  price: item['price'],
                  quantity: item['quantity'],
                  imageUrl: item['imageUrl']))
              .toList(),
          dateTime: DateTime.parse(orderData['time']),
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
            'products': cartProducts
                .map((e) => {
                      'id': e.id,
                      'title': e.title,
                      'price': e.price,
                      'quantity': e.quantity,
                      'imageUrl': e.imageUrl
                    })
                .toList(),
            'time': timestamp.toIso8601String(),
          }));

      final newOrder = OrderItem(
          id: json.decode(response.body)['name'],
          amount: total,
          dateTime: timestamp,
          products: cartProducts);
      _orders.insert(0, newOrder);
      notifyListeners();
    } catch (error) {
      const HttpException('Could not manage to add order.');
    }
  }
}
