import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/model/product_model.dart';
import 'package:task/service/url_constants.dart';
import 'package:task/utils/custom_text_form_field.dart';

import '../provider/product_provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);
  static const String routeName = "/Homescreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchTextController = TextEditingController();

  // List filterChipsOptions = [];
  // List<bool> _selected = [false, false];

  var productList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProductsCategoryList();
    getProductsList();
  }

  getProductsList() async {
    await Provider.of<ProductProvider>(context, listen: false).getProducts();
  }

  getProductsCategoryList() async {
    await Provider.of<ProductProvider>(context, listen: false)
        .getProductCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomTextFormField(
                controller: searchTextController,
                keyboardType: TextInputType.text,
                passwordField: false,
                hintText: "Search here",
                onchanged: (search) {
                  Provider.of<ProductProvider>(context, listen: false)
                      .searchProduct(search);
                  setState(() {});
                }),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Provider.of<ProductProvider>(context, listen: false)
                    .searchProduct(searchTextController.text);
                setState(() {});
              },
              icon: const Icon(Icons.search_outlined),
              color: Colors.grey,
            ),
            const SizedBox(
              width: 5,
            ),
            const Icon(
              Icons.shopping_cart_outlined,
              color: Colors.grey,
            ),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //filterchips
            Divider(),
            productFilerChips(context),
            Provider.of<ProductProvider>(context).listProducts.length <= 0
                ? SizedBox(
                    height: MediaQuery.of(context).size.height / 1.2,
                    child: Center(child: const CircularProgressIndicator()),
                  )
                : listAllProducts(context),
            //producs grid
          ],
        ));
  }

  SizedBox listAllProducts(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.2,
      child: GridView.builder(
          itemCount: Provider.of<ProductProvider>(context).listProducts.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.4,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 5.0,
          ),
          itemBuilder: ((context, index) {
            var product =
                Provider.of<ProductProvider>(context).listProducts[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SizedBox(
                height: 120,
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 7,
                      child: Card(
                        elevation: 5,
                        child: Image.network(
                          product.image,
                          fit: BoxFit.fill,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Text("${product.title}", overflow: TextOverflow.ellipsis)
                  ],
                ),
              ),
            );
          })),
    );
  }

  Expanded productFilerChips(BuildContext context) {
    return Expanded(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
            padding: EdgeInsets.all(12),
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: Provider.of<ProductProvider>(context)
                .listProductsCategory
                .length,
            itemBuilder: (context, index) {
              List products =
                  Provider.of<ProductProvider>(context).listProductsCategory;
              return FilterChip(
                  selected: Provider.of<ProductProvider>(context)
                      .productSelected[index],
                  label: Text(
                      "${Provider.of<ProductProvider>(context).listProductsCategory[index]}"),
                  elevation: 10,
                  pressElevation: 5,
                  backgroundColor: Colors.grey[50],
                  selectedColor: Colors.blue,
                  onSelected: (bool selected) async {
                    if (!(Provider.of<ProductProvider>(context, listen: false)
                        .productSelected[index])) {
                      await Provider.of<ProductProvider>(context, listen: false)
                          .getProductCategoryWise(products[index]);
                      setState(() {
                        //Unselecting all to restrict selection to only one
                        for (int i = 0;
                            i <
                                Provider.of<ProductProvider>(context,
                                        listen: false)
                                    .productSelected
                                    .length;
                            i++) {
                          Provider.of<ProductProvider>(context, listen: false)
                              .productSelected[i] = false;
                        }
                        Provider.of<ProductProvider>(context, listen: false)
                            .productSelected[index] = true;
                      });
                    }
                  });
            }),
      ),
    );
  }
}
