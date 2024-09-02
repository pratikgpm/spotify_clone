import 'dart:io';
import 'package:client/core/theme/app_pallete.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

void showSnackBar(BuildContext context, String content, bool status) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(
      content: Text(content.toString()),
      // backgroundColor: status ? Colors.lightGreen : Colors.red,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
    ));
}

String rgbToHex(Color color) {
  return '${color.red.toRadixString(16).padLeft(2, '0')}${color.green.toRadixString(16).padLeft(2, '0')}${color.blue.toRadixString(16).padLeft(2, '0')}';
}

Color hexToColor(String hex) {
  return Color(int.parse(hex, radix: 16) + 0xFF000000);
}

Future<File?> pickAudio() async {
  try {
    final filePickerRes =
        await FilePicker.platform.pickFiles(type: FileType.audio);
    if (filePickerRes != null) {
      return File(filePickerRes.files.first.xFile.path);
    }
    return null;
  } catch (e) {
    return null;
  }
}

Future<File?> pickImage() async {
  try {
    final filePickerRes =
        await FilePicker.platform.pickFiles(type: FileType.image);
    if (filePickerRes != null) {
      return File(filePickerRes.files.first.xFile.path);
    }
    return null;
  } catch (e) {
    return null;
  }
}

Widget myRow(IconData icon, String msg) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
    child: Row(
      children: [
        Icon(
          icon,
          color: Pallete.whiteColor,
          size: 30,
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          msg,
          style: TextStyle(
              color: Pallete.whiteColor,
              fontSize: 12,
              fontWeight: FontWeight.w400),
        )
      ],
    ),
  );
}

Widget PlanContainer(Color gradienStart, Color gradientEnd, String price,
    String time, String audiance, String middle_offer, String last_offer) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16),
    padding: EdgeInsets.only(top: 18, left: 25, right: 25, bottom: 10),
    width: double.maxFinite,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      gradient: LinearGradient(
        colors: [gradienStart, gradientEnd],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    child: Column(
      children: [
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white.withOpacity(0.8)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '\u20B9$price `for $time months ',
                  style: TextStyle(
                      color: Pallete.backgroundColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
            Expanded(child: SizedBox()),
          ],
        ),
        Row(
          children: [
            Text(
              "Premium $audiance",
              style: TextStyle(
                  color: Pallete.whiteColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w700),
            ),
            Expanded(child: SizedBox()),
            Text(
              "\u20B9$price",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 25,
                  color: Pallete.whiteColor),
            )
          ],
        ),
        Row(
          children: [
            Expanded(child: SizedBox()),
            Text(
              "FOR $time MONTHS",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Pallete.whiteColor),
            )
          ],
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          textAlign: TextAlign.center,
          middle_offer,
          style: TextStyle(
            color: Pallete.whiteColor,
            fontSize: 16,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Pallete.whiteColor)),
            onPressed: () {},
            child: Text(
              "GET PREMIUM $audiance",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Pallete.backgroundColor),
            )),
        SizedBox(
          height: 5,
        ),
        RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                text: last_offer,
                style: TextStyle(color: Colors.grey.shade300, fontSize: 12),
                children: [
                  TextSpan(
                      text: "Terms apply.",
                      style: TextStyle(color: Pallete.whiteColor))
                ])),
        SizedBox(
          height: 5,
        )
      ],
    ),
  );
}

Widget iconContainer(String data, String svgPath) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 15),
    decoration: BoxDecoration(
        color: Pallete.transparentColor,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: Pallete.greyColor,
          width: 0.5,
        )),
    margin: EdgeInsets.symmetric(horizontal: 30),
    child: Row(
      children: [
        SvgPicture.asset(
          svgPath,
          height: 22,
          width: 20,
        ),
        Expanded(
          child: Text(
            data,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: Pallete.whiteColor),
          ),
        ),
      ],
    ),
  );
}

const TextStyle spotifyHeadings =
  TextStyle(
      height: 1.1,
      color: Pallete.whiteColor,
      fontSize: 30,
      fontWeight: FontWeight.w800
  );



