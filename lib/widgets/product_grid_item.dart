import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/auth.dart';
import 'package:shop/utils/my_flutter_app_icons.dart';
import '../providers/product.dart';
import '../providers/cart.dart';
import '../utils/app_routes.dart';

class ProductGridItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Product product = Provider.of(context, listen: false);
    final Cart cart = Provider.of(context, listen: false);
    final Auth auth = Provider.of(context, listen: false);

    return Padding(
      padding: EdgeInsets.all(2.0),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              AppRoutes.PRODUCT_DETAIL,
              arguments: product,
            );
          },
          child: Stack(
            children: [
              Container(
                width: 296,
                height: 296,
                child: Hero(
                  tag: product.id,
                  child: FadeInImage(
                    placeholder: AssetImage('assets/logo/logo.png'),
                    image: NetworkImage(product.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Consumer<Product>(
                builder: (ctx, product, _) => Padding(
                  padding: EdgeInsets.all(product.isFavorite ? 0.0 : 2.0),
                  child: IconButton(
                    splashColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    icon: Icon(
                      product.isFavorite
                          ? MyFlutterApp.heart_1
                          : MyFlutterApp.heart_2,
                      size: product.isFavorite ? 16 : 12,
                    ),
                    iconSize: product.isFavorite ? 28 : 22,
                    color: Theme.of(context).accentColor,
                    onPressed: () {
                      product.toggleFavorite(auth.token, auth.userId);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.white.withOpacity(0.96),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.title,
                textAlign: TextAlign.left,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                ),
              ),
              Row(
                children: [
                  Text(
                    product.price.toString() + ',00 ',
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.red,
                    ),
                  ),
                  Text(
                    product.quantity,
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ],
          ),
          trailing: Row(
            children: [
              IconButton(
                icon: Icon(
                  MyFlutterApp.bag,
                  size: 16,
                ),
                color: Colors.blue,
                onPressed: () {
                  Scaffold.of(context).hideCurrentSnackBar();
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Produto adicionado com sucesso!',
                      ),
                      duration: Duration(seconds: 2),
                      action: SnackBarAction(
                        label: 'DESFAZER',
                        onPressed: () {
                          cart.removeSingleItem(product.id);
                        },
                      ),
                    ),
                  );
                  cart.addItem(product);
                },
              ),
              // Consumer<Product>(
              //   builder: (ctx, product, _) => Padding(
              //     padding: EdgeInsets.symmetric(
              //         horizontal: product.isFavorite ? 0.0 : 2.0),
              //     child: IconButton(
              //       icon: Icon(
              //         product.isFavorite
              //             ? MyFlutterApp.heart_1
              //             : MyFlutterApp.heart_2,
              //         size: 16,
              //       ),
              //       iconSize: product.isFavorite ? 28 : 22,
              //       color: Theme.of(context).accentColor,
              //       onPressed: () {
              //         product.toggleFavorite(auth.token, auth.userId);
              //       },
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
