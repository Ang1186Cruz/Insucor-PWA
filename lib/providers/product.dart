import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isAgregate;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    this.imageUrl,
    this.isAgregate = false,
  });

  factory Product.fromJson(Map<String, dynamic> parseJson, List<String> lista) {
    bool isAgregado = lista
        .any((e) => e == parseJson['id']); // any(d=>d.id== parseJson['id']);
    return Product(
      id: parseJson['id'],
      title: parseJson['codigo'],
      description: parseJson['nombre'],
      price: double.parse(parseJson['precio'] ?? "0"),
      imageUrl: '',
      isAgregate: isAgregado,
    );
  }

  void _setFavValue(bool newValue) {
    isAgregate = newValue;
    notifyListeners();
  }

  Future<void> toggleAgregate(String token, String userId) async {
    // final oldStatus = isAgregate;
    isAgregate = !isAgregate;
    // notifyListeners();
    _setFavValue(true);
    // final url =
    //     'https://flutter-shop-app-b3619.firebaseio.com/userFavorite/$userId/$id.json?auth=$token';

    // try {
    //   final response = await http.put(url, body: json.encode(isAgregate));
    //   if (response.statusCode >= 400) {
    //     _setFavValue(oldStatus);
    //   }
    // } catch (error) {
    //   _setFavValue(oldStatus);
    // }
  }
}
