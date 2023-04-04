import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swiftcart/models/card_slide_show.dart';
import 'package:swiftcart/providers/products.dart';
import 'package:badges/badges.dart' as badges;
import 'package:swiftcart/screens/cart_screen.dart';
import 'package:swiftcart/screens/user_products_screen.dart';
import 'package:swiftcart/utils/colors_util.dart';
import 'package:swiftcart/widgets/category_widget_item.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';
import '../providers/cart.dart';
import '../widgets/products_gridview.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

enum FilterOptions { favorites, all }

class ProductsOverviewScreen extends StatefulWidget {
  const ProductsOverviewScreen({super.key});

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  bool _showOnlyFavorites = false;
  var _isLoading = false;

  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });
    Provider.of<Products>(context, listen: false)
        .fetchProducts()
        .then((_) => setState((() => _isLoading = false)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //final productsContainer = Provider.of<Products>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: SizedBox(
          height: 45,
          child: TextField(
            textInputAction: TextInputAction.done,
            autofocus: false,
            textAlignVertical: TextAlignVertical.bottom,
            style: TextStyle(color: Theme.of(context).hintColor),
            autocorrect: false,
            enableSuggestions: false,
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                hintText: 'Search...',
                filled: true,
                fillColor: ColorsUtil().containerColor,
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(15.0))),
          ),
        ),
        actions: [
          Row(children: [
            Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: ColorsUtil().containerColor),
              child: IconButton(
                icon: const Icon(
                  Icons.shopping_basket_outlined,
                  color: Colors.black,
                ),
                splashColor: Colors.transparent,
                splashRadius: 1,
                onPressed: () {
                  Navigator.of(context).push(SwipeablePageRoute(
                    canOnlySwipeFromEdge: true,
                    builder: (BuildContext context) =>
                        const UserProductsScreen(),
                  ));
                },
              ),
            ),
            const SizedBox(width: 8),
            Consumer<Cart>(
              builder: ((context, value, child) => badges.Badge(
                    badgeAnimation: const badges.BadgeAnimation.scale(),
                    showBadge: value.itemCount == 0 ? false : true,
                    position: badges.BadgePosition.topEnd(top: 1, end: 1),
                    badgeContent: Text(value.itemCount.toString()),
                    child: child,
                  )),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: ColorsUtil().containerColor),
                  child: IconButton(
                    icon: const Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.black,
                    ),
                    splashColor: Colors.transparent,
                    splashRadius: 1,
                    onPressed: () {
                      Navigator.of(context).push(SwipeablePageRoute(
                        canOnlySwipeFromEdge: true,
                        builder: (BuildContext context) => const CartScreen(),
                      ));
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),
          ]),
        ],
      ),
      body: Column(
        children: [
          const ImageSlideshow(
              height: 180,
              autoPlayInterval: 10000,
              isLoop: true,
              indicatorColor: Colors.transparent,
              indicatorBackgroundColor: Colors.transparent,
              children: [
                CardSlideShow(
                    header: 'New Summer \n23\' collection',
                    description: 'Find the brand new collection',
                    label: 'Shop Now',
                    imageUrl:
                        'https://hips.hearstapps.com/hmg-prod/images/celine-women-summer23-web-11-1668785237.jpg?crop=1.00xw:0.754xh;0,0.227xh&resize=1200:*'),
                CardSlideShow(
                    header: 'Beach Clothes \nGrand Sale!',
                    description: 'Don\'t miss biggest sale yet!',
                    label: 'Find more...',
                    imageUrl:
                        'https://cdn.shopify.com/s/files/1/2294/8559/files/230203-navigation-new-arrivals-women_1_2048x2048.jpg?v=1675455329'),
                CardSlideShow(
                    header: 'Discounts on \n199\$+ orders only now!',
                    description: 'Valid until August 7, 2024.',
                    label: 'Get Ready for Summer',
                    imageUrl:
                        'https://www.thefashionisto.com/wp-content/uploads/2022/05/HM-Men-Magic-Isle-Beach-Collection-2022-003.jpg')
              ]),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Shop by Category',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 55,
                child: ListView.separated(
                  // hardcoded item count
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: ((context, index) {
                    return CategoryWidgetItem(
                        icon: const Icon(Icons.favorite), action: () {});
                  }),
                  itemCount: 7,
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(width: 16);
                  },
                ),
              ),
              const SizedBox(
                height: 15,
              ),
            ]),
          ),
          Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : const ProductsGridView())
        ],
      ),
    );
  }
}
