import 'package:flutter/material.dart';
import 'package:swiftcart/screens/orders_screen.dart';
import 'package:swiftcart/screens/products_overview_screen.dart';

import '../screens/profile_screen.dart';
import '../screens/wishlist_screen.dart';

class BottomNavBar extends StatefulWidget {
  static const routeName = '/bottom-navbar';
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currIndex = 0;
  final _screens = [
    const ProductsOverviewScreen(),
    const OrdersScreen(),
    const WishlistScreen(),
    const ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currIndex],
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey.shade500,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline_outlined),
            label: 'Wishlist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
        currentIndex: _currIndex,
        selectedItemColor: Colors.blue,
        onTap: ((value) {
          setState(() {
            _currIndex = value;
          });
        }),
      ),
    );
  }
}
