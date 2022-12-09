// ignore_for_file: camel_case_types, avoid_print, file_names

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:down/model/dbfunctions.dart';
import 'package:down/model/mostPlayed.dart';
import 'package:down/screens/BottomNavbar.dart';
import 'package:down/screens/nowPlaying2.dart';
import 'package:down/widgets/addTofavourite.dart';
import 'package:down/widgets/playlists/addToPlaylist.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../colors/colors.dart';

class mostlyPlayed extends StatefulWidget {
  const mostlyPlayed({super.key});

  @override
  State<mostlyPlayed> createState() => _mostlyPlayedState();
}

class _mostlyPlayedState extends State<mostlyPlayed> {
  AssetsAudioPlayer player = AssetsAudioPlayer.withId("0");
  List<Audio> songs = [];

  @override
  void initState() {
    List<MostPlayed> songlist = mostplayedsongs.values.toList();

    int i = 0;
    for (var item in songlist) {
      if (item.count > 5) {
        finalpmsongs.insert(i, item);
        i++;
      }
    }
    for (var items in finalpmsongs) {
      songs.add(Audio.file(items.songurl,
          metas: Metas(
              title: items.songname,
              artist: items.artist,
              id: items.id.toString())));
    }
    super.initState();
  }

  List<MostPlayed> finalpmsongs = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => BottomNavbar(),
              ));
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: Row(
          children: const [
            Text(
              "M",
              style: TextStyle(
                  fontFamily: "Inter",
                  fontSize: 35,
                  fontWeight: FontWeight.w900,
                  color: Colors.grey),
            ),
            Text(
              "ost Played",
              style: TextStyle(
                  fontFamily: "Inter",
                  fontSize: 35,
                  fontWeight: FontWeight.w900,
                  color: Colors.white),
            ),
          ],
        ),
      )),
      backgroundColor: const Color.fromARGB(255, 21, 21, 21),
      body: SafeArea(
        child: Column(
          children: [showmostlyplayed()],
        ),
      ),
    );
  }

  showmostlyplayed() {
    return ValueListenableBuilder(
        valueListenable: mostplayedsongs.listenable(),
        builder: (context, Box<MostPlayed> mpsongbox, _) {
          if (finalpmsongs.isNotEmpty) {
            return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: finalpmsongs.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 2),
                    child: ListTile(
                      onTap: (() {
                        print(player.getCurrentAudioTitle);

                        player.open(Playlist(audios: songs, startIndex: index),
                            showNotification: notificationStatus,
                            headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplug,
                            loopMode: LoopMode.playlist);
                        setState(() {
                          initState();
                        });
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) => const NowPlaying2()),
                          ),
                        );
                      }),
                      leading: QueryArtworkWidget(
                        artworkHeight: 55,
                        artworkWidth: 55,
                        id: finalpmsongs[index].id,
                        type: ArtworkType.AUDIO,
                        artworkFit: BoxFit.cover,
                        artworkQuality: FilterQuality.high,
                        size: 200,
                        quality: 100,
                        artworkBorder: BorderRadius.circular(10),
                        nullArtworkWidget: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          child: Image.asset(
                            'assets/images/musify copy0.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      subtitle: Text(
                        finalpmsongs[index].artist,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontFamily: "Inter",
                        ),
                      ),
                      title: Text(
                        finalpmsongs[index].songname,
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
                    ),
                  );
                });
          } else {
            return const Padding(
              padding: EdgeInsets.all(8.0),
              child: Align(
                heightFactor: 7.5,
                child: Center(
                  child: Text('''Your most played songs will be listed here ''',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w300)),
                ),
              ),
            );
          }
        });
  }
}
