import 'package:flutter/material.dart';

import '../theme/app_pallete.dart';

class SpotifyCustomFields extends StatefulWidget {
  final bool isPassword;
  final TextEditingController? controller;

  const SpotifyCustomFields.SpotifyCustomFields({
    super.key,
    required this.controller,
    this.isPassword = false,
  });

  @override
  State<SpotifyCustomFields> createState() => _SpotifyCustomFieldsState();
}

class _SpotifyCustomFieldsState extends State<SpotifyCustomFields> {
  bool _visiblePassword = true;

  void togglePasswordVisiblity() {
    _visiblePassword = !_visiblePassword;
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: Pallete.whiteColor),
      obscureText: widget.isPassword ? _visiblePassword : false,
      cursorColor: Pallete.whiteColor,
      keyboardType: TextInputType.text,
      controller: widget.controller,
      decoration: InputDecoration(
          suffixIcon: widget.isPassword
              ? IconButton(
                  onPressed: togglePasswordVisiblity,
                  icon: Icon(_visiblePassword
                      ? Icons.visibility
                      : Icons.visibility_off,
                    color: Pallete.whiteColor,
                  ))
              : null,
          contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
          fillColor: Pallete.spotifySecondGrey,
          filled: true,
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 0)),
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 0)),
        errorStyle: TextStyle(color: Pallete.whiteColor),

      ),
        validator: (val) {
          if (val!.trim().isEmpty) {
            return "can't be empty";
          }
          return null;
        },
    );
  }

}
