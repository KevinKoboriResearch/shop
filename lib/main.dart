import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/utils/custom_route.dart';

import './utils/app_routes.dart';

import './views/auth_home_screen.dart';
// import './views/products_overview_screen.dart';
import './views/product_detail_screen.dart';
import './views/cart_screen.dart';
import './views/orders_screen.dart';
import './views/products_screen.dart';

import './providers/products.dart';
import './providers/cart.dart';
import './providers/orders.dart';
import './providers/auth.dart';
import 'package:shop/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:shop/views/control/auth_app_page.dart';
// import 'package:remottely/views/device/device_detail_page.dart';
// import 'package:remottely/views/device/devices_manage_page_list.dart';
// import 'package:remottely/views/device/device_form_page.dart';
// import 'package:remottely/utils/constants.dart';
import 'package:firebase_core/firebase_core.dart';
// final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:remottely/utils/constants.dart';
// import 'package:remottely/views/control/auth_screen.dart';
// import 'package:remottely/widgets/design/dot_indicator_widget.dart';
// import 'package:flutter_neumorphic/flutter_neumorphic.dart';
// import 'package:remottely/utils/my_flutter_app_icons.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:remottely/views/control/marketing_page.dart';
// import 'package:remottely/views/control/block_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase/firebase.dart';
// import 'package:flutter_neumorphic/flutter_neumorphic.dart';

// import 'package:remottely/views/device/devices_page_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
// import 'package:remottely/views/device/device_detail_page.dart';
// import 'package:remottely/views/device/device_form_page.dart';
// import 'package:remottely/providers/auth_provider.dart';
// import 'package:remottely/utils/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:remottely/views/control/marketing_page.dart';
// import 'package:remottely/views/control/block_page.dart';
// import 'package:remottely/views/device/devices_page_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
// import 'package:shop/router/shop_app_state.dart';
// import 'package:shop/views/control/app_shell.dart';
// import 'package:shop/router/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shop/providers/google_sign_in.dart';
import 'package:shop/widgets/sign_up_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:shop/widgets/global/build_loading.dart';
import 'package:shop/views/products/product_form_page.dart';

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
            // ChangeNotifierProvider(
            //   create: (_) => new GoogleSignInProvider(),
            // ),
            ChangeNotifierProxyProvider<Auth, Products>(
              create: (_) => new Products(),
              update: (ctx, auth, previousProducts) => new Products(
                auth.token,
                auth.userId,
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
              primaryColor: Colors.white,
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
            routes: {
              AppRoutes.AUTH_HOME: (ctx) => AuthOrHomeScreen(),
              AppRoutes.PRODUCT_DETAIL: (ctx) => ProductDetailScreen(),
              AppRoutes.CART: (ctx) => CartScreen(),
              AppRoutes.ORDERS: (ctx) => OrdersScreen(),
              AppRoutes.PRODUCTS: (ctx) => ProductsScreen(),
              AppRoutes.PRODUCT_FORM: (ctx) => ProductFormPage(
                  'tapanapanterahs', 'Tabacos', null), //ProductFormScreen(),
            },
          ),
        );
      },
    );
  }
}
