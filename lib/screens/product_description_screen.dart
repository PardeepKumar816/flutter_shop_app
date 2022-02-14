import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/providers/products.dart';

class ProductDescriptionScreen extends StatelessWidget {
  const ProductDescriptionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String id = ModalRoute.of(context)!.settings.arguments as String;

    final products = Provider.of<Products>(context, listen: false).findById(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(products.title),
      ),
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 300.0,
            child: Image.network(
              products.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            '\$${products.price}',
            style: TextStyle(fontSize: 20, color: Colors.grey),
          ),
          SizedBox(
            height: 8.0,
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              products.description,
              textAlign: TextAlign.center,
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}
