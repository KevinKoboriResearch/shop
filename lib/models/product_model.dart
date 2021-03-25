import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:shop/models/image_model.dart';

class ProductModel {
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
  final String quantity;

  ProductModel({
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
      // this.quantity,
    };
  }

  static ProductModel fromMap(Map<String, dynamic> map, String documentId) {
    if (map == null) return null;

    return ProductModel(
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
      // this.quantity,
    );
  }
}
