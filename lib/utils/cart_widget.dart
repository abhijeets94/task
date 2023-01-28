import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/screens/cart_screen.dart';

import '../provider/product_provider.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, CartScreen.routeName),
      child: Stack(
        children: [
          Positioned(
            top: 5,
            child: Container(
              height: 15,
              width: 15,
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(50)),
              child: Consumer<ProductProvider>(builder: (context, provider, _) {
                return Center(
                    child: Text(
                  provider.cartItemsCount.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ));
              }),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.shopping_cart_outlined,
              color: Colors.grey,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}
