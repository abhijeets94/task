import 'package:flutter/material.dart';

final apiLogin = "https://fakestoreapi.com/auth/login";
final apiProducts = "https://fakestoreapi.com/products";

getArgument(BuildContext context) {
  return (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{})
      as Map;
}
