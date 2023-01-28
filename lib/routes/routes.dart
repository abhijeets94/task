import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task/screens/cart_screen.dart';
import 'package:task/screens/home_screen.dart';
import 'package:task/screens/login_screen.dart';
import 'package:task/screens/product_screen.dart';

class AppRoutes {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomeScreen.routeName:
        {
          return MaterialPageRoute(
            builder: (_) => HomeScreen(),
            settings: settings,
          );
        }
      case ProductScreen.routeName:
        {
          return MaterialPageRoute(
            builder: (_) => const ProductScreen(),
            settings: settings,
          );
        }
      case CartScreen.routeName:
        {
          return MaterialPageRoute(
            builder: (_) => const CartScreen(),
            settings: settings,
          );
        }
      default:
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
          settings: settings,
        );
    }
  }
}
