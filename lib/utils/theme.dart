import 'package:flutter/material.dart';

class MyThemes {
  static final darkTheme = ThemeData(
      scaffoldBackgroundColor: Colors.black,
      appBarTheme: const AppBarTheme(
        color: Colors.black,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      colorScheme: const ColorScheme.dark(
        primary: Colors.white,
        onPrimary: Colors.white,
        secondary: Colors.red,
      ),
      chipTheme: ChipThemeData.fromDefaults(
          primaryColor: Colors.black,
          secondaryColor: Colors.white,
          labelStyle: const TextStyle(color: Colors.white)),
      cardTheme: const CardTheme(
        color: Colors.black,
      ),
      iconTheme: const IconThemeData(
        color: Colors.white54,
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: Colors.deepPurple, //  <-- dark color
        textTheme:
            ButtonTextTheme.primary, //  <-- this auto selects the right color
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          side: MaterialStateProperty.resolveWith<BorderSide>(
              (states) => const BorderSide(color: Colors.red)),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (states) => Colors.redAccent[700]!),
          shape: MaterialStateProperty.resolveWith<OutlinedBorder>((_) {
            return RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20));
          }),
          textStyle: MaterialStateProperty.resolveWith<TextStyle>(
              (states) => TextStyle(color: Colors.redAccent[700]!)),
        ),
      ));
}
