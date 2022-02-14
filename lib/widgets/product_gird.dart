import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/widgets/product_item.dart';

class ProductGird extends StatelessWidget {
  const ProductGird({Key? key, required this.showFav}) : super(key: key);

  final bool showFav;

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final loadedProducts =
        (showFav) ? productsData.favoriteItems : productsData.items;

    return GridView.builder(
      padding: EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16),
      itemBuilder: (context, index) {
        return ChangeNotifierProvider.value(
          child: ProductItem(),
          value: loadedProducts[index],
        );
      },
      itemCount: loadedProducts.length,
    );
  }
}
