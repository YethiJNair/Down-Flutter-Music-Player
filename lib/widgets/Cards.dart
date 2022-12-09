import 'package:down/screens/mostlyPlayed.dart';
import 'package:down/screens/recentlyPlayedScreen.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:down/model/favouriteModel.dart';
import 'package:down/screens/Favourites.dart';
import 'package:down/screens/Playlists.dart';
import 'package:down/widgets/AlbumArt.dart';

class Cards extends StatelessWidget {
  const Cards({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<favsongs>>(
        valueListenable: Hive.box<favsongs>('favsongs').listenable(),
        builder: ((context, Box<favsongs> alldbfavsongs, child) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            // child: SingleChildScrollView(
            //   scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: 470,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // InkWell(
                  //   onTap: () {
                  //     Navigator.of(context).push(MaterialPageRoute(
                  //         builder: ((context) => Favourites())));
                  //   },
                  //   child: AlbumArt(
                  //     imageName: "assets/images/fav.jpg",
                  //     head: "Favourites",
                  //     song: alldbfavsongs.length,
                  //   ),
                  // ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: ((context) => mostlyPlayed())));
                    },
                    child: const AlbumArt(
                      imageName: "assets/images/most.jpg",
                      head: "Most Played",
                      song: 0,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: ((context) => recentlyPlayed())));
                    },
                    child: const AlbumArt(
                      imageName: "assets/images/recent.jpg",
                      head: "Recent Played",
                      song: 0,
                    ),
                  )
                ],
              ),
            ),
          );
        }));
  }
}
