import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shop/app/providers/product.dart';
import 'dart:async';

class ProductsCollection {
  final _auth = FirebaseAuth.instance.currentUser;

  final CollectionReference _productsCollectionReference =
      FirebaseFirestore.instance
          .collection('remottelyProducts');

  final StreamController<List<Product>> _productsController =
      StreamController<List<Product>>.broadcast();

  // #6: Create a list that will keep the paged results
  List<List<Product>> _allPagedResults = [];

  static const int ProductsLimit = 6;

  DocumentSnapshot _lastDocument;
  bool _hasMoreProducts = true;

  Stream listenToProductsRealTime() {
    // Register the handler for when the products data changes
    _requestProducts();
    return _productsController.stream;
  }

  // #1: Move the request products into it's own function
  void _requestProducts() {
    // #2: split the query from the actual subscription
    var pageProductsQuery = _productsCollectionReference
        .orderBy('totalHating')
        // #3: Limit the amount of results
        .limit(ProductsLimit);

    // #5: If we have a document start the query after it
    if (_lastDocument != null) {
      pageProductsQuery = pageProductsQuery.startAfterDocument(_lastDocument);
    }

    if (!_hasMoreProducts) return;

    // #7: Get and store the page index that the results belong to
    var currentRequestIndex = _allPagedResults.length;

    pageProductsQuery.snapshots().listen((QuerySnapshot productsSnapshot) async {
      List<Product> newProducts = [];
      // if (productsSnapshot.docs.isNotEmpty) {
        List<Product> products = productsSnapshot.docs
            .map((snapshot) => Product.fromMap(snapshot.data(), snapshot.id))
            // .where((mappedItem) => mappedItem.title != null)
            .toList();

        final favMap = await FirebaseFirestore.instance
            .collection('users')
            .doc(_auth.uid)
            .collection('favorites')
            .get();

        if (products != null && products != []) {
          products.forEach((reqProduct) {
            var isFavorite = false;

            favMap.docs.forEach((element) {
              if (element.id.toString() == reqProduct.id.toString()) {
                isFavorite = true;
                return;
              }
            });

            newProducts.add(Product(
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
      // }
      // #8: Check if the page exists or not
      var pageExists = currentRequestIndex < _allPagedResults.length;

      // #9: If the page exists update the products for that page
      if (pageExists) {
        _allPagedResults[currentRequestIndex] = newProducts;
      }
      // #10: If the page doesn't exist add the page data
      else {
        _allPagedResults.add(newProducts);
      }
print('>>>>>>>>>>>>>>> 5' + newProducts.toString());
      // #11: Concatenate the full list to be shown
      var allProducts = _allPagedResults.fold<List<Product>>(
          [], (initialValue, pageItems) => initialValue..addAll(pageItems));

      // #12: Broadcase all products
      _productsController.add(allProducts);

      // #13: Save the last document from the results only if it's the current last page
      if (currentRequestIndex == _allPagedResults.length - 1) {
        _lastDocument = productsSnapshot.docs.last;
      }

      // #14: Determine if there's more products to request
      _hasMoreProducts = newProducts.length == ProductsLimit;
      // }
    });
  }

  void requestMoreData() => _requestProducts();

  ///////////////////////////////////////////////////////////////////////

}
