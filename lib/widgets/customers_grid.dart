import 'package:flutter/material.dart';
import 'package:flutter_shop_app/providers/customers.dart';
import 'package:provider/provider.dart';
import '../widgets/customer_item.dart';

class CustomersGrid extends StatelessWidget {
  final String value;
  CustomersGrid(this.value);
  @override
  Widget build(BuildContext context) {
    final customersData = Provider.of<Customers>(context);
    final customers = customersData.items
        .where((element) => element.nombre
            .toUpperCase()
            .contains((value == "") ? "" : value.toUpperCase())
            || element.empresa.toUpperCase()
            .contains((value == "") ? "" : value.toUpperCase())
            )
        .toList();
    bool customerSelect =
        customers.any((element) => element.isAgregate == true);
    // final Customers =
    //     Customers1.where((element) => element.title.contains(value)).toList();
    return ListView.builder(
      //padding: const EdgeInsets.all(20),
      padding: EdgeInsets.only(top: 0),
      itemCount: customers.length,
      itemBuilder: (_, index) {
        return ChangeNotifierProvider.value(
          value: customers[index],
          child: CustomerItem('',customerSelect),
        );
      },
    );
  }
}
