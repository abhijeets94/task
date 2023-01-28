import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/model/auth_user_model.dart';
import 'package:task/provider/auth_provider.dart';
import 'package:task/screens/home_screen.dart';
import '../utils/custom_text_form_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  static const String routeName = '/Login-Screen';

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: _loginFormKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    CustomTextFormField(
                      controller: nameController,
                      keyboardType: TextInputType.emailAddress,
                      passwordField: false,
                      hintText: "Username",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextFormField(
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      passwordField: true,
                      hintText: "Password",
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                bool validated = _loginFormKey.currentState!.validate();
                final prefs = await SharedPreferences.getInstance();
                if (validated) {
                  Provider.of<AuthProvider>(context, listen: false)
                      .userLogin(nameController.text, passwordController.text)
                      .then((value) {
                    String token =
                        AuthUserModel.fromMap(jsonDecode(value.toJson())).token;
                    prefs.setString('token', token);
                    Navigator.popAndPushNamed(context, HomeScreen.routeName);
                  });
                }
              },
              child: Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
