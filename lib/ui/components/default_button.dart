import 'package:flutter/material.dart';

import '../../constants.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key key,
    this.child,
    this.press,
  }) : super(key: key);
  final Widget child;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: Colors.redAccent,//kPrimaryColor,
        onPressed: press,
        child: child,
        // Text(
        //   text,
        //   style: TextStyle(
        //     fontSize: 18,
        //     color: Colors.white,
        //   ),
        // ),
      ),
    );
  }
}
