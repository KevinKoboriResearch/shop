import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../size_config.dart';

class CategoriesPopular extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categoriesPopular = [
      {"icon": "assets/icons/Flash Icon.svg", "text": "Flash Deal"},
      {"icon": "assets/icons/Bill Icon.svg", "text": "Bill"},
      {"icon": "assets/icons/Game Icon.svg", "text": "Game"},
      {"icon": "assets/icons/Gift Icon.svg", "text": "Daily Gift"},
      {"icon": "assets/icons/Discover.svg", "text": "More"},
    ];
    return 
    
    
    SliverToBoxAdapter(
      child: Container(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(categoriesPopular.length,
                // categories.length,
                (index) {
              return GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: EdgeInsets.fromLTRB(index == 0.0 ? 14.0 : 8.0, 0.0,
                      index == categoriesPopular.length - 1 ? 14.0 : 0.0, 0.0),
                  child: Container(
              padding: EdgeInsets.fromLTRB(getProportionateScreenWidth(12),getProportionateScreenWidth(6),getProportionateScreenWidth(12),getProportionateScreenWidth(6)),
              // height: getProportionateScreenWidth(55),
              // width: getProportionateScreenWidth(55),
              decoration: BoxDecoration(
                color: Colors.deepOrange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                      categoriesPopular[index]['text'],
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
            ),
            
                ),
              );
            }),
          ),
        ),
      ),
    );

    
  }
}
