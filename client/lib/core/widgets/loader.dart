import 'package:client/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator.adaptive(backgroundColor: Pallete.transparentColor,
      valueColor:  AlwaysStoppedAnimation<Color>(Color(0xff1DB954)),));
  }
}
