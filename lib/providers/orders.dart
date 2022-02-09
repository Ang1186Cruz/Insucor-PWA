import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import './cart.dart';

class OrderItem {
  final String idOrder;
  final String nameCustommer;
  final String mailCustomer;
  final String address;
  final DateTime fecha;
  final String codigo;
  final String transportista;
  final String noCerrado;
  int idTransportista;
  DateTime fechaEntrega;
  String observacion;
  String modo;
  String telefono;
  final List<CartItem> products;

  OrderItem(
      {@required this.idOrder,
      @required this.nameCustommer,
      this.mailCustomer,
      this.address,
      this.fecha,
      this.codigo,
      this.transportista,
      this.noCerrado,
      this.idTransportista,
      this.fechaEntrega,
      this.observacion,
      this.modo,
      this.telefono,
      this.products});
  factory OrderItem.fromJson(Map<String, dynamic> parseJson) {
    return OrderItem(
      idOrder: parseJson['idPedido'],
      nameCustommer: parseJson['nombreCliente'],
      mailCustomer: parseJson['mailCliente'],
      address: parseJson['direccionCliente'],
      fecha: DateTime.parse(parseJson['fechaPedido']),
      codigo: parseJson['codigo'],
      transportista: parseJson['transportista'],
      noCerrado: parseJson['noCerrado'],
      idTransportista: int.parse(parseJson['idTransportista']),
      fechaEntrega: DateTime.parse(parseJson['fechaEntrega']),
      observacion: parseJson['observacion'],
      modo: parseJson['modo'],
      telefono: parseJson['telefono'],
      products: (parseJson['product'] as List<dynamic>)
          .map((item) => CartItem(
              idPedidP: int.parse(item['idPedidoP']),
              id: item['idProducto'],
              price: double.parse(item['precio_Compra'] ?? "0"),
              quantity: int.parse(item['cantidad'] ?? "0"),
              title: item['nameProducto'],
              priceRequested: double.parse(item['priceRequested'] ?? "0")))
          .toList(),
    );
  }
}

class Orders with ChangeNotifier {
  OrderItem orderActive;
  List<OrderItem> _orders = [];
  final String authToken;
  final String userId;

  Orders(this.authToken, this.userId, this._orders);

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrder() async {
    final url = 'https://distribuidorainsucor.com/APP_Api/api/ordenes.php';
    try {
      final response = await http.get(url);
      List<OrderItem> loadedCustomers = (json.decode(response.body) as List)
          .map((e) => new OrderItem.fromJson(e))
          .toList();
      _orders = loadedCustomers.reversed.toList();
      notifyListeners();
    } catch (exception) {
      print("NO hay información: " + exception.toString());
      throw exception;
    }
  }
//}

//   Future<void> fetchAndSetOrder() async {
//     final url =
//         'https://flutter-shop-app-b3619.firebaseio.com/orders/$userId.json?auth=$authToken';
//     final response = await http.get(url);
//     final List<OrderItem> loadedOrders = [];
//     final extractedData = json.decode(response.body) as Map<String, dynamic>;

//     if (extractedData != null) {
//       extractedData.forEach((key, orderData) {
//         loadedOrders.add(OrderItem(
//             id: key,
//             amount: orderData['amount'],
//             products: (orderData['products'] as List<dynamic>)
//                 .map((item) => CartItem(
//                     id: item['id'],
//                     price: item['price'],
//                     quantity: item['quantity'],
//                     title: item['title']))
//                 .toList(),
//             dateTime: DateTime.parse(orderData['dateTime'])));
//       });
//       _orders = loadedOrders.reversed.toList();
//       notifyListeners();
//     }
//   }

  void addOrderModificad(OrderItem order) {
    orderActive = order;
  }

  OrderItem getActivated() {
    return orderActive;
  }

  Future<void> addOrder(
      String idOrder,
      List<CartItem> cartProducts,
      double total,
      int idCustommer,
      int idCarrier,
      String dateDelivery,
      String observation,
      String modo) async {
    //
    final url = 'https://distribuidorainsucor.com/APP_Api/api/ordenes.php';
   
    final response = await http.post(url,
        body: json.encode(cartProducts
            .map((product) => {
                  'idPedido': idOrder,
                  'idCliente': idCustommer,
                  'idProducto': product.id,
                  'cantidad': product.quantity,
                  'precioCompra': product.price,
                  'precioSolicitado': product.priceRequested,
                  'observacion': observation,
                  'dateDelivery': dateDelivery,
                  'idCarrier': idCarrier,
                  'modo': modo,
                })
            .toList()));
    notifyListeners();
  }
}
