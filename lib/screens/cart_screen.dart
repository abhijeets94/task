import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:task/provider/product_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);
  static const String routeName = "/Cart-Screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          color: Colors.grey,
          icon: Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          const BottomNavigationBarItem(
            icon: Text("Total Price:"),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Text(
              "₹ ${Provider.of<ProductProvider>(context).totalPrice.toStringAsFixed(2)} ",
              style: const TextStyle(
                fontSize: 30,
              ),
            ),
            label: "",
          ),
        ],
      ),
      body: Column(
        children: [
          const Text(
            "CART",
            style: TextStyle(
                color: Colors.black, fontSize: 80, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                    ),
                shrinkWrap: true,
                itemCount: Provider.of<ProductProvider>(context).cartItemsCount,
                itemBuilder: (context, index) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 6,
                    child: Consumer<ProductProvider>(
                        builder: (context, provider, _) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          //image
                          Container(
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.black, width: 1),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Image.network(
                                  provider.cartItems[index].image)),
                          //column
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 1.6,
                            child: Card(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //title

                                  Container(
                                    width: 150,
                                    child: Text(
                                      "${provider.cartItems[index].title}",
                                      style: TextStyle(fontSize: 20),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),

                                  Spacer(),
                                  //row
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 1.5,
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          //price
                                          Text(
                                            "₹ ${provider.cartItems[index].price}",
                                            style: TextStyle(fontSize: 20),
                                          ),

                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.black,
                                            ),
                                            onPressed: () {
                                              debugPrint("index = $index");
                                              Provider.of<ProductProvider>(
                                                      context,
                                                      listen: false)
                                                  .removeCartItems(index);
                                            },
                                            child: Text("Remove"),
                                          ),

                                          //remove from cart
                                        ]),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
