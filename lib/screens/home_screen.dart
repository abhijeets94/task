import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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

  List filterChipsOptions = [];
  List<bool> _selected = [false, false];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProductsCategoryList();
  }

  getProductsCategoryList() async {
    await Provider.of<ProductProvider>(context, listen: false)
        .getProductCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            ),
          ),
          actions: const [
            Icon(
              Icons.search_outlined,
              color: Colors.grey,
            ),
            SizedBox(
              width: 5,
            ),
            Icon(
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
            Container(
              height: MediaQuery.of(context).size.height / 1.2,
              color: Colors.red,
            )
            //producs grid
          ],
        ));
  }

  Expanded productFilerChips(BuildContext context) {
    return Expanded(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
            padding: EdgeInsets.all(12),
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount:
                Provider.of<ProductProvider>(context).listProducts.length,
            itemBuilder: (context, index) {
              return FilterChip(
                  selected: Provider.of<ProductProvider>(context)
                      .productSelected[index],
                  label: Text(
                      "${Provider.of<ProductProvider>(context).listProducts[index]}"),
                  elevation: 10,
                  pressElevation: 5,
                  backgroundColor: Colors.grey[50],
                  selectedColor: Colors.blue,
                  onSelected: (bool selected) {
                    setState(() {
                      Provider.of<ProductProvider>(context, listen: false)
                          .productSelected[index] = selected;
                    });
                  });
            }),
      ),
    );
  }
}
