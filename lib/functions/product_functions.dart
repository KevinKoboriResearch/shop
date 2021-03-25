import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'dart:ui';
import 'dart:io';
// import 'package:shop/utils/my_flutter_app_icons_2.dart';

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
import 'package:shop/functions/flushbar.dart';
import 'package:flutter/services.dart';
import 'package:shop/functions/streams.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:shop/validators/product_validators.dart';

class ProductFunctions {
  String doubleValueToCurrency(double doubleValue) {
    if (doubleValue > 999.99) {
      return NumberFormat.compact().format(doubleValue);
    } else {
      return NumberFormat.currency(
              customPattern: '###,###.##', locale: 'nl_NL')
          .format(doubleValue);
    }
  }
}
