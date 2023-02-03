import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/provider/auth_provider.dart';
import 'package:task/provider/product_provider.dart';
import 'package:task/routes/routes.dart';
import 'package:task/screens/app_drawer.dart';
import 'package:task/screens/home_screen.dart';
import 'package:task/screens/login_screen.dart';
import 'package:task/utils/theme.dart';

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
        themeMode: ThemeMode.system,
        theme: MyThemes.darkTheme,
        darkTheme: MyThemes.darkTheme,
        home: token.isEmpty ? LoginScreen() : const AppDrawer(),
        // home: const AppDrawer(),
        onGenerateRoute: AppRoutes.onGenerateRoute,
      ),
    );
  }
}
