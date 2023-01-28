import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:task/provider/product_provider.dart';
import 'package:task/service/url_constants.dart';

import '../utils/cart_widget.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);
  static const String routeName = "/Product-Screen";

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    final args = getArgument(context);
    final productSelected = args['productSelect'];
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new_outlined),
            color: Colors.grey,
          ),
          actions: [
            CartWidget(),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Hero(
                  tag: 'productImage${productSelected.id}',
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    height: MediaQuery.of(context).size.height / 2,
                    width: MediaQuery.of(context).size.height / 2,
                    child: Card(
                      elevation: 5,
                      child: Image.network(productSelected.image),
                    ),
                  ),
                ),
                const Divider(
                  thickness: 2.5,
                ),
                Text(
                  productSelected.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 30,
                  ),
                ),
                const Divider(
                  thickness: 2.5,
                ),
                Text(
                  productSelected.description,
                  // textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                const Divider(
                  thickness: 2.5,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    "₹ ${productSelected.price.toString()}",
                    textAlign: TextAlign.end,
                    style: const TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width / 7,
                  child: ElevatedButton(
                    onPressed: () {
                      Provider.of<ProductProvider>(context, listen: false)
                          .addcartItemsCount();
                      Provider.of<ProductProvider>(context, listen: false)
                          .addCartItems(productSelected);
                      Provider.of<ProductProvider>(context, listen: false)
                          .setTotalPrice(productSelected.price.toDouble());
                    },
                    child: const Text(
                      "Add to cart",
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
