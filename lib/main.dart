import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/app/utils/custom_route.dart';

import 'package:shop/app/utils/app_routes.dart';

import 'package:shop/ui/views/auth_home_screen.dart';
import 'package:shop/ui/views/product_detail_screen.dart';
import 'package:shop/ui/views/cart_screen.dart';
import 'package:shop/ui/views/orders_screen.dart';
import 'package:shop/ui/views/products_screen.dart';

import 'package:shop/app/providers/products.dart';
import 'package:shop/app/providers/cart.dart';
import 'package:shop/app/providers/orders.dart';
import 'package:shop/app/providers/auth.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shop/app/providers/google_sign_in.dart';
import 'package:shop/ui/views/store/products/product_form_page.dart';
// import 'package:shop/app/libraries/rxdart/lib/rxdart.dart';
import 'package:shop/ui/views/store/products/favorites_products_page.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _init = Firebase.initializeApp();
    return FutureBuilder(
      future: _init,
      builder: (ctx, appSnapshot) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => new Auth(),
            ),
            ChangeNotifierProvider(
              create: (_) => new GoogleSignInProvider(),
            ),
            ChangeNotifierProxyProvider<Auth, Products>(
              create: (_) => new Products(),
              update: (ctx, auth, previousProducts) => new Products(
                auth.token,
                auth.userId,
                previousProducts.busy,
                previousProducts.items,
              ),
            ),
            ChangeNotifierProvider(
              create: (_) => new Cart(),
            ),
            ChangeNotifierProxyProvider<Auth, Orders>(
              create: (_) => new Orders(),
              update: (ctx, auth, previousOrders) => new Orders(
                auth.token,
                auth.userId,
                previousOrders.items,
              ),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'tapanapanterahs',
            theme: ThemeData(
              // textTheme: TextTheme(headline1: TextStyle(color: Colors.black)),
              brightness: Brightness.light,
              // hoverColor: Colors.orange,
              splashColor: Colors.white,
              primaryColor: Colors.black,
              dividerColor: Colors.grey[100],
              accentColor: Colors.deepOrange,
              fontFamily: 'Lato',
              canvasColor: Colors.white,
              pageTransitionsTheme: PageTransitionsTheme(
                builders: {
                  TargetPlatform.android: CustomPageTransitionsBuilder(),
                  TargetPlatform.iOS: CustomPageTransitionsBuilder(),
                },
              ),
            ),
            // theme: ThemeData(
            //   // pageTransitionsTheme: PageTransitionsTheme(builders: {
            //   //   TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            //   // }),
            //   // inputDecorationTheme: InputDecorationTheme(
            //   //   border: InputBorder.none,
            //   // ),
            //   hintColor: Colors.transparent,
            //   focusColor: Colors.transparent,
            //   hoverColor: Colors.transparent,
            //   textTheme: TextTheme(
            //     headline1: TextStyle(color: AppColors.astronautOrangeDarkColor),
            //     headline2: TextStyle(color: AppColors.astronautOrangeDarkColor),
            //     headline3: TextStyle(color: AppColors.astronautOrangeDarkColor),
            //     headline4: TextStyle(color: AppColors.astronautOrangeDarkColor),
            //     headline5: TextStyle(color: AppColors.astronautOrangeDarkColor),
            //     headline6: TextStyle(color: AppColors.astronautOrangeDarkColor),
            //     subtitle1: TextStyle(color: AppColors.astronautOrangeDarkColor),
            //     subtitle2: TextStyle(color: AppColors.astronautOrangeDarkColor),
            //     bodyText1: TextStyle(
            //       fontSize: 16,
            //     ),
            //     bodyText2: TextStyle(),
            //   ).apply(
            //     bodyColor: AppColors.textColor,
            //     displayColor: AppColors.astronautOrangeDarkColor,
            //   ),
            //   fontFamily: 'Lato',
            //   accentColor: AppColors.accentColor,
            //   indicatorColor: AppColors.indicatorColor,
            //   primaryColor: AppColors.astratosDarkGreyColor,
            //   canvasColor: AppColors.astronautCanvasColor,
            //   buttonColor: AppColors.astronautCanvasColor,
            //   highlightColor: Colors.transparent,
            //   splashColor: Colors.transparent,
            // ),
            // home: AuthOrHomeScreen(),
            routes: {
              AppRoutes.AUTH_HOME: (ctx) => AuthOrHomeScreen(),
              AppRoutes.PRODUCT_DETAIL: (ctx) => ProductDetailScreen(),
              AppRoutes.CART: (ctx) => CartScreen(),
              AppRoutes.ORDERS: (ctx) => OrdersScreen(),
              AppRoutes.PRODUCTS: (ctx) => ProductsScreen(),
                AppRoutes.FAVORITES: (ctx) => FavoritesProductsPage(),
              AppRoutes.PRODUCT_FORM: (ctx) => ProductFormPage(
                  'tapanapanterahs', 'Tabacos', null), //ProductFormScreen(),
            },
          ),
        );
      },
    );
  }
}
