import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:down/colors/colors.dart';
import 'package:down/screens/Favourites.dart';
import 'package:down/screens/search.dart';
import 'package:flutter/material.dart';
import 'package:down/widgets/FloatingControler.dart';
import 'package:down/widgets/playlists/playlistScreen.dart';
import 'HomePage.dart';
import 'Playlists.dart';
import 'Settings.dart';

// ignore: must_be_immutable
class BottomNavbar extends StatefulWidget {
  BottomNavbar({super.key});
  // int currentIndex = 0;
  // List pages = const [
  //   HomePage(),
  //   // playLists(),
  //   Playlists(),
  //   Settings(),
  // ];

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int index = 0;
  final navigationKey = GlobalKey<CurvedNavigationBarState>();

  final screens = [
    HomePage(),
    screenSearch(),
    Favourites(),
    Playlists(),
  ];
  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      Icon(
        Icons.home_filled,
        size: 30,
      ),
      Icon(Icons.search, size: 30),
      Icon(Icons.favorite, size: 30),
      Icon(Icons.playlist_add, size: 30),
    ];
    return Scaffold(
      bottomSheet: FloatingController(),
      body: screens[index],
      extendBody: true,
      backgroundColor: black,
      bottomNavigationBar: Theme(
        data: Theme.of(context)
            .copyWith(iconTheme: IconThemeData(color: Colors.white)),
        child: CurvedNavigationBar(
          color: Color.fromARGB(255, 12, 97, 103),
          buttonBackgroundColor: Color.fromARGB(255, 12, 97, 103),
          backgroundColor: Colors.transparent,
          items: items,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 250),
          height: 55,
          index: index,
          onTap: (index) => setState(() => this.index = index),
        ),
      ),
      // bottomSheet: FloatingController(),
      // body: widget.pages[widget.currentIndex],
      // bottomNavigationBar: BottomNavigationBar(
      //   showSelectedLabels: false,
      //   showUnselectedLabels: false,
      //   unselectedItemColor: white,
      //   selectedItemColor: cyan,
      //   selectedIconTheme: IconThemeData(color: cyan),
      //   onTap: (newCurrentIndex) {
      //     setState(() {
      //       widget.currentIndex = newCurrentIndex;
      //     });
      //   },
      //   currentIndex: widget.currentIndex,
      //   backgroundColor: black,
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //         Icons.home_filled,
      //         size: 30,
      //       ),
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //         Icons.playlist_add,
      //         size: 30,
      //       ),
      //       label: 'Playlists',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //         Icons.settings,
      //         size: 30,
      //       ),
      //       label: 'Settings',
      //     ),
      //   ],
      // ),
    );
  }
}
