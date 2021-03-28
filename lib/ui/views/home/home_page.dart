import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/ui/views/home/widgets/home_product_grid_item.dart';
import 'package:shop/ui/widgets/app_drawer.dart';
import 'package:shop/app/utils/my_flutter_app_icons.dart';
import 'dart:math' as math;
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:shop/app/providers/products.dart';
import 'package:shop/ui/widgets/badge.dart';
import 'package:shop/app/providers/cart.dart';
import 'package:shop/app/utils/app_routes.dart';
import 'package:shop/ui/views/cart/cart_screen.dart';
import 'package:shop/app/services/creation_aware_list_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key key,
  }) : super(key: key);
  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  // bool _showFavoriteOnly = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    Provider.of<Products>(context, listen: false).listenToProducts();
  }

  void _refreshProducts(BuildContext context) {
    return Provider.of<Products>(context, listen: false).listenToProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<Products>(context);
    final products = productsProvider.items;

    return Scaffold(
      extendBody: true,
      key: _scaffoldKey,
      // backgroundColor: Colors.grey[200],
      endDrawer: AppDrawer(),
      body: Builder(
        builder: (context) {
          return SafeArea(
            child: products == null
                ? CircularProgressIndicator()
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
                          titlePadding:
                              EdgeInsets.fromLTRB(16.0, 0.0, 0.0, 0.0),
                          title: Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width - 106,
                                child: Text(
                                    products.length != 0
                                        ? 'Lojas' //products[0].companyTitle
                                        : '',
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
                                  _scaffoldKey.currentState.openEndDrawer();
                                },
                                child: Container(
                                  width: 46,
                                  child: Transform(
                                    alignment: Alignment.center,
                                    transform: Matrix4.rotationY(math.pi),
                                    child: Icon(
                                      MyFlutterApp.sort,
                                      color: Colors.black,
                                      size: 28,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 6)
                            ],
                          ),
                        ),
                      ),
                      //  SliverToBoxAdapter(child: SizedBox(height: 4.0)),
                      SliverAppBar(
                        pinned: true,
                        backgroundColor: Colors.white,
                        elevation: 0,
                        toolbarHeight: 50,
                        titleSpacing: 0,
                        leading: Container(),
                        leadingWidth: 0,
                        actions: [
                          Container(
                            height: 0,
                            width: 0,
                          )
                        ],
                        title: Padding(
                          padding: EdgeInsets.fromLTRB(14.0, 0.0, 14.0, 0.0),
                          child: Container(
                            // width: SizeConfig.screenWidth * 0.64,
                            height: 36,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextField(
                              onChanged: (value) => print(value),
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 12),
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  hintText: "Procurar produto...",
                                  hintStyle: TextStyle(color: Colors.grey[400]),
                                  prefixIcon: Icon(Icons.search)),
                            ),
                          ),
                        ),
                      ),
                      //  SliverToBoxAdapter(child: SizedBox(height: 4)),
                      SliverToBoxAdapter(
                        child: Container(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(products.length,
                                  // categories.length,
                                  (index) {
                                return Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      index == 0 ? 14.0 : 6.0,
                                      0.0,
                                      index != products.length - 1 ? 0.0 : 14.0,
                                      0.0),
                                  child: OutlinedButton(
                                    child: new Text(
                                      products[index].companyTitle,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    onPressed: null,
                                    style: OutlinedButton.styleFrom(
                                      backgroundColor:
                                          Colors.grey.withOpacity(0.1),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      side: BorderSide(
                                          width: 1, color: Colors.transparent),
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
                                height:
                                    MediaQuery.of(context).size.height - 200,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            )
                          : SliverPadding(
                              padding: EdgeInsets.fromLTRB(
                                7.0,
                                0.0,
                                7.0,
                                2.0,
                              ),
                              sliver: SliverGrid(
                                gridDelegate:
                                    SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 203,
                                  childAspectRatio: 0.96,
                                ),
                                delegate: SliverChildBuilderDelegate(
                                  (context, index) {
                                    return CreationAwareListItem(
                                      itemCreated: () {
                                        if (index % 6 == 0)
                                          productsProvider
                                              .requestMoreCompanyProductsData();
                                      },
                                      child: ChangeNotifierProvider.value(
                                        value: products[index],
                                        child: HomeProductGridItem('store'),
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
          );
        },
      ),
    );
    // drawer: AppDrawer(),
  }
}
