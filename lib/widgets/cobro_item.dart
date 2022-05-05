
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../providers/cobros.dart' as ord;


class CobroItem extends StatefulWidget {
  final ord.CobroItem cobro;
  final String value;

  CobroItem(this.cobro, this.value);

  @override
  _CobroItemState createState() => _CobroItemState();
}

class _CobroItemState extends State<CobroItem> {
  var _expanded = false;
  int length = 0;

  @override
  Widget build(BuildContext context) {
    bool search = true;
    if (!(widget.value.isEmpty || widget.value == "")) {
      search = (widget.cobro.nombre
              .toUpperCase()
              .contains(widget.value.toUpperCase()));
    }
   
    return search
        ? AnimatedContainer(
            duration: Duration(milliseconds: 400),
            height: _expanded
                ? 500 //min(widget.order.products.length * 20.0 + 150, 200)
                : 95,
            child: Card(
              margin: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text(
                       "(" +
                        widget.cobro.noFactura +
                        ") " +
                        widget.cobro.nombre),
                    subtitle: Text("Total Efectivo.: " +
                widget.cobro.totalEfectivo.toString() +
                "\ntotal Cheque: " +
                widget.cobro.totalCheque.toString()+
                "\ntotal : " +
                widget.cobro.totalRecibido.toString()),
                
                 ), 
                ],
              ),
            ),
          )
        : AnimatedContainer(duration: const Duration(seconds: 1));
  }
}

// void reloadCard(
//     BuildContext context, List<CartItem> _items, ord.OrderItem order) {
//   // primero limpio todo
//   Provider.of<Customers>(context, listen: false).clearCustomer(order.codigo);
//   Provider.of<Products>(context, listen: false).clearProducts();
//   Provider.of<Cart>(context, listen: false).clearCart();
//   Provider.of<Cart>(context, listen: false).addCart(_items);
//   Provider.of<ord.Orders>(context, listen: false).addOrderModificad(order);

//   // recargo customer Productos
//   Navigator.of(context).pushReplacementNamed(ProductsOverviewScreen.routeName);
// }
