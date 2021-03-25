import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shop/utils/constants.dart';
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

class Product with ChangeNotifier {
  final String id;
  final String coin;
  final String categoryTitle;
  final String companyTitle;
  final String description;
  final bool enabled;
  // final List<ImageModel> images;
  final List images;
  // final List<String> interested;
  final List interested;
  final double price;
  final double promotion;
  final List rating;
  final List sizes;
  final String subtitle;
  final String title;
  final int quantity;
  bool isFavorite;

  Product({
    this.id,
    this.coin,
    this.categoryTitle,
    this.companyTitle,
    this.description,
    this.enabled,
    this.images,
    this.interested,
    this.price,
    this.promotion,
    this.rating,
    this.sizes,
    this.subtitle,
    this.title,
    this.quantity,
    this.isFavorite,
  });

Map<String, dynamic> toMap() {
    return {
      'id': id,
      'coin': coin,
      'categoryTitle': categoryTitle,
      'companyTitle': companyTitle,
      'description': description,
      'enabled': enabled,
      'images': images,
      'interested': interested,
      'price': price,
      'promotion': promotion,
      'rating': rating,
      'sizes': sizes,
      'subtitle': subtitle,
      'title': title,
      'quantity': quantity,
      'isFavorite': isFavorite,
    };
  }

  static Product fromMap(Map<String, dynamic> map, String documentId) {
    if (map == null) return null;

    return Product(
      id: documentId,
      coin: map['coin'],
      categoryTitle: map['categoryTitle'],
      companyTitle: map['companyTitle'],
      description: map['description'],
      enabled: map['enabled'],
      images: map['images'],
      interested: map['interested'],
      price: map['price'],
      promotion: map['promotion'],
      rating: map['rating'],
      sizes: map['sizes'],
      subtitle: map['subtitle'],
      title: map['title'],
      quantity: map['quantity'],
      isFavorite: map['isFavorite'],
    );
  }

  void _toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }

  final auth = FirebaseAuth.instance.currentUser;
  Future<void> toggleFavorite() async {
    _toggleFavorite();

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(auth.uid)
          .collection('favorites')
          .doc(id)
          .set({});
    } catch (error) {
      _toggleFavorite();
    }
  }
}
