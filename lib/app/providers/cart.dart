import 'dart:math';

import 'package:flutter/foundation.dart';
import './product.dart';

class CartItem {
  final String id;
  final String productId;
  final String title;
  final int quantity;
  final double price;
  final String image;

  CartItem({
    @required this.id,
    @required this.productId,
    @required this.title,
    @required this.image,
    @required this.quantity,
    @required this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemsCount {
    return _items.length;
  }

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      _items.update(product.id, (existingItem) {
        return CartItem(
          id: existingItem.id,
          productId: product.id,
          title: existingItem.title,
          image: existingItem.image,
          quantity: existingItem.quantity + 1,
          price: existingItem.price,
        );
      });
    } else {
      _items.putIfAbsent(product.id, () {
        return CartItem(
          id: Random().nextDouble().toString(),
          productId: product.id,
          title: product.title,
          price: product.price,
          image: product.images[0]['url'],
          quantity: 1,
        );
      });
    }

    notifyListeners();
  }

  void addItemFromCart(CartItem cart) {
    //cart
    if (_items.containsKey(cart.productId)) {
      _items.update(cart.productId, (existingItem) {
        return CartItem(
          id: existingItem.id,
          productId: cart.productId,
          title: existingItem.title,
          image: existingItem.image,
          quantity: existingItem.quantity + 1,
          price: existingItem.price,
        );
      });
    }
    notifyListeners();
  }

  void removeSingleItem(productId) {
    if (!_items.containsKey(productId)) {
      return;
    }

    if (_items[productId].quantity == 1) {
      _items.remove(productId);
    } else {
      _items.update(
        productId,
        (existingItem) => CartItem(
          id: existingItem.id,
          productId: existingItem.productId,
          title: existingItem.title,
          quantity: existingItem.quantity - 1,
          image: existingItem.image,
          price: existingItem.price,
        ),
      );
    }

    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
