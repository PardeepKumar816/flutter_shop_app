import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/orders.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/screens/product_overview_screen.dart';

import 'routes.dart';

void main() {
  runApp(MainClass());
}

class MainClass extends StatelessWidget {
  const MainClass({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Products>(
          create: (context) => Products(),
        ),
        ChangeNotifierProvider<Cart>(
          create: (context) => Cart(),
        ),
        ChangeNotifierProvider(create: (context) => Orders()),
        //ChangeNotifierProvider(create: (context)=> )
      ],
      child: MaterialApp(
        theme: ThemeData(fontFamily: 'Lato'),
        title: 'Shop App',
        debugShowCheckedModeBanner: false,
        home: ProductOverViewScreen(),
        routes: Routes.getRoutes(context),
      ),
    );
  }
}
