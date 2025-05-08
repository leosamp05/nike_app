import 'package:flutter/foundation.dart';
import 'package:nike_app/models/product.dart';

class WishlistService extends ChangeNotifier {
  WishlistService._();
  static final WishlistService instance = WishlistService._();

  final List<Product> _items = [];

  void add(Product product) {
    if (!_items.contains(product)) {
      _items.add(product);
      notifyListeners();
    }
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
