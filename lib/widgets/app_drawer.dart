import 'package:flutter/material.dart';
import 'package:flutter_shop_app/providers/cart.dart';
import 'package:flutter_shop_app/providers/customers.dart';
import 'package:flutter_shop_app/providers/products.dart';
import 'package:flutter_shop_app/screens/products_overview_screen.dart';
import '../providers/auth.dart';
import '../screens/orders_screen.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text("Menú"),
            automaticallyImplyLeading: false,
          ),
          // Divider(),
          ListTile(
            leading: Icon(Icons.person),
            title: Text("Clientes"),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed('/');
            },
          ),
          Divider(),
           ListTile(
            leading: Icon(Icons.shop),
            title: Text("Productos"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(ProductsOverviewScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text("Ordenes"),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(OrdersScreen.routeName);
            },
          ),

          Divider(),
           ListTile(
             leading: Icon(Icons.car_repair),
             title: Text("Reparto"),
             onTap: () {
               Navigator.of(context)
                   .pushReplacementNamed(OrdersScreen.routeName);
             },
           ),

           Divider(),
           ListTile(
             leading: Icon(Icons.attach_money),
             title: Text("Cobro"),
             onTap: () {
               Navigator.of(context)
                   .pushReplacementNamed(OrdersScreen.routeName);
             },
           ),

          // Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text("Salir"),
            onTap: () {
              Navigator.of(context).pop();
              Provider.of<Auth>(context, listen: false).logout();
              Provider.of<Customers>(context,listen: false).clearCustomer("");
               Provider.of<Products>(context, listen: false).clearProducts();
               Provider.of<Cart>(context, listen: false).clearCart();
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          Divider()
        ],
      ),
    );
  }
}
