import 'package:flutter/material.dart';
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
class Badge extends StatelessWidget {
  final Widget child;
  final String value;
  final Color color;

  Badge({
    @required this.child,
    @required this.value,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        child,
        if (value != 0)
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                height: getProportionateScreenWidth(14),
                width: getProportionateScreenWidth(14),
                decoration: BoxDecoration(
                  color: Color(0xFFFF4848),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    "$value",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(9),
                      height: 1,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
        // Positioned(
        //   left: 2,
        //   top: 2,
        //   child: Container(
        //     decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(10),
        //       color: color != null ? color : Theme.of(context).accentColor,
        //     ),
        //     constraints: BoxConstraints(
        //       minHeight: 15,
        //       minWidth: 15,
        //     ),
        //     child: Text(
        //       value,
        //       textAlign: TextAlign.center,
        //       style: TextStyle(
        //         color: Colors.white,
        //         fontSize: 12,
        //       ),
        //     ),
        //   ),
        // )
      ],
    );
  }
}
