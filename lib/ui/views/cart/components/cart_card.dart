import 'package:flutter/material.dart';
// import 'package:shop_app/models/Cart.dart';

import '../../../../constants.dart';
import 'package:shop/app/providers/cart.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:ui';
import 'package:shop/app/functions/product_functions.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:shop/app/providers/product.dart';
import 'package:shop/app/providers/cart.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CartCard extends StatelessWidget {
  const CartCard({
    Key key,
    @required this.cartItem,
    @required this.index,
  }) : super(key: key);

  final cartItem;
  final index;
  @override
  Widget build(BuildContext context) {
    // final Cart cart = Provider.of(context, listen: false);
    // final Product product = Provider.of(context, listen: false);
    // final Cart cart = Provider.of(context, listen: false);
    return Row(
      children: [
        SizedBox(
          width: 88,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            // padding: EdgeInsets.all(10),
            // decoration: BoxDecoration(
            //   color: Color(0xFFF5F6F9),
            //   borderRadius: BorderRadius.circular(15),
            // ),
            child: CachedNetworkImage(
              imageUrl: cartItem.image, //images[0]url,
              placeholder: (context, url) => new CircularProgressIndicator(),
              errorWidget: (context, url, error) =>
                  Center(child: Icon(Icons.error)),
            ),
          ),
        ),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              cartItem.title,
              style: TextStyle(color: Colors.black, fontSize: 16),
              maxLines: 2,
            ),
            SizedBox(height: 10),
            // Row(
            //   children: [
            Text.rich(
              TextSpan(
                text: "\$${cartItem.price}",
                style: TextStyle(
                    fontWeight: FontWeight.w600, color: Colors.redAccent),
                children: [
                  TextSpan(
                      text: " x${cartItem.quantity}",
                      style: Theme.of(context).textTheme.bodyText1),
                ],
              ),
            ),
            //   ],
            // )
          ],
        ),
        Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                Provider.of<Cart>(context, listen: false)
                    .addItemFromCart(cartItem);
              },
              child: Icon(Icons.add_circle_outlined,
                  color: Colors.black.withOpacity(1)),
            ),
            // Consumer<Cart>(builder: (ctx, cart, _) {
            //   return InkWell(
            //     onTap: () async {
            //       Scaffold.of(context).hideCurrentSnackBar();
            //       Scaffold.of(context).showSnackBar(
            //         SnackBar(
            //           content: Text(
            //             'Produto adicionado com sucesso!',
            //           ),
            //           duration: Duration(seconds: 2),
            //           action: SnackBarAction(
            //             label: 'DESFAZER',
            //             onPressed: () {
            //               cart.removeSingleItem(cartItem.id);
            //             },
            //           ),
            //         ),
            //       );
            //       cart.addItem(cartItem);
            //     },
            //     child: Container(
            //       padding: EdgeInsets.fromLTRB(7, 7, 7, 7),
            //       // height: 26,
            //       // width: 26,
            //       decoration: BoxDecoration(
            //         color: Colors.black.withOpacity(0.8),
            //         shape: BoxShape.circle,
            //       ),
            //       child: SvgPicture.asset(
            //         'assets/miscellaneous/svg/081-shopping-bags.svg',
            //         color: Colors.white,
            //       ),
            //     ),
            //   );
            // }),
            SizedBox(height: 12),
            InkWell(
              onTap: () {
                Provider.of<Cart>(context, listen: false)
                    .removeSingleItem(cartItem.productId);
              },
              child: Icon(Icons.remove_circle_outlined,
                  color: cartItem.quantity != 1
                      ? Colors.black.withOpacity(1)
                      : Colors.redAccent.withOpacity(1)),
            ),
          ],
        ),
      ],
    );
  }
}
