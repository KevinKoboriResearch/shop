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
import 'package:shop/views/store/products/store_products_page.dart';

class AuthOrHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                return StorePage();
              }
            },
          );
        },
      ),
    );
  }
}
