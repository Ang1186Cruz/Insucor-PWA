import 'package:flutter/material.dart';
import 'package:flutter_shop_app/providers/products.dart';
import 'package:provider/provider.dart';
import '../widgets/product_item.dart';

class ProductsGrid extends StatelessWidget {
  final String value;
  ProductsGrid(this.value);
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = productsData.items
        .where((element) => element.description
            .toUpperCase()
            .contains((value == "") ? "" : value.toUpperCase()) ||
            element.title.toUpperCase()
            .contains((value == "") ? "" : value.toUpperCase()) 
            )
        .toList();
    return ListView.builder(
      //padding: const EdgeInsets.all(20),
      padding: EdgeInsets.only(top: 0),
      itemCount: products.length,
      itemBuilder: (_, index) {
        return ChangeNotifierProvider.value(
          value: products[index],
          child: ProductItem(),
        );
      },
    );
  }
}
