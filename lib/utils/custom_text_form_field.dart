import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    required this.controller,
    required this.keyboardType,
    required this.passwordField,
    required this.hintText,
    this.validator,
    this.onchanged,
  }) : super(key: key);

  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool passwordField;
  final String? Function(String?)? validator;
  final Function(String)? onchanged;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: passwordField,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Colors.grey,
          ),
        ),
      ),
      onChanged: onchanged,
    );
  }
}
