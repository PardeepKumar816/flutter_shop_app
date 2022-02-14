import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/routes.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/badge.dart';
import 'package:shop_app/widgets/product_gird.dart';
import 'package:shop_app/widgets/product_item.dart';

enum FilterOption { Favorites, All }

class ProductOverViewScreen extends StatefulWidget {
  ProductOverViewScreen({Key? key}) : super(key: key);

  @override
  State<ProductOverViewScreen> createState() => _ProductOverViewScreenState();
}

class _ProductOverViewScreenState extends State<ProductOverViewScreen> {
  bool _showFavoriteOnly = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop'),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                (12),
              ),
            ),
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: Text('Show Favourite only'),
                  value: FilterOption.Favorites,
                ),
                PopupMenuItem(
                  child: Text('Show All'),
                  value: FilterOption.All,
                ),
              ];
            },
            icon: Icon(Icons.more_vert),
            onSelected: (v) {
              if (v == FilterOption.Favorites) {
                setState(() {
                  _showFavoriteOnly = true;
                });
              } else {
                setState(() {
                  _showFavoriteOnly = false;
                });
              }
            },
          ),
          Consumer<Cart>(
            builder: (context, cart, child) => Badge(
              child: child!,
              value: cart.itemCount,
            ),
            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.cartScreen);
              },
              icon: const Icon(Icons.shopping_cart),
            ),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: ProductGird(
        showFav: _showFavoriteOnly,
      ),
    );
  }
}
