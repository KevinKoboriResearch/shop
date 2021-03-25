import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/exceptions/http_exception.dart';
import 'package:shop/utils/constants.dart';
import 'package:shop/models/product_model.dart';
import './product.dart';
// .collection('remottelyCompanies')
// .doc(product.companyTitle) //.doc('tapanapanterahs') //
// .collection('productCategories')
// .doc(product.categoryTitle) //.doc('Tabacos') //
// .collection('products')
// .doc(product.title)
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../data/firestore/products_collection.dart';

import '../data/firestore/user_favorites_collection.dart';
import 'dart:async';
import "dart:convert";

class Products with ChangeNotifier {
  final auth = FirebaseAuth.instance.currentUser;

  List<Product> _items = [];
  List<Product> _favoriteItems = [];
  String _token;
  String _userId;
  bool _busy;

  Products(
      [this._token,
      this._userId,
      this._busy = false,
      this._items = const [],
      this._favoriteItems = const []]);

  List<Product> get items => [..._items];
  //  set items() => _items;
  List<Product> get favoriteItems => [..._favoriteItems];

  List get favoriteCompanies {
    var myList = [];
    _favoriteItems.map((favoriteItem) {
      //  print(favoriteItem.companyTitle);
      myList.add({
        'companyTitle': favoriteItem.companyTitle,
      });
    }).toList();

    // convert each item to a string by using JSON encoding
    final jsonList = myList.map((item) => jsonEncode(item)).toList();

    // using toSet - toList strategy
    final uniqueJsonList = jsonList.toSet().toList();

    // convert each item back to the original form using JSON decoding
    final result = uniqueJsonList.map((item) => jsonDecode(item)).toList();

    // print(result);
    return result;
  }

  bool get busy {
    return _busy;
  }

  int get itemsCount {
    return _items.length;
  }

  void setBusy(bool val) {
    _busy = val;
  }

  void setItems(List<Product> val) {
    _items = val;
  }

  void setFavoriteItems(List<Product> val) {
    _items = val;
  }

////////////////////////////////////////////////////////////

  final ProductsCollection _productsService = ProductsCollection();

  void listenToProducts() {
    // setBusy(true);

    _productsService.listenToProductsRealTime().listen((productsData) {
      List<Product> updatedProducts = productsData;
      if (updatedProducts != null && updatedProducts.length > 0) {
        _items = updatedProducts;
        notifyListeners();
      }

      // setBusy(false);
    });
  }

  void requestMoreCompanyProductsData() => _productsService.requestMoreData();

////////////////////////////////////////////////////////////

  final UserFavoritesCollection _userFavoriteProductsService =
      UserFavoritesCollection();

  void listenToUserFavoriteProducts() {
    // setBusy(true);

    _userFavoriteProductsService
        .listenToUserFavoriteProductsRealTime()
        .listen((productsData) {
      List<Product> updatedProducts = productsData;
      if (updatedProducts != null && updatedProducts.length > 0) {
        _favoriteItems = updatedProducts;
        notifyListeners();
      }
      // else {
      //   _favoriteItems = [];
      //   notifyListeners();
      // }

      // setBusy(false);
    });
  }

  void requestMoreUserFavoriteProductsData() =>
      _userFavoriteProductsService.requestMoreUserFavoriteProductsData();

////////////////////////////////////////////////////////////
}
