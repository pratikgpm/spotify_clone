import 'package:flutter/material.dart';
import 'package:client/core/theme/app_pallete.dart';

class AuthSpotifyButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onTap;
  final bool isEnable ;
  const AuthSpotifyButton({super.key,required this.buttonText,required this.onTap,this.isEnable= true});

  @override
  Widget build(BuildContext context) {
    return  ElevatedButton(
        onPressed: isEnable ? onTap : null,
     style:  ButtonStyle(
          backgroundColor:
          MaterialStatePropertyAll<Color>(
              isEnable ?
              Pallete.whiteColor:
          Pallete.spotifySecondGrey,
          ),
          padding: MaterialStatePropertyAll(
              EdgeInsets.symmetric(
                  horizontal: 36, vertical: 15)
          )

      ),
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600,color: Pallete.backgroundColor,),
        ),
    );
  }
}
