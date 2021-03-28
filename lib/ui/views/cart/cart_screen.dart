import 'package:flutter/material.dart';
// import 'package:shop_app/models/Cart.dart';

import 'components/body.dart';
import 'components/check_out_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import 'package:shop_app/widgets/cart_item_widget.dart';
import 'package:shop/app/providers/cart.dart';
import 'package:shop/app/providers/orders.dart';
import 'package:shop/app/utils/my_flutter_app_icons.dart';

class CartScreen extends StatelessWidget {
  static String routeName = "/cart";
  @override
  Widget build(BuildContext context) {
    final Cart cart = Provider.of(context);
    final cartItems = cart.items.values.toList();
    return Scaffold(
      appBar: buildAppBar(context, cartItems),
      body: Body(cartItems),
      bottomNavigationBar: CheckoutCard(cart: cart),
    );
  }

  AppBar buildAppBar(BuildContext context, cartItems) {
    return AppBar(
      title: Column(
        children: [
          Row(
            children: [
              Text(
                "Carrinho / ZARA",
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(width: 2),
              Text(
                "${cartItems.length} items",
                style: Theme.of(context).textTheme.caption,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
