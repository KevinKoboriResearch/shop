import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/exceptions/http_exception.dart';
import 'package:shop/utils/constants.dart';
import './product.dart';
// .collection('remottelyCompanies')
// .doc(product.companyTitle) //.doc('tapanapanterahs') //
// .collection('productCategories')
// .doc(product.categoryTitle) //.doc('Tabacos') //
// .collection('products')
// .doc(product.title)
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'dart:async';

class Products with ChangeNotifier {
  final auth = FirebaseAuth.instance;

  List<Product> _items = [];
  String _token;
  String _userId;

  Products([this._token, this._userId, this._items = const []]);

  List<Product> get items => [..._items];

  int get itemsCount {
    return _items.length;
  }

  List<Product> get favoriteItems {
    return _items.where((prod) => prod.isFavorite).toList();
  }

  Future<void> loadProducts() async {
    final response =
        await http.get("${AppURLs.BASE_API_URL}/products.json?auth=$_token");
    Map<String, dynamic> data = json.decode(response.body);

    final favResponse = await http.get(
        "${AppURLs.BASE_API_URL}/userFavorites/$_userId.json?auth=$_token");
    final favMap = json.decode(favResponse.body);

    _items.clear();
    if (data != null) {
      data.forEach((productId, productData) {
        final isFavorite = favMap == null ? false : favMap[productId] ?? false;
        _items.add(Product(
          id: productId,
          title: productData['title'],
          description: productData['description'],
          price: productData['price'],
          quantity: productData['quantity'],
          imageUrl: productData['imageUrl'],
          isFavorite: isFavorite,
        ));
      });
      notifyListeners();
    }
    return Future.value();
  }

  // Future<void> addProduct(Product newProduct) async {
  //   final response = await http.post(
  //     "${AppURLs.BASE_API_URL}/products.json?auth=$_token",
  //     body: json.encode({
  //       'title': newProduct.title,
  //       'description': newProduct.description,
  //       'price': newProduct.price,
  //       'quantity': newProduct.quantity,
  //       'imageUrl': newProduct.imageUrl,
  //     }),
  //   );

  //   _items.add(Product(
  //     id: json.decode(response.body)['name'],
  //     title: newProduct.title,
  //     description: newProduct.description,
  //     price: newProduct.price,
  //     quantity: newProduct.quantity,
  //     imageUrl: newProduct.imageUrl,
  //   ));
  //   notifyListeners();
  // }

  Future<void> addProduct(newProduct) async {//, imagesSelectedList) async {
    await FirebaseFirestore.instance
        .collection('remottelyCompanies')
        .doc('tapanapanterahs') // .doc(product.companyTitle) //
        .collection('productCategories')
        .doc('Tabacos') //.doc(product.categoryTitle) //
        .collection('products')
        .doc(newProduct.title)
        .set({
      'title': newProduct.title,
      'description': newProduct.description,
      'price': newProduct.price,
      'quantity': newProduct.quantity,
      'imageUrl': newProduct.imageUrl,
    });
    var response =
        await FirebaseFirestore.instance.collection('remottelyProducts').add({
      'title': newProduct.title,
      'description': newProduct.description,
      'price': newProduct.price,
      'quantity': newProduct.quantity,
      'imageUrl': newProduct.imageUrl,
    });
    _items.add(Product(
      id: response.id,
      title: newProduct.title,
      description: newProduct.description,
      price: newProduct.price,
      quantity: newProduct.quantity,
      imageUrl: newProduct.imageUrl,
    ));
    notifyListeners();
  }

  Future<void> updateProduct(Product product) async {
    if (product == null || product.id == null) {
      return;
    }

    final index = 1; //_items.indexWhere((prod) => prod.id == product.id);
    if (index >= 0) {
      await http.patch(
        "${AppURLs.BASE_API_URL}/products/${product.id}.json?auth=$_token",
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'price': product.price,
          'quantity': product.quantity,
          'imageUrl': product.imageUrl,
        }),
      );
      _items[index] = product;
      notifyListeners();
    }
  }

  Future<void> deleteProduct(String id) async {
    final index = 1; //_items.indexWhere((prod) => prod.id == id);
    if (index >= 0) {
      final product = _items[index];
      _items.remove(product);
      notifyListeners();

      final response = await http.delete(
          "${AppURLs.BASE_API_URL}/products/${product.id}.json?auth=$_token");

      if (response.statusCode >= 400) {
        _items.insert(index, product);
        notifyListeners();
        throw HttpException('Ocorreu um erro na exclusão do produto.');
      }
    }
  }
}

// bool _showFavoriteOnly = false;

// void showFavoriteOnly() {
//   _showFavoriteOnly = true;
//   notifyListeners();

// }
// void showAll() {
//   _showFavoriteOnly = false;
//   notifyListeners();
// }
