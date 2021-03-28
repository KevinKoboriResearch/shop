import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:shop/models/Cart.dart';
import 'package:shop/app/providers/cart.dart';
import 'cart_card.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import 'package:shop/widgets/cart_item_widget.dart';
import 'package:shop/app/providers/cart.dart';
import 'package:shop/app/providers/orders.dart';
import 'package:shop/app/utils/my_flutter_app_icons.dart';
class Body extends StatefulWidget {
  final cartItems;
  Body(this.cartItems);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: 20),
      child: ListView.builder(
        itemCount:  widget.cartItems.length,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Dismissible(
            key: Key( widget.cartItems[index].id.toString()),//product.id.toString()),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              setState(() {
                //  widget.cartItems.removeAt(index);
                 Provider.of<Cart>(context, listen: false)
            .removeItem(widget.cartItems[index].productId);
              });
            },
            background: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Color(0xFFFFE6E6),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Spacer(),
                  SvgPicture.asset("assets/icons/Trash.svg"),
                ],
              ),
            ),
            child: CartCard(cartItem:  widget.cartItems[index], index: index),
          ),
        ),
      ),
    );
  }
}
