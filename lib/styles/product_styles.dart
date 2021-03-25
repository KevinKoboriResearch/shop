import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:shop/models/image_model.dart';
// import 'package:shop/models/product_model.dart';
// import 'package:shop/data/firestore/products_collection.dart';
import 'package:shop/utils/my_flutter_app_icons.dart';
import 'package:shop/utils/constants.dart';
// import 'package:shop/utils/via_cep_service.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:shop/exceptions/http_exception.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:ui';
import 'dart:io';
// import 'package:shop/utils/my_flutter_app_icons_2.dart';

import 'package:shop/functions/flushbar.dart';
import 'package:flutter/services.dart';
import 'package:shop/functions/streams.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:shop/validators/product_validators.dart';

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
