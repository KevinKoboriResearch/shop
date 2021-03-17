import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/product_grid_item.dart';
import '../providers/products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/auth.dart';
import '../providers/product.dart';
import '../providers/cart.dart';
import '../utils/app_routes.dart';

class ProductGrid extends StatelessWidget {
  final bool showFavoriteOnly;

  ProductGrid(this.showFavoriteOnly);

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<Products>(context);
    final products = showFavoriteOnly
        ? productsProvider.favoriteItems
        : productsProvider.items;
    // final Cart cart = Provider.of(context, listen: false);
    // final Auth auth = Provider.of(context, listen: false);
    // return GridView.builder(
    //   padding: const EdgeInsets.all(10),
    //   itemCount: products.length,
    //   itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
    //     value: products[i],
    //     child: ProductGridItem(),
    //   ),
    //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //     crossAxisCount: 2,
    //     childAspectRatio: 3 / 2,
    //     crossAxisSpacing: 10,
    //     mainAxisSpacing: 10,
    //   ),
    // );
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 300,
        childAspectRatio: 1,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return ChangeNotifierProvider.value(
            value: products[index],
            // child: GestureDetector(
            //   onTap: () {},
            //   child: Stack(
            //     children: [
            //       Container(
            //         padding: EdgeInsets.all(2.0),
            //         width:
            //             296, //width: MediaQuery.maybeOf(context)!.size.width * 0.5,
            //         height: 296,
            //         child: FadeInImage(
            //           placeholder:
            //               AssetImage('assets/images/product-placeholder.png'),
            //           image: NetworkImage(products[index].imageUrl),
            //           fit: BoxFit.cover,
            //         ),
            //         // child: FadeInImage(
            //         //   placeholder: AssetImage('assets/images/dichavadores.png'),
            //         //   image: AssetImage('assets/images/dichavadores.png'),
            //         //   fit: BoxFit.cover,
            //         // ),
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.all(4.0),
            //         child: Container(
            //           decoration: BoxDecoration(
            //             gradient: LinearGradient(
            //               begin: Alignment.topCenter,
            //               end: Alignment.bottomCenter,
            //               colors: [
            //                 Colors.transparent,
            //                 Colors.transparent,
            //                 Colors.black.withOpacity(0.6),
            //               ],
            //             ),
            //           ),
            //         ),
            //       ),
            //       Padding(
            //         padding: EdgeInsets.all(12.0),
            //         child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: <Widget>[
            //             Align(
            //               alignment: Alignment.topRight,
            //               child: Chip(
            //                 label: Text(
            //                   products[index].price.toString() + ',00',
            //                   style: TextStyle(
            //                     color: Theme.of(context)
            //                         .primaryTextTheme
            //                         .title
            //                         .color,
            //                   ),
            //                 ),
            //                 backgroundColor: Theme.of(context).primaryColor,//.withOpacity(0.1),
            //               ),
            //             ),
            //             Spacer(),
            //             SizedBox(height: 6),
            //             Text(
            //               products[index]
            //                   .title, // 'Dichavadores Mini de Metal 3 partes',
            //               maxLines: 2,
            //               overflow: TextOverflow.ellipsis,
            //               style: TextStyle(
            //                 color: Colors.white,
            //                 fontWeight: FontWeight.bold,
            //                 fontSize: 16,
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            child: ProductGridItem(),
            // child: Padding(
            //   padding: EdgeInsets.all(2.0),
            //   child: GridTile(
            //     child: GestureDetector(
            //       onTap: () {
            //         Navigator.of(context).pushNamed(
            //           AppRoutes.PRODUCT_DETAIL,
            //           arguments: products[index],
            //         );
            //       },
            //       child: Hero(
            //         tag: products[index].id,
            //         child: FadeInImage(
            //           placeholder:
            //               AssetImage('assets/images/product-placeholder.png'),
            //           image: NetworkImage(products[index].imageUrl),
            //           fit: BoxFit.cover,
            //         ),
            //       ),
            //     ),
            //     footer: GridTileBar(
            //       backgroundColor: Colors.black87,
            //       leading: Consumer<Product>(
            //         builder: (ctx, product, _) => IconButton(
            //           icon: Icon(products[index].isFavorite
            //               ? Icons.favorite
            //               : Icons.favorite_border),
            //           color: Theme.of(context).accentColor,
            //           onPressed: () {
            //             products[index].toggleFavorite(auth.token, auth.userId);
            //           },
            //         ),
            //       ),
            //       title: Text(
            //         products[index].title,
            //         textAlign: TextAlign.center,
            //         maxLines: 2,
            //         overflow: TextOverflow.ellipsis,
            //       ),
            //       trailing: IconButton(
            //         icon: Icon(Icons.shopping_cart),
            //         color: Theme.of(context).accentColor,
            //         onPressed: () {
            //           Scaffold.of(context).hideCurrentSnackBar();
            //           Scaffold.of(context).showSnackBar(
            //             SnackBar(
            //               content: Text(
            //                 'Produto adicionado com sucesso!',
            //               ),
            //               duration: Duration(seconds: 2),
            //               action: SnackBarAction(
            //                 label: 'DESFAZER',
            //                 onPressed: () {
            //                   cart.removeSingleItem(products[index].id);
            //                 },
            //               ),
            //             ),
            //           );
            //           cart.addItem(products[index]);
            //         },
            //       ),
            //     ),
            //   ),
            // ),
          );
        },
        childCount: products.length, // widget.devicesSnapshot.data.docs.length,
      ),
    );
  }
}
