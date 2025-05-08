import 'package:flutter/foundation.dart';
import 'package:nike_app/models/product.dart';

class CartService extends ChangeNotifier {
  CartService._();
  static final CartService instance = CartService._();

  final List<Product> _items = [];

  void add(Product product) {
    _items.add(product);
    notifyListeners();
  }

  void remove(Product product) {
    _items.remove(product);
    notifyListeners();
  }

  List<Product> get items => List.unmodifiable(_items);
  int get count => _items.length;
  void clear() {
    _items.clear();
    notifyListeners();
  }
}
