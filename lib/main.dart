import 'package:flutter/material.dart';
import 'package:shop_app/routes.dart';
import 'package:shop_app/screens/profile/profile_screen.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/theme.dart';
import './size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/app/utils/custom_route.dart';

import 'package:shop_app/app/utils/app_routes.dart';

import 'package:shop_app/app/providers/products.dart';
import 'package:shop_app/app/providers/cart.dart';
import 'package:shop_app/app/providers/orders.dart';
import 'package:shop_app/app/providers/auth.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shop_app/app/providers/google_sign_in.dart';
import 'package:shop_app/screens/store/products/product_form_page.dart';
// import 'package:shop_app/app/libraries/rxdart/lib/rxdart.dart';
import 'package:shop_app/screens/store/products/favorites_products_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
            // theme: ThemeData(
            //   // textTheme: TextTheme(headline1: TextStyle(color: Colors.black)),
            //   brightness: Brightness.light,
            //   // hoverColor: Colors.orange,
            //   splashColor: Colors.white,
            //   primaryColor: Colors.black,
            //   dividerColor: Colors.grey[100],
            //   accentColor: Colors.deepOrange,
            //   fontFamily: 'Lato',
            //   canvasColor: Colors.white,
            //   pageTransitionsTheme: PageTransitionsTheme(
            //     builders: {
            //       TargetPlatform.android: CustomPageTransitionsBuilder(),
            //       TargetPlatform.iOS: CustomPageTransitionsBuilder(),
            //     },
            //   ),
            // ),
            theme: theme(),
            initialRoute: HomeScreen.routeName,
            routes: routes,
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
            // routes: {
            //   AppRoutes.AUTH_HOME: (ctx) => AuthOrHomeScreen(),
            //   AppRoutes.PRODUCT_DETAIL: (ctx) => ProductDetailScreen(),
            //   AppRoutes.CART: (ctx) => CartScreen(),
            //   AppRoutes.ORDERS: (ctx) => OrdersScreen(),
            //   AppRoutes.PRODUCTS: (ctx) => ProductsScreen(),
            //     AppRoutes.FAVORITES: (ctx) => FavoritesProductsPage(),
            //   AppRoutes.PRODUCT_FORM: (ctx) => ProductFormPage(
            //       'tapanapanterahs', 'Tabacos', null), //ProductFormScreen(),
            // },
          ),
        );
      },
    );
    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   title: 'Flutter Demo',
    //   theme: theme(),
    //   home: HomeScreen(),
    //   // We use routeName so that we dont need to remember the name
    //   // initialRoute: HomeScreen.routeName,
    //   routes: routes,
    // );
  }
}
