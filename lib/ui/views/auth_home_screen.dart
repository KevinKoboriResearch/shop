import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shop/app/providers/google_sign_in.dart';
import 'package:shop/ui/widgets/sign_up_widget.dart';
import 'package:shop/ui/widgets/global/build_loading.dart';
import 'package:shop/ui/views/store/products/store_products_page.dart';
import 'package:shop/ui/views/home/home_page.dart';

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
                return HomePage();
              }
            },
          );
        },
      ),
    );
  }
}
