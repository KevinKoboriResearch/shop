import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/ui/views/store/products/widgets/product_grid_item.dart';
import 'package:shop/app/utils/my_flutter_app_icons.dart';
import 'dart:math' as math;
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/foundation.dart';
import 'package:shop/app/providers/products.dart';
import 'package:shop/ui/widgets/badge.dart';
import 'package:shop/ui/widgets/app_drawer.dart';
import 'package:shop/app/providers/cart.dart';
import 'package:shop/app/utils/app_routes.dart';
import 'package:shop/app/services/creation_aware_list_item.dart';
// import 'items/e_commerce_item.dart';

enum FilterOptions {
  Favorite,
  All,
}

class FavoritesProductsPage extends StatefulWidget {
  const FavoritesProductsPage({
    Key key,
  }) : super(key: key);
  @override
  _FavoritesProductsPageState createState() => _FavoritesProductsPageState();
}

class _FavoritesProductsPageState extends State<FavoritesProductsPage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // bool _showFavoriteOnly = false;
  final auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    Provider.of<Products>(context, listen: false)
        .listenToUserFavoriteProducts();
  }
  // final collectionReference = FirebaseFirestore.instance
  //       .collection('users')
  //       .doc('FYRjAaP0FHSr6DoFSX5KwVzObcn1')//FirebaseAuth.instance.currentUser.uid.toString()) // .doc(product.companyTitle) //
  //       .collection('favorites');

  // @override
  // void initState() {
  //   super.initState();
  //   Provider.of<Products>(context, listen: false)
  //       .listenToUserFavoriteProducts(collectionReference, 'companyTitle', 6);
  // }

  // void _refreshProducts(BuildContext context) {
  //   return Provider.of<Products>(context, listen: false)
  //       .listenToUserFavoriteProducts(collectionReference, 'title', 6);
  // }

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<Products>(context);
    final products = productsProvider.favoriteItems;

    return Scaffold(
      extendBody: true,
      endDrawer: AppDrawer(),
      key: _scaffoldKey,
      body:
          // Builder(
          //   builder: (context) {
          //     return
          SafeArea(
        child: products == null
            ? CircularProgressIndicator() : CustomScrollView(
                slivers: [
                  // padding: EdgeInsets.only(top: kIsWeb ? kPadding : 0),
                  kIsWeb
                      ? SliverToBoxAdapter(child: SizedBox(height: 20))
                      : SliverToBoxAdapter(),
                  // SliverToBoxAdapter(child: SizedBox(height: 60)),
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
                            child: Text(
                                'Favoritosasdadadadadadadadasdas', // products.length != 0
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
                          InkWell(
                            onTap: () {
                              // setState(() {
                              //   _showFavoriteOnly = !_showFavoriteOnly;
                              // });
                              // Navigator.of(context).pushNamed(
                              //   AppRoutes.FAVORITES,
                              // );
                              Navigator.of(context).pop();
                            },
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  8.0, 8.0, 12.0, 0.0),
                              child: Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.rotationY(math.pi),
                                child: kIsWeb
                                    ? Icon(
                                        Icons.bookmark,
                                        size: 24,
                                      )
                                    : NeumorphicIcon(
                                        Icons.bookmark,
                                        size: 24,
                                        style: NeumorphicStyle(
                                          color: Colors.black,
                                          depth: 1,
                                          intensity: 1,
                                          lightSource: LightSource.lerp(
                                              LightSource.bottom,
                                              LightSource.top,
                                              1),
                                        ),
                                      ),
                              ),
                            ),
                          ),
                          Consumer<Cart>(
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).pushNamed(AppRoutes.CART);
                              },
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    8.0, 8.0, 16.0, 0.0),
                                child: Transform(
                                  alignment: Alignment.center,
                                  transform: Matrix4.rotationY(math.pi),
                                  child: Icon(
                                    MyFlutterApp.bag,
                                    // size: 20,
                                  ),
                                ),
                              ),
                            ),
                            builder: (_, cart, child) => Badge(
                              value: cart.itemsCount.toString(),
                              child: child,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverAppBar(
                    pinned: true,
                    backgroundColor: Colors.white,
                    elevation: 0,
                    toolbarHeight: 56,
                    titleSpacing: 0,
                    leading: Container(),
                    leadingWidth: 0,
                    actions: [
                      InkWell(
                        onTap: () {
                          _scaffoldKey.currentState.openEndDrawer();
                        },
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(8.0, 0.0, 16.0, 0.0),
                          child: Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.rotationY(math.pi),
                            child: Icon(
                              MyFlutterApp.sort,
                              color: Colors.black,
                              // size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                    title: Padding(
                      padding: EdgeInsets.fromLTRB(12.0, 12.0, 6.0, 12.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        // child: Expanded(
                        child: Container(
                          height: 34,
                          child: TextField(
                            // expands: false,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              fillColor: Colors.grey[200],
                              filled: true,
                              prefixIcon: Icon(Icons.search, size: 24),
                              // prefixStyle: TextStyle(),
                              border: InputBorder.none,
                              // labelText: "Search by Name",
                              hintText: "Pesquisar",
                              hintStyle: TextStyle(color: Colors.grey),
                              contentPadding: EdgeInsets.fromLTRB(0, 7, 0, 0),
                              isDense: true,
                            ),
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        // ),
                      ),
                    ),
                  ),
                  productsProvider.favoriteCompanies == null
                      ? SliverToBoxAdapter()
                      : SliverToBoxAdapter(
                          child: Container(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(
                                    productsProvider.favoriteCompanies.length,
                                    (index) {
                                  return Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        index == 0.0 ? 14.0 : 4.0,
                                        0.0,
                                        index ==
                                                productsProvider
                                                        .favoriteCompanies
                                                        .length -
                                                    1
                                            ? 14.0
                                            : 0.0,
                                        0.0),
                                    child: OutlinedButton(
                                      child: new Text(
                                        productsProvider
                                                .favoriteCompanies[index]
                                            ['companyTitle'],
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      onPressed: null,
                                      style: OutlinedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      // clipBehavior: Clip.values(CupertinoIcons.textformat_123),
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ),
                        ),
                  SliverToBoxAdapter(child: SizedBox(height: 8.0)),
                  products.length == 0
                      ? SliverToBoxAdapter(
                          child: Container(
                            height: MediaQuery.of(context).size.height - 200,
                            child: Center(
                              child: Text('...'),
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
                            gridDelegate:
                                SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 203,
                              childAspectRatio: 0.78,
                            ),
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                return CreationAwareListItem(
                                  itemCreated: () {
                                    if (index % 6 == 0)
                                      productsProvider
                                          .requestMoreUserFavoriteProductsData();
                                  },
                                  child: ChangeNotifierProvider.value(
                                    value: products[index],
                                    child: ProductGridItem('favorites'),
                                  ),
                                );
                              },
                              childCount: products.length,
                            ),
                          ),
                        ),
                ],
              ),
        // },
        //   );
        // },
      ),
    );
    // drawer: AppDrawer(),
  }
}
