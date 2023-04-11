import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:swiftcart/models/bottom_nav_bar.dart';
import 'package:swiftcart/providers/auth.dart';
import 'package:swiftcart/providers/cart.dart';
import 'package:swiftcart/providers/orders.dart';
import 'package:swiftcart/providers/products.dart';
import 'package:swiftcart/screens/auth_screen.dart';
import 'package:swiftcart/screens/cart_screen.dart';
import 'package:swiftcart/screens/edit_product_screen.dart';
import 'package:swiftcart/screens/orders_screen.dart';
import 'package:swiftcart/screens/product_detail_screen.dart';
import 'package:swiftcart/screens/splash_screen.dart';
import 'package:swiftcart/screens/user_products_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => Auth()),
          ChangeNotifierProxyProvider<Auth, Products>(
            update: (context, value, previous) => Products(value.token ?? '',
                value.userId ?? '', previous == null ? [] : previous.items),
            create: (context) => Products('', '', []),
          ),
          ChangeNotifierProvider(create: ((context) => Cart())),
          ChangeNotifierProxyProvider<Auth, Orders>(
              update: (context, value, previous) => Orders(value.token ?? '',
                  previous == null ? [] : previous.orders, value.userId ?? ''),
              create: ((context) => Orders('', [], ''))),
        ],
        child: Consumer<Auth>(
          builder: (context, value, _) => MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primaryColor: const Color.fromRGBO(249, 245, 235, 1),
              textTheme: GoogleFonts.montserratTextTheme(
                  Theme.of(context).primaryTextTheme),
              primarySwatch: Colors.blue,
            ),
            routes: {
              '/': (context) => value.isAuth
                  ? const BottomNavBar()
                  : FutureBuilder(
                      builder: (context, snapshot) {
                        return snapshot.connectionState ==
                                ConnectionState.waiting
                            ? const SplashScreen()
                            : const AuthScreen();
                      },
                      future: value.tryAutoLogin(),
                    ),
              ProductDetailScreen.routeName: (context) =>
                  const ProductDetailScreen(),
              CartScreen.routeName: (context) => const CartScreen(),
              OrdersScreen.routeName: (context) => const OrdersScreen(),
              UserProductsScreen.routeName: ((context) =>
                  const UserProductsScreen()),
              EditProductScreen.routeName: (context) =>
                  const EditProductScreen(),
            },
          ),
        ));
  }
}
