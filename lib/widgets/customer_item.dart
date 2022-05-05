import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop_app/providers/auth.dart';
import 'package:flutter_shop_app/providers/products.dart';
import 'package:flutter_shop_app/providers/cart.dart';
import 'package:flutter_shop_app/providers/customers.dart';
import 'package:provider/provider.dart';
import 'package:flutter_shop_app/screens/products_overview_screen.dart';
import '../screens/edit_customers_screen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../screens/collect_screen.dart';

class CustomerItem extends StatelessWidget {
  final String id;
  final bool customerSelect;
  CustomerItem(this.id, this.customerSelect);
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: false);
    //final cart = Provider.of<Cart>(context, listen: false);
    final customer = Provider.of<CustomerOne>(context, listen: false);
    // if (customer.nombre == customer.) {
    //   customer.isAgregate = true;
    // }
    return new Column(children: <Widget>[
      new Container(
          height: 95,
          width: MediaQuery.of(context).size.width - 5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Theme.of(context).hintColor.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5)
            ],
          ),
          child: new ListTile(
            title: Text("Empr.: " + customer.empresa),
            subtitle: Text("Nomb.: " +
                customer.nombre +
                "\nDirec.: " +
                customer.direccion),
            leading:
                CircleAvatar(radius: 30.0, child: Text(customer.code ?? "")),
            trailing: Container(
                //width: 80,
                width: 100,
                child: Row(children: <Widget>[
                  IconButton(
                    color: Theme.of(context).accentColor,
                    icon: customer.isAgregate
                        ? Icon(
                            Icons.done_all,
                            color: Colors.green,
                          )
                        : Icon(
                            Icons.done,
                            color: customerSelect ? Colors.white : Colors.blue,
                          ),
                    onPressed: customer.isAgregate
                        ? null
                        : customerSelect
                            ? null
                            : () {
                                if (customer.validarCliente()) {
                                  customer.isAgregate = true;
                                  Provider.of<Customers>(context, listen: false)
                                      .addCustommer(
                                          customer.id,
                                          customer.nombre,
                                          customer.direccion,
                                          customer.idLista,
                                          customer.code,
                                          customer.empresa);
                                  (auth.operation=='cobro')?
                                  Navigator.of(context).pushNamed(CollectScreen.routeName):
                                    Navigator.of(context).pushReplacementNamed(
                                      ProductsOverviewScreen.routeName);
                                } else {
                                  Alert(
                                    context: context,
                                    type: AlertType.error,
                                    title: "ERROR !!",
                                    desc:
                                        "Por favor complete la información del Cliente",
                                  ).show();
                                }
                              },
                  ),
                  // customerSelect?null: IconButton(
                  IconButton(
                    icon: Icon(
                      customer.isAgregate ? Icons.close : Icons.edit,
                      color: customer.isAgregate
                          ? Colors.red
                          : Theme.of(context).primaryColor,
                    ),
                    onPressed: customer.isAgregate
                        ? () {
                            Provider.of<Customers>(context, listen: false)
                                .clearCustomer("");
                            Provider.of<Products>(context, listen: false)
                                .clearProducts();
                            Provider.of<Cart>(context, listen: false)
                                .clearCart();
                            Navigator.of(context).pushReplacementNamed('/');
                          }
                        : () {
                            Navigator.of(context).pushNamed(
                                EditcustomerScreen.routeName,
                                arguments: customer.id);
                          },
                  ),
                ])
                ),
          )),
      // new Divider(color: Colors.blue,),
    ]);
  }
}
