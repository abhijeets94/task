import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:task/model/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:task/service/url_constants.dart';

class ProductProvider extends ChangeNotifier {
  List listProductsCategory = [];
  List listProducts = [];
  List<bool> selected = [];
  int cartItemsCount = 0;
  List<ProductModel> cartItems = [];
  double totalPrice = 0;

  List get productSelected => selected;

  Future getProductCategory() async {
    http.Response response =
        await http.get(Uri.parse('$apiProducts/categories'));
    listProductsCategory = jsonDecode(response.body);

    for (int i = 0; i < listProductsCategory.length; i++) {
      selected.add(false);
    }
    notifyListeners();
  }

  Future getProductCategoryWise(String category) async {
    http.Response response =
        await http.get(Uri.parse('$apiProducts/category/$category'));
    listProducts = [];
    for (int i = 0; i < jsonDecode(response.body).length; i++) {
      listProducts.add(
        ProductModel.fromJson(
          jsonEncode(
            jsonDecode(response.body)[i],
          ),
        ),
      );
    }

    notifyListeners();
  }

  Future getProducts() async {
    http.Response response = await http.get(Uri.parse('$apiProducts/'));
    for (int i = 0; i < jsonDecode(response.body).length; i++) {
      listProducts.add(
        ProductModel.fromJson(
          jsonEncode(
            jsonDecode(response.body)[i],
          ),
        ),
      );
    }
    notifyListeners();
  }

  Future searchProduct(String query) async {
    List searchedObjects = [];

    if (query.isNotEmpty || query != "") {
      for (int i = 0; i < listProducts.length; i++) {
        searchedObjects = listProducts.where((element) {
          return (element.title.toLowerCase().contains(query.toLowerCase()));
        }).toList();
      }
      debugPrint("searched ===> $searchedObjects");

      listProducts = searchedObjects;
    } else {
      listProducts = [];
      selected = [];
      getProductCategory();
      getProducts();
    }
  }

  void addcartItemsCount() {
    cartItemsCount++;
    notifyListeners();
  }

  void addCartItems(ProductModel product) {
    cartItems.add(product);
    notifyListeners();
  }

  void removeCartItems(int index) {
    if (cartItems.length > 1) {
      totalPrice -= cartItems[index].price;
      cartItems.removeAt(index);
      cartItemsCount--;
    } else {
      cartItems = [];
      cartItemsCount = 0;
      totalPrice = 0;
    }
    notifyListeners();
  }

  void setTotalPrice(double price) {
    debugPrint("totalPrice: $totalPrice, price: $price");
    totalPrice += price;
    notifyListeners();
  }
}
