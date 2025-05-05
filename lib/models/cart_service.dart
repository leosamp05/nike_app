// lib/models/cart_service.dart
import 'product.dart';

class CartService {
  CartService._(); // costruttore privato
  static final instance = CartService._();

  final List<Product> _items = [];
  List<Product> get items => List.unmodifiable(_items);
  int get count => _items.length;

  void add(Product p) {
    _items.add(p);
  }
}
