import 'package:flutter/cupertino.dart';
import 'package:shop_app/screens/edit_product_screen.dart';
import 'package:shop_app/screens/order_screen.dart';

import 'screens/cart_screen.dart';
import 'screens/product_description_screen.dart';
import 'screens/product_overview_screen.dart';
import 'screens/user_product_screen.dart';

class Routes {
  static String productDescriptionScreen = '/ProductDescriptionScreen';
  static String cartScreen = '/CartScreen';
  static String orderScreen = '/OrderScreen';
  static String productOverViewScreen = '/ProductOverViewScreen';
  static String editProductScreen = '/EditProductScreen';
  static String userProductScreen = '/UserProductScreen';

  static getRoutes(BuildContext context) => {
        productDescriptionScreen: (context) => ProductDescriptionScreen(),
        //productOverViewScreen: (context) => ProductOverViewScreen(),
        cartScreen: (context) => const CartScreen(),
        orderScreen: (context) => const OrderScreen(),
        editProductScreen: (context) => EditProductScreen(),
        userProductScreen: (context) => UserProductScreen()
      };
}
