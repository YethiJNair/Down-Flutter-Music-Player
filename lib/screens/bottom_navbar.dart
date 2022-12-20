import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:down/screens/favourite_screen.dart';
import 'package:down/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:down/widgets/floating_controller.dart';
import '../Colors/colors.dart';
import 'home_page.dart';
import 'playlists.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';

// ignore: must_be_immutable
class BottomNavbar extends StatefulWidget {
  BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
//   int index = 0;
//   final navigationKey = GlobalKey<CurvedNavigationBarState>();

//   final screens = [
//     const HomePage(),
//     const ScreenSearch(),
//     const Favourites(),
//     const Playlists(),
//   ];
//   @override
//   Widget build(BuildContext context) {
//     final items = <Widget>[
//       const Icon(
//         Icons.home_filled,
//         size: 30,
//       ),
//       const Icon(Icons.search, size: 30),
//       const Icon(Icons.favorite, size: 30),
//       const Icon(Icons.playlist_add, size: 30),
//     ];
//     return Scaffold(
//       bottomSheet: const FloatingController(),
//       body: screens[index],
//       extendBody: false,
//       backgroundColor: black,
//       bottomNavigationBar: Theme(
//         data: Theme.of(context)
//             .copyWith(iconTheme: IconThemeData(color: Colors.white)),
//         child: CurvedNavigationBar(
//           color: const Color.fromARGB(255, 12, 97, 103),
//           buttonBackgroundColor:const  Color.fromARGB(255, 12, 97, 103),
//           backgroundColor: Colors.transparent,
//           items: items,
//           animationCurve: Curves.easeInOut,
//           animationDuration:const  Duration(milliseconds: 250),
//           height: 55,
//           index: index,
//           onTap: (index) => setState(() => this.index = index),
//         ),
//       ),

//     );
//   }
// }

  int _selectedIndex = 0;

  List<Widget> tabItems = [
    const HomePage(),
    const ScreenSearch(),
    const Favourites(),
    const Playlists(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        bottomSheet: FloatingController(),
        body: Center(
          child: tabItems[_selectedIndex],
        ),
        bottomNavigationBar: FlashyTabBar(
          animationCurve: Curves.linear,
          backgroundColor: Color.fromARGB(255, 0, 0, 0),
          selectedIndex: _selectedIndex,
          iconSize: 30,
          showElevation: false, // use this to remove appBar's elevation
          onItemSelected: (index) => setState(() {
            _selectedIndex = index;
          }),
          items: [
            FlashyTabBarItem(
              activeColor: white,
              icon: Icon(
                Icons.home_filled,
                color: white,
              ),
              title: Text('Home'),
            ),
            FlashyTabBarItem(
              activeColor: white,
              icon: Icon(
                Icons.search,
                color: cyan,
              ),
              title: Text('Search'),
            ),
            FlashyTabBarItem(
              activeColor: white,
              icon: Icon(
                Icons.favorite,
                color: Colors.pink,
              ),
              title: Text('Favourites'),
            ),
            FlashyTabBarItem(
              activeColor: white,
              icon: Icon(
                Icons.playlist_add,
                color: white,
              ),
              title: Text('Playlist'),
            ),
          ],
        ),
      ),
    );
  }
}
