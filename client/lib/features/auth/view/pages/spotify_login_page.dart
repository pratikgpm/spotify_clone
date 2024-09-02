import 'package:client/core/theme/app_pallete.dart';
import 'package:client/features/auth/view/pages/login_page.dart';
import 'package:client/features/auth/view/pages/signup_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/utils.dart';
import 'creat_account_email.dart';

class spotifyLogin extends StatelessWidget {
  const spotifyLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [
            0.01,
            0.56
          ],
              colors: [
            const Color(0xff535353),
            const Color(0xff121212).withOpacity(0.1),
          ])),
      child: Scaffold(
        backgroundColor: Pallete.transparentColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 80,
            ),
            const Center(
                child: FaIcon(
              FontAwesomeIcons.spotify,
              size: 70,
            )),
            const SizedBox(
              height: 100,
            ),
            const Text(
              "Millions of songs.\nFree on Spotify.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  height: 1.1,
                  fontSize: 35,
                  fontWeight: FontWeight.w900,
                  color: Pallete.whiteColor),
            ),
            const SizedBox(
              height: 80,
            ),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>  CreatAccountEmail(),));
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12),
                width: double.maxFinite,
                margin: EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Pallete.spotifyGreen,
                ),
                child: const Text(
                  "Sing up for free",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Pallete.backgroundColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            iconContainer(
                "Continue with phone number", 'assets/images/whitePhone.svg'),
            const SizedBox(
              height: 10,
            ),
            iconContainer("Continue with google", 'assets/images/google.svg'),
            const SizedBox(
              height: 10,
            ),
            iconContainer(
                "Continue with Facebook", 'assets/images/facebook.svg'),
            const SizedBox(
              height: 15,
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder:(context) => const LoginPage(),));
                },
                child: const Text(
                  "Log in",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Pallete.whiteColor,
                      fontSize: 16),
                ))
          ],
        ),
      ),
    );
  }
}
