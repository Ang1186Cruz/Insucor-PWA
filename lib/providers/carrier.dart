import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CarrierOne with ChangeNotifier {
  final String id;
  final String nombre;
  bool isAgregate;

  CarrierOne({
    @required this.id,
    @required this.nombre,
    this.isAgregate = false,
  });

  factory CarrierOne.fromJson(Map<String, dynamic> parseJson) {
    return CarrierOne(
      id: parseJson['id'],
      nombre: parseJson['nombre'],
    );
  }
}

class Carriers with ChangeNotifier {
  final String authToken;
  final String userId;
  Carriers(this.authToken, this.userId, this._items);
  List<CarrierOne> _items = [];

  List<CarrierOne> get items {
    addCarrier();
    return [..._items];
  }
  void addCarrier() {
    if (_items.length == 0) {
      _items.add(new CarrierOne(id: '1', nombre: 'Mostrador'));
      _items.add(new CarrierOne(id: '4', nombre: 'Astrada Armando'));
      _items.add(new CarrierOne(id: '8', nombre: 'Echenique Juan'));
      _items.add(new CarrierOne(id: '9', nombre: 'Sciutto Mauro'));
      _items.add(new CarrierOne(id: '11', nombre: 'Molinari Matias'));
      _items.add(new CarrierOne(id: '12', nombre: 'Cisneros Leonardo'));
      _items.add(new CarrierOne(id: '14', nombre: 'Miranda Nicolas'));
    }
  }

}
