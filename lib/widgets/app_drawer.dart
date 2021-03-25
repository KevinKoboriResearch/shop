import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/auth.dart';
import '../utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:shop/utils/constants.dart';
// import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:shop/functions/get_initials.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:shop/exceptions/auth_exception.dart';
// import 'package:shop/functions/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shop/utils/constants.dart';
// import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';
// import './auth_screen.dart';
// import './products_overview_screen.dart';
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
class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance.currentUser;
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: <Widget>[
            AppBar(
              // elevation: 0,
              // backgroundColor: Colors.white.withOpacity(0.9),
              // centerTitle: true,
              title: Text(
                '${auth.displayName}',
                style: TextStyle(color: Colors.black),
              ),
              automaticallyImplyLeading: false,
            ),
            Divider(height: 4, color: Colors.grey[100]),
            ListTile(
              tileColor: Colors.white,
              leading: Icon(Icons.shop),
              title: Text('Loja'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(
                  AppRoutes.AUTH_HOME,
                );
              },
            ),
            Divider(height: 4, color: Colors.grey[100]),
            ListTile(
              tileColor: Colors.white,
              leading: Icon(Icons.payment),
              title: Text('Pedidos'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(
                  AppRoutes.ORDERS,
                );
              },
            ),
            Divider(height: 4, color: Colors.grey[100]),
            ListTile(
              tileColor: Colors.white,
              leading: Icon(Icons.edit),
              title: Text('Gerenciar Produtos'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(
                  AppRoutes.PRODUCTS,
                );
              },
            ),
            Divider(height: 4, color: Colors.grey[100]),
            ListTile(
              tileColor: Colors.white,
              leading: Icon(Icons.exit_to_app),
              title: Text('Sair'),
              onTap: () {
                final provider =
                      Provider.of<GoogleSignInProvider>(context, listen: false);
                  provider.logout();
              },
            ),
          ],
        ),
      ),
    );
  }
}
