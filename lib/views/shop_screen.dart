import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:shop/providers/products.dart';
import 'package:shop/widgets/product/product_grid_item.dart';
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

// import '../k_padding.dart';
// import '../responsive.dart';
// import 'items/categories.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/products.dart';
import '../widgets/badge.dart';
import '../widgets/app_drawer.dart';
import '../providers/cart.dart';
import '../utils/app_routes.dart';
import '../utils/my_flutter_app_icons.dart';
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

// import '../widgets/product_grid_item.dart';
import '../providers/products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/auth.dart';
import '../providers/product.dart';
import '../providers/cart.dart';
import '../utils/app_routes.dart';
import '../compound/creation_aware_list_item.dart';
// import 'items/e_commerce_item.dart';

enum FilterOptions {
  Favorite,
  All,
}

class ShopScreen extends StatefulWidget {
  // const ShopScreen({
  //   Key key,
  // }) : super(key: key);
  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen>
    with SingleTickerProviderStateMixin {
  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _showFavoriteOnly = false;
  bool _isLoading = true;
  final auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    Provider.of<Products>(context, listen: false).listenToPosts();
    // loadProducts().then((_) {
    //   setState(() {
    //     _isLoading = false;
    //   });
    // });
  }

  void _refreshProducts(BuildContext context) {
    return Provider.of<Products>(context, listen: false).listenToPosts();
  }

  //  Future<void> _refreshProducts(BuildContext context) {
  //   return Provider.of<Products>(context, listen: false).loadProducts();
  // }

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<Products>(context);
    // final products = showFavoriteOnly
    //     ? productsProvider.favoriteItems
    //     : productsProvider.items;
    // final products = productsProvider.items;
    // final DrawerProvider drawerProvider = Provider.of(context);
    // drawerProvider.pageIndex;
    return Scaffold(
      // key: _scaffoldKey,
      // backgroundColor: Colors.grey[100],
      // drawer: CustomDrawer(),
      extendBody: true,
      drawer: AppDrawer(),
      body: Builder(
        builder: (context) {
          return SafeArea(
            child: productsProvider.items == null
                ? Stack(
                    fit: StackFit.expand,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color>(
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
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red),
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
                        toolbarHeight: 46,
                        expandedHeight: 46,
                        leading: Container(),
                        leadingWidth: 0,
                        flexibleSpace: FlexibleSpaceBar(
                          centerTitle: false,
                          titlePadding:
                              EdgeInsets.fromLTRB(14.0, 0.0, 12.0, 0.0),
                          title: Row(
                            children: [
                              Text('Loja', // snapshotProducts.hasData
                                  //     ? snapshotProducts.data.docs[0]
                                  //         ['companyTitle']
                                  //     : '',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  )),
                              Spacer(),
                              InkWell(
                                onTap: () {
                                  // toggleDrawer();
                                  Scaffold.of(context).openDrawer();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      0.0, 8.0, 0.0, 0.0),
                                  child: Transform(
                                    alignment: Alignment.center,
                                    transform: Matrix4.rotationY(math.pi),
                                    child: Icon(
                                      MyFlutterApp.bookmark,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              InkWell(
                                onTap: () {
                                  // toggleDrawer();
                                  Scaffold.of(context).openDrawer();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      0.0, 6.0, 0.0, 0.0),
                                  child: Transform(
                                    alignment: Alignment.center,
                                    transform: Matrix4.rotationY(math.pi),
                                    child: Icon(MyFlutterApp.remottely_menu),
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
                                  contentPadding:
                                      EdgeInsets.fromLTRB(0, 7, 0, 0),
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
                      SliverToBoxAdapter(
                        child: Container(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children:
                                  List.generate(productsProvider.items.length,
                                      // categories.length,
                                      (index) {
                                return Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      14.0, 0, 0, 8.0),
                                  child: OutlineButton(
                                      child: new Text(
                                        productsProvider.items[index].title,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      onPressed: null,
                                      shape: new RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(
                                                  10.0))),
                                );
                              }),
                            ),
                          ),
                        ),
                      ),

                      SliverPadding(
                        padding: EdgeInsets.fromLTRB(
                          8.0,
                          0.0,
                          8.0,
                          8.0,
                        ),
                        sliver: SliverGrid(
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 210,
                            childAspectRatio: 0.77,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              return CreationAwareListItem(
                                itemCreated: () {
                                  if (index % 6 == 0)
                                    productsProvider.requestMoreData();
                                },
                                child: ChangeNotifierProvider.value(
                                  value: productsProvider.items[index],
                                  child: ProductGridItem(),
                                ),
                              );
                              // snapshotproductsProvider.itemsdata.docs[index]);

                              //Container(height: 100, color: Colors.red);
                              // return ChangeNotifierProvider.value(
                              //   value: products[index],
                              //   child: ProductGridItem(),
                              // );
                            },
                            childCount: productsProvider.items.length,
                            // snapshotProducts.data.docs
                            //     .length, //products.length, // widget.snapshotProducts.data.docs.length,
                          ),
                        ),
                      ),
                    ],
                  ),
            // },
          );
        },
      ),
    );
    // drawer: AppDrawer(),
  }
}
