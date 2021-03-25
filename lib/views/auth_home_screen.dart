import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';
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
import 'package:shop/views/shop_screen.dart';

class AuthOrHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Auth auth = Provider.of(context);
    // GoogleSignInProvider auth = Provider.of(context);
    // return ChangeNotifierProvider(
    //   create: (context) => GoogleSignInProvider(),
    //   child: FutureBuilder(
    //     future: Future.delayed(Duration(milliseconds: 1000))
    //         .then((_) => FirebaseAuth.instance.authStateChanges()),
    //     builder: (context, snapshot) {
    //         final provider =
    //                         Provider.of<GoogleSignInProvider>(context);
    //       if (snapshot.connectionState == ConnectionState.waiting) {
    //         return Center(child: CircularProgressIndicator());
    //       } else if (snapshot.error != null) {
    //         return Center(child: Text('Ocorreu um erro!'));
    //       } else {
    //         return provider.isSigningIn
    //             ? ProductOverviewScreen()
    //             : SignUpWidget(); // AuthScreen();
    //       }
    //     },
    //   ),
    // );

    return ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: FutureBuilder(
        future: Future.delayed(Duration(milliseconds: 1000))
            .then((_) => FirebaseAuth.instance.authStateChanges()),
        builder: (context, snapshot) {
          return StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              final provider = Provider.of<GoogleSignInProvider>(context);
// appState.selectedIndex =null;
              if (provider.isSigningIn) {
                return buildLoading();
              } else if (!snapshot.hasData) {
                return SignUpWidget();
              } else {
                return ShopScreen();//ShopScreen();//ProductOverviewScreen();
                // if (appState.selectedIndex == null) {
                //   appState.selectedIndex = 0;
                // }
                // return Navigator(
                //   key: navigatorKey,
                //   pages: [
                //     MaterialPage(
                //       child: AppShell(appState: appState),
                //     ),
                //   ],
                //   onPopPage: (route, result) {
                //     if (!route.didPop(result)) {
                //       return true;
                //     }

                //     if (appState.selectedUser != null) {
                //       appState.selectedUser = null;
                //     }
                //     notifyListeners();
                //     return true;
                //   },
                // );
              }
            },
          );
        },
      ),
    );
  }
}
