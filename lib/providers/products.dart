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
import '../compound/firestore_service.dart';
import 'dart:async';

class Products with ChangeNotifier {
  final auth = FirebaseAuth.instance.currentUser;

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

/////////////
///
///
final FirestoreService _firestoreService = FirestoreService();

  // List<Product> _items;
  List<Product> get posts => _items;

  void listenToPosts() {
    // setBusy(true);

    _firestoreService.listenToPostsRealTime().listen((postsData) {
      List<Product> updatedPosts = postsData;
      if (updatedPosts != null && updatedPosts.length > 0) {
        _items = updatedPosts;
        notifyListeners();
      }

      // setBusy(false);
    });
  }

  void requestMoreData() => _firestoreService.requestMoreData();

///////////////
///\
///
///
///
///
  
  Future<void> loadProducts() async {
    final getProducts = await FirebaseFirestore.instance
        .collection('remottelyCompanies')
        .doc('tapanapanterahs') // .doc(product.companyTitle) //
        .collection('productCategories')
        .doc('Tabacos') //.doc(product.categoryTitle) //
        .collection('products')
        .get();
    final favMap = await FirebaseFirestore.instance
        .collection('users')
        .doc(auth.uid) // .doc(product.companyTitle) //
        .collection('favorites')
        // .where('isFavorite', isEqualTo: id)
        // .where('oi', isEqualTo: 'oi')
        .get();
    // final favMap = getFavorites;
// final getFavorites = await FirebaseFirestore.instance
//         .collection('users')
//         .doc('FYRjAaP0FHSr6DoFSX5KwVzObcn1') // .doc(product.companyTitle) //
//         .collection('favorites')
//         .get();
//     final favMap = getFavorites;

    // _items.clear();
    // if (getProducts != null) {
    //   getProducts.docs.forEach((product) {
    //     final isFavorite = favMap == null ? false : favMap.docs.contains(product.id) ?? false;

    _items.clear();
    if (getProducts != null) {
      getProducts.docs.forEach((reqProduct) {
        var isFavorite = false;
        // var isFavorite = favMap.docs.first.id == reqProduct.id;
         favMap.docs.forEach((element) {
           print('EEEEEEEEEEEE >>>>>>> >>>>>>>>> >>>>>> ' + element.id.toString());
            print('GGGGGGGGGGGG >>>>>>> >>>>>>>>> >>>>>> ' + reqProduct.id.toString());
          // if(element.data()['isFavorite'] == true) {
          if (element.id.toString() == reqProduct.id.toString()) {
            isFavorite = true;
            return;
          }
          // isFavorite = false;
          // return;
        });
        // var oi = getFavorites.where('isFavorite', isEqualTo: reqProduct.id);
        print('AAAAAAAAAAAAAAAAAAA >>>>>>> >>>>>>>>> >>>>>> ' + isFavorite.toString());
        // // var hehe = favMap.docs.where('oi': isEqualTo: 'oi');
        // print(favMap.docs.first.id);//.docs.where('oi': isEqualTo: 'oi') ? 'AAAAAAAAAAAAAAAAAAA': 'false');
        // final isFavorite = favMap == null ? false : favMap.docs.contains(reqProduct.id) ? true: false;//docs.where("isFavorite", isEqualTo: reqProduct.id) == true ? true : false;//?? false;
        _items.add(Product(
          // id: product.id,
          // title: product.data()['title'],
          // description: product.data()['description'],
          // price: product.data()['price'],
          // images: product.data()['images'],
          // subtitle: product.data()['subtitle'],
          // promotion: product.data()['promotion'],
          id: reqProduct.id,
          coin: reqProduct.data()['coin'],
          companyTitle: reqProduct.data()['companyTitle'],
          categoryTitle: reqProduct.data()['categoryTitle'],
          description: reqProduct.data()['description'],
          enabled: reqProduct.data()['enabled'],
          images: reqProduct.data()['images'],
          interested: reqProduct.data()['interested'],
          price: reqProduct.data()['price'],
          promotion: reqProduct.data()['promotion'],
          rating: reqProduct.data()['rating'],
          sizes: reqProduct.data()['sizes'],
          subtitle: reqProduct.data()['subtitle'],
          title: reqProduct.data()['title'],
          // quantity: product.data()['quantity'],
          // imageUrl: product.data()['imageUrl'],
          isFavorite: isFavorite,
        ));
      });
      notifyListeners();
    }
    return Future.value();
  }

  ///
  ////
  ////
  ///
  ////
  ///
  /////
  ///
  ///

  Future<void> addProduct(newProduct) async {
    //, imagesSelectedList) async {
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
      images: newProduct.images,
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
          'images': product.images,
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
