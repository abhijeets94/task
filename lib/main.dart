import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/provider/auth_provider.dart';
import 'package:task/provider/product_provider.dart';
import 'package:task/routes/routes.dart';
import 'package:task/screens/home_screen.dart';
import 'package:task/screens/login_screen.dart';

void main() {
  runApp(ProductApp());
}

class ProductApp extends StatefulWidget {
  const ProductApp({Key? key}) : super(key: key);

  @override
  State<ProductApp> createState() => _ProductAppState();
}

class _ProductAppState extends State<ProductApp> {
  String token = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getToken();
  }

  getToken() async {
    final prefereces = await SharedPreferences.getInstance();
    token = prefereces.getString('token') ?? '';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: token.isEmpty ? LoginScreen() : HomeScreen(),
        onGenerateRoute: AppRoutes.onGenerateRoute,
      ),
    );
  }
}
