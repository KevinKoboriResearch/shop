import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product_model.dart';
import '../providers/product.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  // final _auth = FirebaseAuth.instance.currentUser;

  final CollectionReference _postsCollectionReference = Firestore.instance
      .collection('remottelyCompanies')
      .doc('tapanapanterahs') // .doc(product.companyTitle) //
      .collection('productCategories')
      .doc('Tabacos') //.doc(product.categoryTitle) //
      .collection('products');

  // final favMap = FirebaseFirestore.instance
  //     .collection('users')
  //     .doc(FirebaseAuth.instance.currentUser.uid) // .doc(product.companyTitle) //
  //     .collection('favorites')
  //     // .where('isFavorite', isEqualTo: id)
  //     // .where('oi', isEqualTo: 'oi')
  //     .get();

  final StreamController<List<Product>> _postsController =
      StreamController<List<Product>>.broadcast();

  // #6: Create a list that will keep the paged results
  List<List<Product>> _allPagedResults = List<List<Product>>();

  static const int PostsLimit = 6;

  DocumentSnapshot _lastDocument;
  bool _hasMorePosts = true;

  Stream listenToPostsRealTime() {
    // Register the handler for when the posts data changes
    _requestPosts();
    return _postsController.stream;
  }

  // #1: Move the request posts into it's own function
  void _requestPosts() {
    // #2: split the query from the actual subscription
    var pagePostsQuery = _postsCollectionReference
        .orderBy('title')
        // #3: Limit the amount of results
        .limit(PostsLimit);

    // #5: If we have a document start the query after it
    if (_lastDocument != null) {
      pagePostsQuery = pagePostsQuery.startAfterDocument(_lastDocument);
    }

    if (!_hasMorePosts) return;

    // #7: Get and store the page index that the results belong to
    var currentRequestIndex = _allPagedResults.length;

    pagePostsQuery.snapshots().listen((postsSnapshot) async {
      if (postsSnapshot.documents.isNotEmpty) {
        List<Product> posts = postsSnapshot.documents
            .map((snapshot) =>
                Product.fromMap(snapshot.data(), snapshot.documentID))
            .where((mappedItem) => mappedItem.title != null)
            .toList();

        final favMap = await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser.uid)
            .collection('favorites')
            .get();

        List<Product> newPosts = [];
        if (posts != null) {
          posts.forEach((reqProduct) {
            var isFavorite = false;
            favMap.docs.forEach((element) {
              print('EEEEEEEEEEEE >>>>>>> >>>>>>>>> >>>>>> ' +
                  element.id.toString());
              print('GGGGGGGGGGGG >>>>>>> >>>>>>>>> >>>>>> ' +
                  reqProduct.id.toString());
              if (element.id.toString() == reqProduct.id.toString()) {
                isFavorite = true;
                return;
              }
            });
            print('AAAAAAAAAAAAAAAAAAA >>>>>>> >>>>>>>>> >>>>>> ' +
                isFavorite.toString());
            newPosts.add(Product(
              id: reqProduct.id,
              coin: reqProduct.coin,
              companyTitle: reqProduct.companyTitle,
              categoryTitle: reqProduct.categoryTitle,
              description: reqProduct.description,
              enabled: reqProduct.enabled,
              images: reqProduct.images,
              interested: reqProduct.interested,
              price: reqProduct.price,
              promotion: reqProduct.promotion,
              rating: reqProduct.rating,
              sizes: reqProduct.sizes,
              subtitle: reqProduct.subtitle,
              title: reqProduct.title,
              quantity: reqProduct.quantity,
              isFavorite: isFavorite,
            ));
          });
        }

        // #8: Check if the page exists or not
        var pageExists = currentRequestIndex < _allPagedResults.length;

        // #9: If the page exists update the posts for that page
        if (pageExists) {
          _allPagedResults[currentRequestIndex] = newPosts;
        }
        // #10: If the page doesn't exist add the page data
        else {
          _allPagedResults.add(newPosts);
        }

        // #11: Concatenate the full list to be shown
        var allPosts = _allPagedResults.fold<List<Product>>(List<Product>(),
            (initialValue, pageItems) => initialValue..addAll(pageItems));

        // #12: Broadcase all posts
        _postsController.add(allPosts);

        // #13: Save the last document from the results only if it's the current last page
        if (currentRequestIndex == _allPagedResults.length - 1) {
          _lastDocument = postsSnapshot.documents.last;
        }

        // #14: Determine if there's more posts to request
        _hasMorePosts = newPosts.length == PostsLimit;
      }
    });
  }

  void requestMoreData() => _requestPosts();
}
