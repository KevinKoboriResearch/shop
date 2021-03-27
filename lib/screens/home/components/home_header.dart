import 'package:flutter/material.dart';
import 'package:shop_app/screens/cart/cart_screen.dart';

import '../../../size_config.dart';
import '../../../components/icon_btn_rounded.dart';
import 'search_field.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/components/badge.dart';
// import 'package:shop_app/ui/widgets/app_drawer.dart';
import 'package:shop_app/app/utils/my_flutter_app_icons.dart';
import 'dart:math' as math;
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:shop_app/app/providers/products.dart';
// import 'package:shop_app/ui/widgets/badge.dart';
import 'package:shop_app/app/providers/cart.dart';
import 'package:shop_app/app/utils/app_routes.dart';
import 'package:shop_app/app/services/creation_aware_list_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:shop_app/screens/store/products/widgets/product_card.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      backgroundColor: Colors.white,
      elevation: 0,
      toolbarHeight: 66,
      titleSpacing: 0,
      leading: Container(),
      leadingWidth: 0,
      title: Padding(
        padding: EdgeInsets.symmetric(
            // vertical: getProportionateScreenWidth(14),
            horizontal: getProportionateScreenWidth(14)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SearchField(),
            // IconBtnWithCounter(
            //   svgSrc: "assets/icons/Cart Icon.svg",
            //   press: () => Navigator.pushNamed(context, CartScreen.routeName),
            // ),
            // IconBtnWithCounter(
            //   svgSrc: "assets/icons/Bell.svg",
            //   numOfitem: 3,
            //   press: () {},
            // ),
            Consumer<Cart>(
              // child: IconBtnWithCounter(
              //   svgSrc: "assets/icons/Cart Icon.svg",
              //   numOfitem: 0,
              //   press: () {},
              // ),
              builder: (_, cart, child) => Badge(
                value: cart.itemsCount.toString(),
                child: IconBtnWithCounter(
                  svgSrc: "assets/miscellaneous/svg/081-shopping-bags.svg",//"assets/icons/Cart Icon.svg",
                  numOfitem: cart.itemsCount,
                  press: () {
                    Navigator.pushNamed(context, CartScreen.routeName);
                  },
                ),
              ),
            ),
            Consumer<Cart>(
              child: IconBtnWithCounter(
                svgSrc: "assets/icons/Bell.svg",
                numOfitem: 3,
                press: () {},
              ),
              builder: (_, cart, child) => Badge(
                value: (cart.itemsCount + 3).toString(),
                child: child,
              ),
            ),
          ],
        ),
      ),
      // Padding(
      //   padding: EdgeInsets.fromLTRB(12.0, 12.0, 6.0, 12.0),
      //   child: ClipRRect(
      //     borderRadius: BorderRadius.circular(10),
      //     // child: Expanded(
      //     child: Container(
      //       height: 34,
      //       child: TextField(
      //         // expands: false,
      //         keyboardType: TextInputType.text,
      //         decoration: InputDecoration(
      //           fillColor: Colors.grey[200],
      //           filled: true,
      //           prefixIcon: Icon(Icons.search, size: 24),
      //           // prefixStyle: TextStyle(),
      //           border: InputBorder.none,
      //           // labelText: "Search by Name",
      //           hintText: "Pesquisar",
      //           hintStyle: TextStyle(color: Colors.grey),
      //           contentPadding: EdgeInsets.fromLTRB(0, 7, 0, 0),
      //           isDense: true,
      //         ),
      //         style: TextStyle(
      //           fontSize: 16.0,
      //           color: Colors.black,
      //         ),
      //       ),
      //     ),
      //     // ),
      //   ),
      // ),
      // actions: [
      //   InkWell(
      //     onTap: () {
      //       // _scaffoldKey.currentState.openEndDrawer();
      //     },
      //     child: Padding(
      //       padding: const EdgeInsets.fromLTRB(8.0, 0.0, 16.0, 0.0),
      //       child: Transform(
      //         alignment: Alignment.center,
      //         transform: Matrix4.rotationY(math.pi),
      //         child: Icon(
      //           MyFlutterApp.sort,
      //           color: Colors.black,
      //           // size: 20,
      //         ),
      //       ),
      //     ),
      //   ),
      // ],
    );

    // Padding(
    //   padding:
    //       EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //     children: [
    //       SearchField(),
    //       // IconBtnWithCounter(
    //       //   svgSrc: "assets/icons/Cart Icon.svg",
    //       //   press: () => Navigator.pushNamed(context, CartScreen.routeName),
    //       // ),
    //       // IconBtnWithCounter(
    //       //   svgSrc: "assets/icons/Bell.svg",
    //       //   numOfitem: 3,
    //       //   press: () {},
    //       // ),
    //       Consumer<Cart>(
    //         child: IconBtnWithCounter(
    //         svgSrc: "assets/icons/Cart Icon.svg",
    //         numOfitem: 3,
    //         press: () {},
    //       ),
    //         builder: (_, cart, child) => Badge(
    //           value: cart.itemsCount.toString(),
    //           child: child,
    //         ),
    //       ),
    //       Consumer<Cart>(
    //         child: IconBtnWithCounter(
    //         svgSrc: "assets/icons/Bell.svg",
    //         numOfitem: 3,
    //         press: () {},
    //       ),
    //         builder: (_, cart, child) => Badge(
    //           value: (cart.itemsCount + 3).toString(),
    //           child: child,
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
