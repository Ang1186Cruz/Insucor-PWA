import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CustomerOne with ChangeNotifier {
  final String id;
  final String nombre;
  final String empresa;
  final String telefono;
  final String direccion;
  final String code;
  String idLista;
  final String mail;
  bool isAgregate;
  List<DropdownMenuItem<String>> facturadropdownItems;

  CustomerOne(
      {@required this.id,
      @required this.nombre,
      @required this.empresa,
      this.telefono,
      this.direccion,
      this.code,
      this.idLista,
      this.mail,
      this.isAgregate = false});

  bool validarCliente() {
    if (this.nombre.isEmpty ||
        this.empresa.isEmpty ||
        this.telefono.isEmpty ||
        this.direccion.isEmpty ||
        this.code.isEmpty ||
        this.mail.isEmpty) {
      return false;
    }
    return true;
  }

  factory CustomerOne.fromJson(Map<String, dynamic> parseJson) {
    return CustomerOne(
      id: parseJson['id'],
      nombre: parseJson['nombre'],
      empresa: parseJson['empresa'],
      telefono: parseJson['telefono'],
      direccion: parseJson['direccion'],
      code: parseJson['codigo'],
      idLista: parseJson['idLista'],
      mail: parseJson['mail'],
    );
  }
}

class Customers with ChangeNotifier {
  CustomerOne customerActive;
  final String authToken;
  final String userId;
  Customers(this.authToken, this.userId, this._items);

  List<CustomerOne> _items = [];

  List<CustomerOne> get items {
    return [..._items];
  }

  CustomerOne findById(String id) {
    return _items.firstWhere((custome) => custome.id == id);
  }

  Future<void> refreshCustomer(String id) async {
    final customerIndex = _items.indexWhere((customer) => customer.id == id);
    var url =
        'https://distribuidorainsucor.com/APP_Api/api/clientes.php?idCustomer=' +
            id;
    try {
      final response = await http.get(Uri.parse(url));

      CustomerOne newCustomer = (json.decode(response.body) as List)
          .map((e) => new CustomerOne.fromJson(e))
          .first;
      _items[customerIndex] = newCustomer;
      notifyListeners();
      //}
    } catch (exception) {
      print("Error de Listado: " + exception.toString());
      throw exception;
    }
  }

  Future<void> fetchAndSetCustomer() async {
    if (_items.length == 0) {
      var url = 'https://distribuidorainsucor.com/APP_Api/api/clientes.php';
      try {
        final response = await http.get(Uri.parse(url));
        List<CustomerOne> loadedCustomers = (json.decode(response.body) as List)
            .map((e) => new CustomerOne.fromJson(e))
            .toList();
        _items = loadedCustomers;
        notifyListeners();
        //}
      } catch (exception) {
        print("Error de Listado: " + exception.toString());
        throw exception;
      }
    }
  }

  void addCustommer(String idCustomer, String name, String direccion,
      String idLista, String codes, String empres) {
    //
    customerActive = new CustomerOne(
        id: idCustomer,
        nombre: name,
        direccion: direccion,
        idLista: idLista,
        code: codes,
        empresa: empres);
  }

  void clearCustomer(String codigo) {
    customerActive = null;
    if (_items.length > 0) {
      _items.forEach((item) {
        item.isAgregate = false;
      });
    }
    if (codigo != "") {
      _items.forEach((item) {
        if (item.code == codigo) {
          item.isAgregate = true;
          addCustommer(
              item.id, item.nombre, item.direccion, item.idLista, item.code, item.empresa);
        }
      });
    }
  }

  void clearCustomerALL() {
    _items = [];
  }

  Future<void> addFactura() async {
    
    if (customerActive != null) {
      customerActive.facturadropdownItems = [];
      customerActive.facturadropdownItems.add(
          new DropdownMenuItem(child: Text("SELECCIONE FACTURA"), value: ""));
      var url =
          'https://distribuidorainsucor.com/APP_Api/api/clientes.php?codigoCustomer=' +
              customerActive.code;
      try {
        final response = await http.get(Uri.parse(url));
        final lists =(json.decode(response.body).cast<Map<String, dynamic>>()) as List;
        customerActive.facturadropdownItems.addAll(lists.map((item) =>
            new DropdownMenuItem<String>(
                child: Text(item['numeroFactura']),
                value: item['numeroFactura'])).toList());
        notifyListeners();
      } catch (exception) {
        print("Error de Listado: " + exception.toString());
        throw exception;
      }
    }
  }
 
  Future<void> addCustomer(CustomerOne product) async {
    // if (_items.length == 0) {
    //   final url =
    //       'https://flutter-shop-app-b3619.firebaseio.com/products.json?auth=$authToken';
    //   try {
    //     final response = await http.post(
    //       url,
    //       body: json.encode({
    //         'title': product.title,
    //         'description': product.description,
    //         'price': product.price,
    //         'imageUrl': product.imageUrl,
    //         'creatorId': userId,
    //       }),
    //     );

    //     final newProduct = Product(
    //       title: product.title,
    //       description: product.description,
    //       price: product.price,
    //       imageUrl: product.imageUrl,
    //       id: json.decode(response.body)['name'],
    //     );
    //     _items.add(newProduct);
    //     notifyListeners();
    //   } catch (exception) {
    //     print(exception);
    //     throw exception;
    //   }
    // }
  }

  Future<void> updateCustomer(String id, CustomerOne newCustomer) async {
    //
    final customerIndex = _items.indexWhere((customer) => customer.id == id);
    if (customerIndex >= 0) {
      final url = 'https://distribuidorainsucor.com/APP_Api/api/clientes.php';
      await http.post(
        Uri.parse(url),
        body: json.encode({
          'id': newCustomer.id,
          'nombre': newCustomer.nombre,
          'empresa': newCustomer.empresa,
          'telefono': newCustomer.telefono,
          'direccion': newCustomer.direccion,
          'code': newCustomer.code,
          'idLista': newCustomer.idLista,
          'mail': newCustomer.mail,
        }),
      );
      _items[customerIndex] = newCustomer;
      notifyListeners();
    } else {
      print('...');
    }
  }
}
