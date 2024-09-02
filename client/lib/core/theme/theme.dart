import 'package:client/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static OutlineInputBorder _border (Color col )=> OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(color: col, width: 3));
  static final darkThemeMode = ThemeData.dark().copyWith(
      scaffoldBackgroundColor: Pallete.backgroundColor,
      inputDecorationTheme: InputDecorationTheme(
          contentPadding: EdgeInsets.all(27),
          enabledBorder: _border(Pallete.borderColor),
          focusedBorder: _border(Pallete.gradient2)
      ),
    bottomNavigationBarTheme: const  BottomNavigationBarThemeData(
      backgroundColor: Pallete.transparentColor,
    ),

  );

}
