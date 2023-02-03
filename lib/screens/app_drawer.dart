import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';

import 'package:task/screens/home_screen.dart';
import 'package:task/screens/login_screen.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);
  static const String routeName = "/App-Drawer";

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  double value = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomRight,
                transform: const GradientRotation(pi / 4),
                colors: [
                  Colors.grey[900]!,
                  Colors.black38,
                ],
              ),
            ),
            child: ListView(
              children: [
                ListTile(
                  onTap: () {},
                  leading: const Icon(Icons.home),
                  title: const Text('home'),
                ),
                ListTile(
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setString('token', '');

                    Navigator.of(context).popUntil((route) => false);
                    Navigator.pushNamed(context, LoginScreen.routeName);
                  },
                  leading: const Icon(Icons.logout_outlined),
                  title: const Text('Logout'),
                ),
              ],
            ),
          ),
          TweenAnimationBuilder(
            curve: Curves.easeIn,
            tween: Tween<double>(begin: 0, end: value),
            duration: const Duration(milliseconds: 200),
            builder: (_, double val, __) {
              return (Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.002)
                    ..setEntry(0, 3, 200 * val.toDouble())
                    ..rotateY((pi / 6) * val),
                  child: HomeScreen()));
            },
          ),
          GestureDetector(
            onHorizontalDragUpdate: (e) {
              if (e.delta.dx > 0) {
                setState(() {
                  value = 1;
                });
              } else {
                setState(() {
                  value = 0;
                });
              }
            },
          )
        ],
      ),
    );
  }
}
