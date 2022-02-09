import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_shop_app/providers/products.dart';
import 'package:flutter_shop_app/providers/customers.dart';
import 'package:flutter_shop_app/providers/message.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';
import '../screens/cart_screen.dart';
import '../widgets/app_drawer.dart';
import '../widgets/badge.dart';
import '../widgets/products_grid.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  static const routeName = "./products";
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _searchName = "";
  var _isInit = true;
  var _isLoading = false;
  //bool typing = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      debugger();
      final customer = Provider.of<Customers>(context);
      if (customer.customerActive == null) {
        MessageWidget.error(
            context, "PARA VER LOS PRODUCTOS DEBE SELECCIONAR UN CLIENTE", 10);
      } else {
        Provider.of<Customers>(context)
            .refreshCustomer(customer.customerActive.id)
            .then((_) {
          setState(() {
            debugger();
            customer.customerActive =
                customer.findById(customer.customerActive.id);
            if (customer.customerActive.validarCliente()) {
              customer.customerActive.isAgregate = true;
              debugger();
               final card = Provider.of<Cart>(context,listen: false);
              debugger();
              Provider.of<Products>(context,listen: false)
                  .fetchAndSetProduct(
                      (customer.customerActive == null)
                          ? '0'
                          : customer.customerActive.idLista,
                      card.items)
                  .then((_) {
                setState(() {
                  debugger();
                  _isLoading = false;
                });
              });
            } else {
              customer.customerActive = null;
              MessageWidget.error(context,
                  "POR FAVOR COMPLETE LA INFORMACION DEL CLIENTE", 120);
            }
          });
          //    _isLoading = false;
        });
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Distribuidora'),
          actions: <Widget>[
            Consumer<Cart>(
              builder: (_, cartObject, child) => Badge(
                child: child,
                value: cartObject.itemCount.toString(),
              ),
              child: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
              ),
            ),
          ],
        ),
        drawer: AppDrawer(),
        body: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      _searchName = value;
                    });
                  },
                  decoration: InputDecoration(
                      labelText: "Search",
                      hintText: "Search",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(25.0)))),
                ),
              ),
              Expanded(
                  child: _isLoading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : ProductsGrid(_searchName)),
            ],
          ),
        ));
  }
}
