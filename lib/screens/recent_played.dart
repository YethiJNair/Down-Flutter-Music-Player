// ignore_for_file: file_names, camel_case_types, unused_local_variable, non_constant_identifier_names

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:down/widgets/floating_controller.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:down/model/dbfunctions.dart';
import 'package:down/model/mostPlayed.dart';
import 'package:down/model/recentlyPlayed.dart';
import 'package:down/screens/bottom_navbar.dart';
import 'package:down/widgets/addTofavourite.dart';
import 'package:down/widgets/playlists/addToPlaylist.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../Colors/colors.dart';

class recentlyPlayed extends StatefulWidget {
  const recentlyPlayed({super.key});

  @override
  State<recentlyPlayed> createState() => _recentlyPlayedState();
}

class _recentlyPlayedState extends State<recentlyPlayed> {
  AssetsAudioPlayer player = AssetsAudioPlayer.withId("0");
  List<Audio> resongs = [];

  @override
  void initState() {
    List<RecentlyPlayed> rdbsongs =
        recentlyplayedbox.values.toList().reversed.toList();
    for (var item in rdbsongs) {
      resongs.add(Audio.file(item.songurl!,
          metas: Metas(
            artist: item.songname,
            title: item.artist,
            id: item.id.toString(),
          )));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomCenter,
          // stops: [0.1, 0.5, 0.7, 0.9],
          colors: [gr1, Colors.black],
        ),
      ),
      child: Scaffold(
        bottomSheet: const FloatingController(),
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => BottomNavbar(),
                ));
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          automaticallyImplyLeading: false,
          backgroundColor: trans,
          title: Row(
            children: const [
              Text(
                "Recent Played",
                style: TextStyle(
                    fontFamily: "Inter",
                    fontSize: 35,
                    fontWeight: FontWeight.w900,
                    color: Colors.white),
              ),
            ],
          ),
        ),
        backgroundColor: trans,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [Recentlist()],
            ),
          ),
        ),
      ),
    );
  }

  Recentlist() {
    return ValueListenableBuilder<Box<RecentlyPlayed>>(
        valueListenable: recentlyplayedbox.listenable(),
        builder: (context, Box<RecentlyPlayed> recentsongs, _) {
          final height = MediaQuery.of(context).size.height;
          final width = MediaQuery.of(context).size.width;
          List<RecentlyPlayed> rsongs =
              recentsongs.values.toList().reversed.toList();

          if (rsongs.isEmpty) {
            return const Padding(
              padding: EdgeInsets.all(20.0),
              child: Align(
                heightFactor: 7.5,
                child: Center(
                  child: Text(
                    "You haven't played anything ! Try playing something.",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: rsongs.length,
              itemBuilder: ((context, index) {
                List<MostPlayed> allmostplayedsongs =
                    mostplayedsongs.values.toList();
                MostPlayed msongs = allmostplayedsongs[index];
                return ListTile(
                  onTap: () {},
                  leading: QueryArtworkWidget(
                    artworkHeight: 55,
                    artworkWidth: 55,
                    id: rsongs[index].id!,
                    type: ArtworkType.AUDIO,
                    artworkFit: BoxFit.cover,
                    artworkQuality: FilterQuality.high,
                    size: 2000,
                    quality: 100,
                    artworkBorder: BorderRadius.circular(10),
                    nullArtworkWidget: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: Image.asset(
                        'assets/images/music.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  subtitle: Text(
                    rsongs[index].artist!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontFamily: "Inter",
                    ),
                  ),
                  title: Text(
                    rsongs[index].songname!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Colors.white,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.bold),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      addToPlaylist(songindex: index),
                      addToFav(index: index),
                    ],
                  ),
                );
              }),
            ),
          );
        });
  }
}
