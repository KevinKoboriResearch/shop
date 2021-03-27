import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants.dart';
import '../size_config.dart';
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

class IconBtnWithCounter extends StatelessWidget {
  const IconBtnWithCounter({
    Key key,
    @required this.svgSrc,
    this.numOfitem = 0,
    @required this.press,
  }) : super(key: key);

  final String svgSrc;
  final int numOfitem;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    final Color inActiveIconColor = Colors.grey[500];
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: press,
      child: Stack(
        overflow: Overflow.visible,
        children: [
          // Consumer<Cart>(
          //   child: InkWell(
          //     onTap: () {
          //       Navigator.of(context).pushNamed(AppRoutes.CART);
          //     },
          //     child: Padding(
          //       padding: const EdgeInsets.fromLTRB(8.0, 8.0, 16.0, 0.0),
          //       child: Transform(
          //         alignment: Alignment.center,
          //         transform: Matrix4.rotationY(math.pi),
          //         child: Icon(
          //           MyFlutterApp.bag,
          //           // size: 20,
          //         ),
          //       ),
          //     ),
          //   ),
          //   builder: (_, cart, child) => Badge(
          //     value: cart.itemsCount.toString(),
          //     child: child,
          //   ),
          // ),
          Container(
            padding: EdgeInsets.all(getProportionateScreenWidth(12)),
            height: getProportionateScreenWidth(46),
            width: getProportionateScreenWidth(46),
            decoration: BoxDecoration(
              color: kSecondaryColor.withOpacity(0.1),
              // numOfitem == 0
              //     ? kSecondaryColor.withOpacity(0.1)
              //     : Colors.red.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
                  svgSrc,
                  // color: inActiveIconColor,
                ),
            // SvgPicture.asset(svgSrc),
          ),
          // if (numOfitem != 0)
          // Positioned(
          //   top: -3,
          //   right: 0,
          //   child: Container(
          //     height: getProportionateScreenWidth(16),
          //     width: getProportionateScreenWidth(16),
          //     decoration: BoxDecoration(
          //       color: Color(0xFFFF4848),
          //       shape: BoxShape.circle,
          //       border: Border.all(width: 1.5, color: Colors.white),
          //     ),
          //     child: Center(
          //       child: Text(
          //         "$numOfitem",
          //         style: TextStyle(
          //           fontSize: getProportionateScreenWidth(10),
          //           height: 1,
          //           fontWeight: FontWeight.w600,
          //           color: Colors.white,
          //         ),
          //       ),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
