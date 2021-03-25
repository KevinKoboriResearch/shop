import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'dart:ui';
import 'dart:io';
// import 'package:shop/utils/my_flutter_app_icons_2.dart';
import 'package:shop/functions/product_functions.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:shop/models/image_model.dart';
// import 'package:shop/models/product_model.dart';
// import 'package:shop/data/firestore/products_collection.dart';
import 'package:shop/utils/my_flutter_app_icons.dart';
import 'package:shop/utils/constants.dart';
// import 'package:shop/utils/via_cep_service.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:shop/exceptions/http_exception.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
// import 'package:shop/functions/flushbar.dart';
import 'package:flutter/services.dart';
// import 'package:shop/functions/streams.dart';
import 'package:image_cropper/image_cropper.dart';
// import 'package:shop/validators/product_validators.dart';
// import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:shop/providers/auth.dart';
// import 'package:shop/utils/my_flutter_app_icons.dart';
import 'package:shop/providers/product.dart';
// import 'package:shop/providers/cart.dart';
// import 'package:shop/utils/app_routes.dart';

class ProductGridItem extends StatefulWidget {
  final String pageType;
  ProductGridItem(this.pageType);
  @override
  _ProductGridItemState createState() => _ProductGridItemState();
}

class _ProductGridItemState extends State<ProductGridItem> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool value = false;

  @override
  Widget build(BuildContext context) {
    final Product product = Provider.of(context, listen: false);
    return Padding(
      padding: EdgeInsets.fromLTRB(6.0, 0.0, 6.0, 6.0),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Hero(
              tag: product.id,
              child: CachedNetworkImage(
                imageUrl: product.images[0]['url'], //images[0]url,
                placeholder: (context, url) => new CircularProgressIndicator(),
                errorWidget: (context, url, error) =>
                    Center(child: Icon(Icons.error)),
              ),
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5.0, right: 24.0),
                child: LayoutBuilder(
                  builder: (context, size) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(
                          product.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            // fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.grey[500],
                          ),
                        ),
                        Text(
                          product.subtitle,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        Row(
                          children: [
                            product.price != 0.00
                                ? product.promotion != 0.00
                                    ? Text(
                                        ProductFunctions()
                                            .doubleValueToCurrency(
                                                product.price),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[500],
                                          decoration:
                                              TextDecoration.lineThrough,
                                        ),
                                      )
                                    : Text(
                                        'R\$ ' +
                                            ProductFunctions()
                                                .doubleValueToCurrency(product
                                                    .price),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[500],
                                        ),
                                      )
                                : Container(width: 0.0, height: 0.0),
                            product.promotion != 0.00
                                ? Text(
                                    ' / R\$ ' +
                                        ProductFunctions()
                                            .doubleValueToCurrency(product
                                                .promotion),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.red[800],
                                    ),
                                  )
                                : Container(width: 0.0, height: 0.0),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
              Positioned(
                right: 0,
                child: Consumer<Product>(builder: (ctx, product, _) {
                  return InkWell(
                    onTap: () async {
                      product.toggleFavorite(ctx, widget.pageType,
                          'remottelyCompanies/${product.companyTitle}/productCategories/${product.categoryTitle}/products/${product.id}');
                    },
                    child: Icon(
                      product.isFavorite
                          ? Icons.bookmark
                          : Icons.bookmark_border,
                      size: 26,
                    ),
                  );
                }
                    ),
              ),
            ],
          ),
          Spacer(),
        ],
      ),
    );
  }
}
