import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop/ui/components/default_button.dart';

import '../../../../constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop/ui/widgets/cart_item_widget.dart';
import 'package:shop/app/providers/cart.dart';
import 'package:shop/app/providers/orders.dart';
import 'package:shop/app/utils/my_flutter_app_icons.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:ui';
import 'package:shop/app/functions/product_functions.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:shop/app/providers/product.dart';
import 'package:shop/app/providers/cart.dart';
import 'package:flutter_svg/flutter_svg.dart';
// class CheckoutCard extends StatelessWidget {
class CheckoutCard extends StatefulWidget {
  final dynamic cart;
  const CheckoutCard({
    Key key,
    @required this.cart,
  }) : super(key: key);

  @override
  _CheckoutCardState createState() => _CheckoutCardState();
}

class _CheckoutCardState extends State<CheckoutCard> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 30,
      ),
      // height: 174,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.3),
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey[200], //Color(0xFFF5F6F9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SvgPicture.asset("assets/icons/Location point.svg",
                      color: Colors.redAccent),
                ),
                Spacer(),
                Text("Add seu endereço"),
                const SizedBox(width: 10),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: kTextColor,
                )
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(
                    text: "Total:\n",
                    children: [
                      TextSpan(
                        text: ProductFunctions()
                                            .doubleValueToCurrency(
                                                widget.cart.totalAmount),//${widget.cart.totalAmount}',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 190,
                  child: DefaultButton(
                    child: _isLoading
                        ? CircularProgressIndicator()
                        : Text(
                            "Encomendar",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                    press: widget.cart.totalAmount == 0
                        ? null
                        : () async {
                            setState(() {
                              _isLoading = true;
                            });

                            await Provider.of<Orders>(context, listen: false)
                                .addOrder(widget.cart);

                            setState(() {
                              _isLoading = false;
                            });

                            widget.cart.clear();
                          },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
