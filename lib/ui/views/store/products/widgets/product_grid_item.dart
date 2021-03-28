import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:ui';
import 'package:shop/app/functions/product_functions.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:shop/app/providers/product.dart';
import 'package:shop/app/providers/cart.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductGridItem extends StatefulWidget {
  final String pageType;
  ProductGridItem(this.pageType);
  @override
  _ProductGridItemState createState() => _ProductGridItemState();
}

class _ProductGridItemState extends State<ProductGridItem> {
  // FirebaseAuth _auth = FirebaseAuth.instance;
  // bool value = false;

  @override
  Widget build(BuildContext context) {
    final Cart cart = Provider.of(context, listen: false);
    final Product product = Provider.of(context, listen: false);
    return Padding(
      padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 6.0),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Stack(
              // fit: StackFit.expand,
              children: [
                CachedNetworkImage(
                  imageUrl: product.images[0]['url'], //images[0]url,
                  placeholder: (context, url) =>
                      new CircularProgressIndicator(),
                  errorWidget: (context, url, error) =>
                      Center(child: Icon(Icons.error)),
                ),
                Positioned(
                  bottom: 4,
                  left: 4,
                  child: Consumer<Product>(builder: (ctx, product, _) {
                    return InkWell(
                      onTap: () async {
                        product.toggleFavorite(ctx, widget.pageType,
                            'remottelyCompanies/${product.companyTitle}/productCategories/${product.categoryTitle}/products/${product.id}');
                      },
                      child: Container(
                        padding: EdgeInsets.fromLTRB(7, 9, 7, 7),
                        height: 26,
                        width: 26,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.8),
                          shape: BoxShape.circle,
                        ),
                        child: product.isFavorite
                            ? SvgPicture.asset(
                                'assets/icons/Heart Icon_2.svg', //"assets/miscellaneous/svg/014-shopping-cart-1.svg", //075-shopping-cart
                                semanticsLabel: 'A red up arrow',
                                color: Colors.white, //.grey[700],
                              )
                            : SvgPicture.asset(
                                'assets/icons/Heart Icon.svg', //"assets/miscellaneous/svg/014-shopping-cart-1.svg", //075-shopping-cart
                                semanticsLabel: 'A red up arrow',
                                color: Colors.white, //.grey[700],
                              ),
                      ),
                    );
                  }),
                ),
                Positioned(
                  bottom: 4,
                  right: 4,
                  child: Consumer<Product>(builder: (ctx, product, _) {
                    return InkWell(
                      onTap: () async {
                        Scaffold.of(context).hideCurrentSnackBar();
                        Scaffold.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Produto adicionado com sucesso!',
                            ),
                            duration: Duration(seconds: 2),
                            action: SnackBarAction(
                              label: 'DESFAZER',
                              onPressed: () {
                                cart.removeSingleItem(product.id);
                              },
                            ),
                          ),
                        );
                        cart.addItem(product);
                      },
                      child: Container(
                        padding: EdgeInsets.fromLTRB(7, 7, 7, 7),
                        height: 26,
                        width: 26,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.8),
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset(
                          'assets/miscellaneous/svg/081-shopping-bags.svg',
                          color: Colors.white,
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5.0, right: 0.0),
                child: LayoutBuilder(
                  builder: (context, size) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(
                          product.title,
                              // +'asdas asda sdas dasd assdasdadadad sadasd a ',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color: Colors.grey[800],
                          ),
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
                                          fontSize: 13,
                                          color: Colors.grey[600],
                                          fontWeight: FontWeight.bold,
                                          decoration:
                                              TextDecoration.lineThrough,
                                        ),
                                      )
                                    : Text(
                                        
                                            ProductFunctions()
                                                .doubleValueToCurrency(
                                                    product.price),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                          color: Colors.grey[600],
                                        ),
                                      )
                                : Container(width: 0.0, height: 0.0),
                            product.promotion != 0.00
                                ? Text(
                                    ' / ' +
                                        ProductFunctions()
                                            .doubleValueToCurrency(
                                                product.promotion),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                      color: Colors.redAccent,
                                    ),
                                  )
                                : Container(width: 0.0, height: 0.0),
                            // product.promotion != 0.00
                            //     ? product.price != 0.00
                            //         ? Text(
                            //             ProductFunctions()
                            //                 .doubleValueToCurrency(
                            //                     product.promotion),
                            //             maxLines: 1,
                            //             overflow: TextOverflow.ellipsis,
                            //             style: TextStyle(
                            //               fontSize: 12,
                            //               color: Colors.grey[800],
                            //               fontWeight: FontWeight.bold,
                            //               decoration:
                            //                   TextDecoration.lineThrough,
                            //             ),
                            //           )
                            //         : Text(
                            //             
                            //                 ProductFunctions()
                            //                     .doubleValueToCurrency(
                            //                         product.promotion),
                            //             maxLines: 1,
                            //             overflow: TextOverflow.ellipsis,
                            //             style: TextStyle(
                            //               fontWeight: FontWeight.bold,
                            //               fontSize: 12,
                            //               color: Colors.grey[800],
                            //             ),
                            //           )
                            //     : Container(width: 12.0, height: 11.0),
                            // product.price != 0.00
                            //     ? Text(
                            //         ' / ' +
                            //             ProductFunctions()
                            //                 .doubleValueToCurrency(
                            //                     product.price),
                            //         maxLines: 1,
                            //         overflow: TextOverflow.ellipsis,
                            //         style: TextStyle(
                            //           fontWeight: FontWeight.bold,
                            //           fontSize: 11,
                            //           color: Colors.redAccent,
                            //         ),
                            //       )
                            //     : Container(width: 0.0, height: 0.0),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
              // Positioned(
              //   bottom: 0,
              //   right: 8,
              //   child: Consumer<Product>(builder: (ctx, product, _) {
              //     return InkWell(
              //       onTap: () async {
              //         Scaffold.of(context).hideCurrentSnackBar();
              //         Scaffold.of(context).showSnackBar(
              //           SnackBar(
              //             content: Text(
              //               'Produto adicionado com sucesso!',
              //             ),
              //             duration: Duration(seconds: 2),
              //             action: SnackBarAction(
              //               label: 'DESFAZER',
              //               onPressed: () {
              //                 cart.removeSingleItem(product.id);
              //               },
              //             ),
              //           ),
              //         );
              //         cart.addItem(product);
              //       },
              //       child: SvgPicture.asset(
              //         'assets/miscellaneous/svg/081-shopping-bags.svg',
              //         width: 18,
              //         height: 18,
              //         color: Colors.grey[800],
              //       ),
              //     );
              //   }),
              // ),
            ],
          ),
          Spacer(),
        ],
      ),
    );
  }
}
