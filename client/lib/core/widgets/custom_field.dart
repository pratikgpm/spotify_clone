import 'package:flutter/material.dart';

class CustomFiels extends StatelessWidget {
  final String hintText;
  final bool isPassword;
  final bool readOnly;
  final VoidCallback? onTap;
  final TextEditingController? controller;

  const CustomFiels(
      {super.key,
      required this.hintText,
      required this.controller,
      this.isPassword = false,
      this.readOnly = false,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      controller: controller,
      obscureText: isPassword,
      onTap: onTap,
      validator: (val) {
        if (val!.trim().isEmpty) {
          return "$hintText is missing!";
        }
        return null;
      },
      decoration: InputDecoration(hintText: hintText),
    );
  }
}
