import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:shop/providers/products.dart';
import 'package:shop/views/store/products/widgets/product_grid_item.dart';
// import 'package:shop/widgets/badge.dart';
// import 'package:shop/widgets/app_drawer.dart';
// import 'package:shop/providers/cart.dart';
// import 'package:shop/utils/app_routes.dart';
import 'package:shop/utils/my_flutter_app_icons.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:shop/views/device/device_detail_page.dart';
// import 'package:shop/views/device/devices_manage_page_list.dart';
// import 'package:shop/views/device/device_form_page.dart';
// final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import 'package:shop/widgets/product/product_grid_item.dart';
// import 'package:shop/providers/products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:shop/providers/auth.dart';
// import 'package:shop/providers/product.dart';
// import 'package:shop/providers/cart.dart';
// import 'package:shop/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:shop/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop/utils/my_flutter_app_icons.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
// import 'package:shop/providers/drawer_provider.dart';

// import 'package:shop/views/control/app_drawer.dart';

// import 'package:shop/screens/login_screen.dart';
// import 'package:shop/tiles/drawer_tile.dart';
// import 'package:shop/views/control/app_shell.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shop/utils/my_flutter_app_icons.dart';
// import 'package:shop/router/shop_app_state.dart';
// import 'package:shop/utils/shop_icons.dart';
// import 'package:shop/router/inner_router_delegate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:shop/utils/my_flutter_app_icons.dart';
// import 'package:shop/router/shop_app_state.dart';
// import 'package:shop/router/inner_router_delegate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shop/providers/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shop/utils/constants.dart';
// import 'package:shop/providers/drawer_provider.dart';
// import 'package:shop/tiles/drawer_tile.dart';
import 'dart:math' as math;
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
// import 'package:shop/providers/drawer_provider.dart';
import 'package:flutter/material.dart';
// import 'package:shop/eCommerce/e_com_drawer.dart';
// import 'package:shop/eCommerce/e_com_item_description.dart';
// import 'package:shop/models/product_item.dart';

// import 'package:shop/k_padding.dart';
// import 'package:shop/responsive.dart';
// import 'items/categories.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/products.dart';
import 'package:shop/widgets/badge.dart';
import 'package:shop/widgets/app_drawer.dart';
import 'package:shop/providers/cart.dart';
import 'package:shop/utils/app_routes.dart';
import 'package:shop/utils/my_flutter_app_icons.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:shop/views/device/device_detail_page.dart';
// import 'package:shop/views/device/devices_manage_page_list.dart';
// import 'package:shop/views/device/device_form_page.dart';
// final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import 'package:shop/widgets/product_grid_item.dart';
import 'package:shop/providers/products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/auth.dart';
import 'package:shop/providers/product.dart';
import 'package:shop/providers/cart.dart';
import 'package:shop/utils/app_routes.dart';
import 'package:shop/data/creation_aware_list_item.dart';
import 'package:shop/utils/app_routes.dart';
// import 'items/e_commerce_item.dart';

enum FilterOptions {
  Favorite,
  All,
}

class FavoritesProductsPage extends StatefulWidget {
  // const FavoritesProductsPage({
  //   Key key,
  // }) : super(key: key);
  @override
  _FavoritesProductsPageState createState() => _FavoritesProductsPageState();
}

class _FavoritesProductsPageState extends State<FavoritesProductsPage>
    with SingleTickerProviderStateMixin {
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
      body:
          // Builder(
          //   builder: (context) {
          //     return
          SafeArea(
        child: products == null
            ? Stack(
                fit: StackFit.expand,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed))
                            return Colors.blue;
                          return Colors
                              .white; //Color(0xffDDDDDD); // Use the component's default.
                        },
                      ),
                    ),
                    onPressed: () async {
                      // final provider =
                      //     Provider.of<GoogleSignInProvider>(context, listen: false);
                      // await provider.login(context);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          child: Icon(
                            Icons.menu,
                            color: Colors.black,
                          ),
                          onTap: () {
                            Scaffold.of(context).openDrawer();
                          },
                        ),
                        SizedBox(height: 64),
                        Text(
                          'R E M O T T E L Y',
                          style: TextStyle(
                            // depth: 1,
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'anurati',
                          ),
                        ),
                        Spacer(flex: 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Criar ', //'Sign In With ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.grey[600]),
                            ),
                            Text(
                              'L',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.blue),
                            ),
                            Text(
                              'o',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.red),
                            ),
                            Text(
                              'j',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.yellow[800]),
                            ),
                            Text(
                              'a',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.green),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Clique na tela',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.red),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                ],
              )
            : CustomScrollView(
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
                      titlePadding: EdgeInsets.fromLTRB(14.0, 0.0, 12.0, 0.0),
                      title: Row(
                        children: [
                          Text('Favoritos', // products != []
                              //     ? products[0].companyTitle
                              //     : '',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              )),
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
                              padding:
                                  const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
                              child: Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.rotationY(math.pi),
                                child: Icon(
                                  Icons.bookmark,
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              // toggleDrawer();
                              Scaffold.of(context).openDrawer();
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
                              child: Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.rotationY(math.pi),
                                child: Icon(
                                  MyFlutterApp.remottely_basket,
                                  // size: 20,
                                ),
                              ),
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
                    title: Padding(
                      padding: EdgeInsets.all(12),
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
                              child: Text('Lista vazia'),
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
