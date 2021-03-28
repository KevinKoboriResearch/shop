import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/ui/views/store/products/widgets/product_grid_item.dart';
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

class StoreProductsPage extends StatefulWidget {
  const StoreProductsPage({
    Key key,
  }) : super(key: key);
  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StoreProductsPage>
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
                                _scaffoldKey.currentState.openEndDrawer();
                                // _appShellScaffoldKey.currentState.openEndDrawer();
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
                                        ? 'ZARA' //products[0].companyTitle
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
                          Consumer<Cart>(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => CartScreen()),
  );
                                // Navigator.of(context).pushNamed(AppRoutes.CART);
                              },
                              child: Container(
                                width: 46,
                                child: SvgPicture.asset(
                                  'assets/miscellaneous/svg/081-shopping-bags.svg', //"assets/miscellaneous/svg/014-shopping-cart-1.svg", //075-shopping-cart
                                  height: 22,
                                  width: 22,
                                  semanticsLabel: 'A red up arrow',
                                  color: Colors.grey[800],
                                ),
                              ),
                            ),
                            builder: (_, cart, child) => Badge(
                              value: cart.itemsCount.toString(),
                              child: child,
                            ),
                          ),
                          // InkWell(
                          //   onTap: () {
                          //     Navigator.of(context).pushNamed(
                          //       AppRoutes.FAVORITES,
                          //     );
                          //     // Navigator.of(context).pop();
                          //   },
                          //   child: SvgPicture.asset(
                          //     'assets/icons/Heart Icon_2.svg', //"assets/miscellaneous/svg/014-shopping-cart-1.svg", //075-shopping-cart
                          //     height: 18,
                          //     width: 18,
                          //     semanticsLabel: 'A red up arrow',
                          //     color: Colors.black, //.grey[700],
                          //   ),
                          // ),

                          SizedBox(width: 4)
                        ],
                        title: Padding(
                          padding: EdgeInsets.fromLTRB(14.0, 0.0, 4.0, 0.0),
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
                                      products[index].title,
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
                                  childAspectRatio: 0.80,
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
                                        child: ProductGridItem('store'),
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
