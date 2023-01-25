import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:task/model/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:task/service/url_constants.dart';

class ProductProvider extends ChangeNotifier {
  List listProducts = [];
  List<bool> selected = [];
  List get productList => listProducts;
  List get productSelected => selected;

  Future getProductCategory() async {
    http.Response response =
        await http.get(Uri.parse('$apiProducts/categories'));
    listProducts = jsonDecode(response.body);

    for (int i = 0; i < listProducts.length; i++) {
      selected.add(false);
    }
    notifyListeners();
  }
}
