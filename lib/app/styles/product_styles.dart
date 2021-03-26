import 'package:flutter/material.dart';
import 'package:shop/app/utils/constants.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'dart:ui';

class ProductStyles {
  InputDecoration inputTextDecoration(String labelText, String hintText) {
    return InputDecoration(
      // border: InputBorder.none,
      // focusedBorder: InputBorder.none,
      // enabledBorder: InputBorder.none,
      // errorBorder: InputBorder.none,
      // disabledBorder: InputBorder.none,
      suffixIcon: Icon(Icons.search, color: AppColors.astratosDarkGreyColor),
      labelText: labelText,
      labelStyle: TextStyle(
        fontWeight: FontWeight.bold,
        color: AppColors.astratosDarkGreyColor,
      ),
      hintText: hintText,
      hintStyle: TextStyle(
        color: Colors.grey,
      ),
      // border: InputBorder.none,
    );
  }

  TextStyle inputTextStyle() {
    return TextStyle(
      letterSpacing: 2,
      color: AppColors.accentColor,
    );
  }

  InputDecoration _buildDecoration(String label) {
    return InputDecoration(
        labelText: label, labelStyle: TextStyle(color: Colors.green));
  }

  final _fieldStyle = TextStyle(
    // color: Colors.white, fontSize: 16
    letterSpacing: 2,
    color: AppColors.accentColor,
  );
}
