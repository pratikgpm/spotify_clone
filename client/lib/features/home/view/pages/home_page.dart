import 'package:client/core/theme/app_pallete.dart';
import 'package:client/features/home/view/pages/library_page.dart';
import 'package:client/features/home/view/pages/premium_page.dart';
import 'package:client/features/home/view/pages/search_page.dart';
import 'package:client/features/home/view/pages/song_page.dart';
import 'package:client/features/home/view/widgets/music_slab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../widgets/side_drawer.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> with SingleTickerProviderStateMixin{

  int selectedIndex = 0;
  final pages = [
    SongPage(),
    SearchPage(),
    LibraryPage(),
    premiumPage(),
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
      BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            backgroundColor: Pallete.transparentColor,
            icon: Image.asset(
              selectedIndex == 0
                  ? 'assets/images/home_filled.png'
                  : 'assets/images/home_unfilled.png',
              color: selectedIndex == 0
                  ? Pallete.whiteColor
                  : Pallete.inactiveBottomBarItemColor,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            backgroundColor: Pallete.transparentColor,
            icon: Image.asset(
              selectedIndex == 1
                  ? 'assets/images/search_filled.png'
                  : 'assets/images/search_unfilled.png',
              color: selectedIndex == 1
                  ? Pallete.whiteColor
                  : Pallete.inactiveBottomBarItemColor,
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            backgroundColor: Pallete.transparentColor,
            icon: Image.asset(
              'assets/images/library.png',
              color: selectedIndex == 2
                  ? Pallete.whiteColor
                  : Pallete.inactiveBottomBarItemColor,
            ),
            label: 'Library',
          ),
          BottomNavigationBarItem(
            backgroundColor: Pallete.transparentColor,
            icon: FaIcon(FontAwesomeIcons.spotify),
            label: 'Premium',
          ),
        ],
        selectedItemColor: Pallete.whiteColor,
        unselectedItemColor: Pallete.subtitleText,
        showUnselectedLabels: true,
        selectedFontSize: 10,
        unselectedFontSize: 10,
      ),
      body:
      Stack
      (
        children: [
          pages[selectedIndex],
          const Positioned(
            bottom: 0,
            child:
            MusicSlab(),

          ),
        ],
      ),
      drawer: SliderDrawer(),
    );
  }
}
