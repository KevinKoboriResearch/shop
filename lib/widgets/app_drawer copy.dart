import 'package:flutter/material.dart';
import 'package:shop/tiles/drawer_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class AppDrawer extends StatelessWidget {
  final _auth = FirebaseAuth.instance.currentUser;
  // final PageController pageController;

  // AppDrawer(this.pageController);

  @override
  Widget build(BuildContext context) {
    Widget _buildDrawerBack() => Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Colors.deepOrange.withOpacity(0.6),//Color.fromARGB(255, 203, 236, 241),
            Colors.white,
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        );

    return Drawer(
      child: Stack(
        children: <Widget>[
          _buildDrawerBack(),
          ListView(
            padding: EdgeInsets.only(left: 32.0, top: 16.0),
            children: <Widget>[
              SizedBox(
                height: 64,
              ),
              Positioned(
                top: 64.0,
                left: 0.0,
                child: Text(
                  "Remottely\nShop",
                  style: TextStyle(fontSize: 34.0, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                "Olá, ${_auth == null ? "" : _auth.displayName}",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              GestureDetector(
                onTap: () {
                  // if (!model.isLoggedIn())
                  //   Navigator.of(context).push(MaterialPageRoute(
                  //       builder: (context) => LoginScreen()));
                  // else
                  //   model.signOut();
                },
                child: Text(
                  _auth == null ? "Entre ou cadastre-se >" : "Sair",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Divider(),
              DrawerTile(Icons.home, "Início"),
              DrawerTile(Icons.list, "Produtos"),
              DrawerTile(Icons.location_on, "Lojas"),
              DrawerTile(Icons.playlist_add_check, "Meus Pedidos"),
            ],
          )
        ],
      ),
    );
  }
}
