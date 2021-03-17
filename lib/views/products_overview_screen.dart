import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/products.dart';
import '../widgets/product_grid.dart';
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
// import 'package:remottely/views/device/device_detail_page.dart';
// import 'package:remottely/views/device/devices_manage_page_list.dart';
// import 'package:remottely/views/device/device_form_page.dart';
// final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

enum FilterOptions {
  Favorite,
  All,
}

class ProductOverviewScreen extends StatefulWidget {
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  bool _showFavoriteOnly = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Provider.of<Products>(context, listen: false).loadProducts().then((_) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Builder(
        builder: (context) => Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 4.0),
            width: 1000,
            child: CustomScrollView(
              slivers: [
                _isLoading
                    ? SliverToBoxAdapter(
                        child: Container(
                          height: MediaQuery.maybeOf(context).size.height,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      )
                    : SliverAppBar(
                        pinned: true,
                        // toolbarHeight: 40,
                        // elevation: 0,
                        backgroundColor: Colors.white.withOpacity(0.9),
                        leading: InkWell(
                          onTap: () => Scaffold.of(context).openDrawer(),
                          child: Icon(Icons.menu, color: Colors.black),
                        ),
                        centerTitle: true,
                        title: Container(
                          width: 60,
                          child: FadeInImage(
                            placeholder:
                                AssetImage('assets/logo/tapanapanterahs.png'),
                            image:
                                AssetImage('assets/logo/tapanapanterahs.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        // kIsWeb
                        //     ? Text(
                        //         'tapanapanterahs',
                        //         style: TextStyle(
                        //           color: Colors.black,
                        //           fontSize: 32,
                        //         ),
                        //       )
                        //     : null,
                        actions: <Widget>[
                          PopupMenuButton(
                            onSelected: (FilterOptions selectedValue) {
                              setState(
                                () {
                                  if (selectedValue == FilterOptions.Favorite) {
                                    _showFavoriteOnly = true;
                                  } else {
                                    _showFavoriteOnly = false;
                                  }
                                },
                              );
                            },
                            icon: Icon(
                              Icons.more_vert,
                              color: Colors.black,
                            ),
                            itemBuilder: (_) => [
                              PopupMenuItem(
                                child: Text('Somente Favoritos'),
                                value: FilterOptions.Favorite,
                              ),
                              PopupMenuItem(
                                child: Text('Todos'),
                                value: FilterOptions.All,
                              ),
                            ],
                          ),
                          Consumer<Cart>(
                            child: IconButton(
                              icon: Icon(
                                MyFlutterApp.bag, //Icons.shopping_cart,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                Navigator.of(context).pushNamed(AppRoutes.CART);
                              },
                            ),
                            builder: (_, cart, child) => Badge(
                              value: cart.itemsCount.toString(),
                              child: child,
                            ),
                          )
                        ],
                      ),
                SliverToBoxAdapter(
                  child: SizedBox(height: 2.0),
                ),
                ProductGrid(_showFavoriteOnly),
              ],
            ),
          ),
        ),
      ),
      //: ProductGrid(_showFavoriteOnly),
      drawer: AppDrawer(),
    );
  }
}
