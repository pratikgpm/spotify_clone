import 'package:flutter/material.dart';
import 'package:client/core/theme/app_pallete.dart';

class AuthGradientButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onTap;
  const AuthGradientButton({super.key,required this.buttonText,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
          gradient: LinearGradient(colors: [
        Pallete.gradient1,
        Pallete.gradient2,
      ],
          begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          )),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
            fixedSize: const Size(395, 55),
            backgroundColor: Pallete.transparentColor,
            shadowColor: Pallete.transparentColor),
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600,color: Colors.white),
        ),
      ),
    );
  }
}