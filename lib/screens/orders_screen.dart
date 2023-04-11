import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swiftcart/providers/orders.dart' show Orders;
import 'package:swiftcart/widgets/order_item.dart';

class OrdersScreen extends StatefulWidget {
  static const String routeName = '/orders-screen';
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  Future<void> refreshPage(BuildContext context) async {
    await Provider.of<Orders>(context, listen: false).fetchOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        title: const Text(
          'Order History',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: RefreshIndicator(
          onRefresh: () => refreshPage(context),
          child: FutureBuilder(
            future: Provider.of<Orders>(context, listen: false).fetchOrders(),
            builder: (context, dataSnapshot) {
              if (dataSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (dataSnapshot.error != null) {
                  return const Center(child: Text('An error occured.'));
                } else {
                  return Consumer<Orders>(builder: (context, orderData, child) {
                    return ListView.builder(
                      itemBuilder: ((context, index) =>
                          OrderItem(order: orderData.orders[index])),
                      itemCount: orderData.orders.length,
                    );
                  });
                }
              }
            },
          )),
    );
  }
}
