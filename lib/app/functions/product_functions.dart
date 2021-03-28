import 'package:intl/intl.dart';

class ProductFunctions {
  String doubleValueToCurrency(double doubleValue) {
    if (doubleValue > 999.99) {
      return NumberFormat.compact().format(doubleValue);
    } else {
      return NumberFormat.simpleCurrency(locale: 'pt').format(doubleValue);
      // NumberFormat.currency(
      //         customPattern: '###,###.##', locale: 'pt_BR')//BRL nl_NL en_US
      //     .format(doubleValue);
    }
  }
}
