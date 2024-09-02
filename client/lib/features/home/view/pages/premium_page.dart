import 'package:cached_network_image/cached_network_image.dart';
import 'package:client/core/theme/app_pallete.dart';
import 'package:client/core/utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class premiumPage extends StatefulWidget {
  const premiumPage({super.key});

  @override
  State<premiumPage> createState() => _premiumPageState();
}

class _premiumPageState extends State<premiumPage> {
  final String img =
      'https://images.pexels.com/photos/11994111/pexels-photo-11994111.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: double.maxFinite,
                  height: 380,
                  decoration: BoxDecoration(

                  ),
                  child: CachedNetworkImage(
                    imageUrl: img,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  height: 380,
                  width: double.maxFinite,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Pallete.transparentColor,
                      Pallete.backgroundColor
                    ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            FaIcon(
                              FontAwesomeIcons.spotify,
                              size: 30,
                            ),
                            Text(
                              " Premium",
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Pallete.whiteColor),
                            ),
                          ],
                        ),
                        Text(
                          'Listen without limits. Try 3 months of Premium for \u20B959.',
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 30,
                              color: Pallete.whiteColor),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 35,
                          width: 180,
                          decoration: BoxDecoration(
                            color: Color(0xff212121),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.bell,
                                  color: Colors.blue,
                                  size: 20,
                                ),
                                Text(
                                  "  Limited time offer",
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: 150,
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  Container(
                    width: double.maxFinite,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(vertical: 16)),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Pallete.whiteColor)),
                        onPressed: () {},
                        child: Text(
                          'GET PREMIUM INDIVIDUAL',
                          style: TextStyle(
                              color: Pallete.backgroundColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10.0,
                    ),
                    child: RichText(
                      text: TextSpan(
                          text:
                              "Premium Individual only.\u20B959 for 3 months, than \u20B9119 per month after.Offer only available if you haven't tried Premium before.",
                          style: TextStyle(
                              color: Pallete.greyColor,
                              fontSize: 11,
                              fontWeight: FontWeight.w400),
                          children: [
                            TextSpan(
                                text: " Terms apply.",
                                style: TextStyle(color: Pallete.whiteColor)),
                            TextSpan(text: " Offer ends August 25,2024.")
                          ]),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              width: double.maxFinite,
              decoration: BoxDecoration(
                  color: Color(0xff212121),
                  borderRadius: BorderRadius.circular(15)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      "Why join Premium ? ",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Pallete.whiteColor),
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Divider(
                    color: Pallete.greyColor.withOpacity(0.5), // Line color
                    thickness: 0.5, // Line thickness
                    // Right spacing
                  ),
                  myRow(Icons.code_off, " Ad-free music listening"),
                  myRow(Icons.download_for_offline_outlined,
                      " Download to listen offline"),
                  myRow(Icons.shuffle_rounded, " Play song in any order"),
                  myRow(Icons.headphones_outlined, " High audio quality"),
                  myRow(Icons.groups_3_outlined,
                      " Listen with friends in real time"),
                  myRow(Icons.format_list_bulleted_rounded,
                      " Organize listening queue"),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                "Available plans",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Pallete.whiteColor,
                    fontSize: 20),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            PlanContainer(
                Color(0xffff5858),
                Color(0xfff09819),
                "59",
                "3",
                "Individual",
                "1 Premium account . Cancel anytime . Subscribe or one-time-payment ",
                "Premium Individual only. \u20B9 59 fro 3 month , than \u20B9119 per month after. Offer only available if you haven't tried Premium before. "),
            SizedBox(height: 25,),
            PlanContainer(
                Color(0xff6713d2),
                Color(0xffcc208e),
                "179",
                "2",
                "Family",
                "1 Premium account . Cancel anytime . Subscribe or one-time-payment ",
                "Premium Individual only. \u20B9 59 fro 3 month , than \u20B9119 per month after. Offer only available if you haven't tried Premium before. "),
            SizedBox(height: 25,),
            PlanContainer(
                Color(0xff2af598),
                Color(0xff009efd),
                "149",
                "2",
                "Duo",
                "1 Premium account . Cancel anytime . Subscribe or one-time-payment ",
                "Premium Individual only. \u20B9 59 fro 3 month , than \u20B9119 per month after. Offer only available if you haven't tried Premium before. "),
            SizedBox(height: 25,),
            PlanContainer(
                Color(0xff00c6fb),
                Color(0xff005bea),
                "59",
                "2",
                "Student",
                "1 Premium account . Cancel anytime . Subscribe or one-time-payment ",
                "Premium Individual only. \u20B9 59 fro 3 month , than \u20B9119 per month after. Offer only available if you haven't tried Premium before. "),
            SizedBox(height: 25,),
          ],
        ),
      ),
    );
  }
}
