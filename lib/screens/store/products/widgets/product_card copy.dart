import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:shop_app/models/Product.dart';
import 'package:shop_app/screens/details/details_screen.dart';

import 'package:shop_app/constants.dart';
import 'package:shop_app/size_config.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:ui';
import 'package:shop_app/app/functions/product_functions.dart';
import 'package:shop_app/app/utils/my_flutter_app_icons.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/app/providers/product.dart';
import 'package:shop_app/app/providers/cart.dart';
import 'dart:math' as math;
import 'package:flutter/foundation.dart' show kIsWeb;

class ProductCard extends StatelessWidget {
  final String pageType;
  ProductCard(this.pageType);
  // const ProductCard({
  //   Key key,
  //   this.width = 140,
  //   this.aspectRetio = 1.02,
  //   @required this.product,
  // }) : super(key: key);

  // double width, aspectRetio;
  double width = 140;
  // double aspectRetio = 1.02;
  // final Product product;

  @override
  Widget build(BuildContext context) {
    final Color inActiveIconColor = Color(0xFFB6B6B6);
    final Cart cart = Provider.of(context, listen: false);
    final Product product = Provider.of(context, listen: false);
    return Padding(
      //  padding: EdgeInsets.fromLTRB(6.0, 0.0, 6.0, 6.0),
      padding: EdgeInsets.fromLTRB(getProportionateScreenWidth(6), 0.0,
          getProportionateScreenWidth(6), getProportionateScreenWidth(6)),
      child: SizedBox(
        // width: getProportionateScreenWidth(width),
        child: GestureDetector(
          onTap: () {
            // Navigator.pushNamed(
            //   context,
            //   DetailsScreen.routeName,
            //   arguments: ProductDetailsArguments(product: product),
            // );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //       ClipRRect(
              // borderRadius: BorderRadius.circular(6),child:Hero(
              //         tag: product.id.toString(),
              //         child: CachedNetworkImage(
              //       imageUrl: product.images[0]['url'], //images[0]url,
              //       placeholder: (context, url) =>
              //           new CircularProgressIndicator(),
              //       errorWidget: (context, url, error) =>
              //           Center(child: Icon(Icons.error)),
              //     ),),
              //       ),
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Stack(
                  children: [
                    CachedNetworkImage(
                      imageUrl: product.images[0]['url'], //images[0]url,
                      placeholder: (context, url) =>
                          new CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          Center(child: Icon(Icons.error)),
                    ),
                    Column(
                      children: [
                        // InkWell(
                        //   borderRadius: BorderRadius.circular(50),
                        //   onTap: () {},
                        //   child: Container(
                        //     padding: EdgeInsets.fromLTRB(
                        //         getProportionateScreenWidth(6),
                        //         0.0,
                        //         getProportionateScreenWidth(6),
                        //         getProportionateScreenWidth(2)),

                        //     // height: getProportionateScreenWidth(28),
                        //     width: getProportionateScreenWidth(1000),
                        //     decoration: BoxDecoration(
                        //         color: kPrimaryColor.withOpacity(0.6)
                        //         // shape: BoxShape.circle,
                        //         ),
                        //     child: Text(
                        //       product.companyTitle + 'sdfsdfsfsdfsfsf',
                        //       style: TextStyle(color: Colors.white),
                        //       maxLines: 1,
                        //       overflow: TextOverflow.ellipsis,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                    //    Text(
                    //   product.title,
                    //   style: TextStyle(color: Colors.black),
                    //   maxLines: 1,
                    //   overflow: TextOverflow.ellipsis,
                    // ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Consumer<Product>(builder: (ctx, product, _) {
                        return InkWell(
                          borderRadius: BorderRadius.circular(50),
                          onTap: () {
                            product.toggleFavorite(ctx, pageType,
                                'remottelyCompanies/${product.companyTitle}/productCategories/${product.categoryTitle}/products/${product.id}');
                          },
                          child: Container(
                            padding:
                                EdgeInsets.all(getProportionateScreenWidth(8)),
                            height: getProportionateScreenWidth(28),
                            width: getProportionateScreenWidth(28),
                            decoration: BoxDecoration(
                              color: product.isFavorite
                                  ? Colors.white.withOpacity(
                                      0.7) //kPrimaryColor.withOpacity(0.6)
                                  : Colors.black.withOpacity(
                                      0.4), //kSecondaryColor.withOpacity(0.6),
                              // shape: BoxShape.circle,
                            ),
                            child: SvgPicture.asset(
                              "assets/icons/Heart Icon_2.svg",
                              color: product.isFavorite
                                  ? Colors
                                      .black //Colors.white //Color(0xFFFF4848)
                                  : Colors.blue, //Color(0xFFDBDEE4),
                            ),
                          ),
                        );
                      }),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Consumer<Product>(builder: (ctx, product, _) {
                        return InkWell(
                          borderRadius: BorderRadius.circular(50),
                          onTap: () {
                            product.toggleFavorite(ctx, pageType,
                                'remottelyCompanies/${product.companyTitle}/productCategories/${product.categoryTitle}/products/${product.id}');
                          },
                          child: Container(
                            padding:
                                EdgeInsets.all(getProportionateScreenWidth(8)),
                            height: getProportionateScreenWidth(28),
                            width: getProportionateScreenWidth(28),
                            child: SvgPicture.asset(
                              "assets/icons/Heart Icon_2.svg",
                              color: product.isFavorite
                                  ? Color(0xFFFF4848)
                                  : Color(0xFFDBDEE4),
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                product.title,
                style: TextStyle(color: Colors.black),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'R\$' +
                        ProductFunctions().doubleValueToCurrency(
                            product.price), // "\$${product.price}",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(16),
                      fontWeight: FontWeight.w600,
                      color: kPrimaryColor,
                    ),
                  ),
                  Consumer<Product>(builder: (ctx, product, _) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 0.0),
                      child: IconButton(
                          icon: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: SvgPicture.asset(
                              "assets/miscellaneous/svg/081-shopping-bags.svg",
                              width: 6,
                              height: 6,
                              color:
                                  inActiveIconColor, //"assets/icons/Chat bubble Icon.svg",
                            ),
                          ),
                          onPressed: () {
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
                          }),

                      // InkWell(
                      //   onTap: () async {
                      //     Scaffold.of(context).hideCurrentSnackBar();
                      //     Scaffold.of(context).showSnackBar(
                      //       SnackBar(
                      //         content: Text(
                      //           'Produto adicionado com sucesso!',
                      //         ),
                      //         duration: Duration(seconds: 2),
                      //         action: SnackBarAction(
                      //           label: 'DESFAZER',
                      //           onPressed: () {
                      //             cart.removeSingleItem(product.id);
                      //           },
                      //         ),
                      //       ),
                      //     );
                      //     cart.addItem(product);
                      //   },081-shopping-bags
                      //   child:
                      //   // Transform(
                      //   //   alignment: Alignment.center,
                      //   //   transform: Matrix4.rotationY(math.pi),
                      //   //   child: Icon(
                      //   //     MyFlutterApp.bag,
                      //   //     size: 22,
                      //   //     color: Colors.deepPurple,
                      //   //   ),
                      //   // ),
                      // ),
                    );
                  }),
                  // InkWell(
                  //   borderRadius: BorderRadius.circular(50),
                  //   onTap: () {
                  //           //                   product.toggleFavorite(contex, widget.pageType,
                  //           // 'remottelyCompanies/${product.companyTitle}/productCategories/${product.categoryTitle}/products/${product.id}');
                  //   },
                  //   child: Container(
                  //     padding: EdgeInsets.all(getProportionateScreenWidth(8)),
                  //     height: getProportionateScreenWidth(28),
                  //     width: getProportionateScreenWidth(28),
                  //     decoration: BoxDecoration(
                  //       color: product.isFavorite
                  //           ? kPrimaryColor.withOpacity(0.15)
                  //           : kSecondaryColor.withOpacity(0.1),
                  //       shape: BoxShape.circle,
                  //     ),
                  //     child: SvgPicture.asset(
                  //       "assets/icons/Heart Icon_2.svg",
                  //       color: product.isFavorite
                  //           ? Color(0xFFFF4848)
                  //           : Color(0xFFDBDEE4),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(width: getProportionateScreenWidth(0),)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
