import 'package:flutter/material.dart';

import '../../../size_config.dart';
import 'categories.dart';
import 'discount_banner.dart';
import 'home_header.dart';
import 'popular_product.dart';
import 'categories_popular.dart';
import 'special_offers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/store/products/widgets/product_grid_item.dart';
// import 'package:shop_app/ui/widgets/app_drawer.dart';
import 'package:shop_app/app/utils/my_flutter_app_icons.dart';
import 'dart:math' as math;
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:shop_app/app/providers/products.dart';
// import 'package:shop_app/ui/widgets/badge.dart';
import 'package:shop_app/app/providers/cart.dart';
import 'package:shop_app/app/utils/app_routes.dart';
import 'package:shop_app/app/services/creation_aware_list_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:shop_app/screens/store/products/widgets/product_card.dart';

class Body extends StatefulWidget {
  const Body({
    Key key,
  }) : super(key: key);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> with SingleTickerProviderStateMixin {
  // bool _showFavoriteOnly = false;
  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    Provider.of<Products>(context, listen: false).listenToProducts();
  }

  // void _refreshProducts(BuildContext context) {
  //   return Provider.of<Products>(context, listen: false).listenToProducts();
  // }

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<Products>(context);
    final products = productsProvider.items;

    return SafeArea(
      child: CustomScrollView(slivers: [
        // SliverToBoxAdapter(
        //     child: Container(height: getProportionateScreenHeight(12))),
        SliverAppBar(
          floating: true,
          snap: true,
          backgroundColor: Colors.white,
          elevation: 0.0,
          toolbarHeight: 48,
          expandedHeight: 46,
          leading: Container(),
          actions: [Container()],
          leadingWidth: 0,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: false,
            titlePadding: EdgeInsets.fromLTRB(14.0, 0.0, 0.0, 0.0),
            title: Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 106,
                  child:
                      // Text(products != [] ? products[0].companyTitle : '',
                      Text('sdfsdf',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,

                          //     ? products[0].companyTitle
                          //     : '',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          )),
                ),
                Spacer(),
              ],
            ),
          ),
        ),
        HomeHeader(),
        SliverToBoxAdapter(
            child: Container(height: getProportionateScreenHeight(0))),
        CategoriesPopular(),
        SliverToBoxAdapter(
            child: Container(height: getProportionateScreenHeight(8))),
        products.length == 0
            ? SliverToBoxAdapter(
                child: Container(
                  height: MediaQuery.of(context).size.height - 200,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              )
            : SliverPadding(
                padding: EdgeInsets.fromLTRB(
                  8.0,
                  0.0,
                  8.0,
                  8.0,
                ),
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 203,
                    childAspectRatio: 0.78,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return CreationAwareListItem(
                        itemCreated: () {
                          if (index % 6 == 0)
                            productsProvider.requestMoreCompanyProductsData();
                        },
                        child: ChangeNotifierProvider.value(
                          value: products[index],
                          child:
                              ProductCard('store'), //ProductGridItem('store'),
                        ),
                      );
                    },
                    childCount: products.length,
                  ),
                ),
              ),
      ]),
      // SingleChildScrollView(
      //   child: Column(
      //     children: [
      //       SizedBox(height: getProportionateScreenHeight(20)),
      //       HomeHeader(),
      //       SizedBox(height: getProportionateScreenWidth(10)),
      //       DiscountBanner(),
      //       Categories(),
      //       SpecialOffers(),
      //       SizedBox(height: getProportionateScreenWidth(30)),
      //       PopularProducts(),
      //       SizedBox(height: getProportionateScreenWidth(30)),
      //     ],
      //   ),
      // ),
    );
  }
}
