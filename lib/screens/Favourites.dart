import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:down/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:down/model/dbfunctions.dart';
import 'package:down/model/favouriteModel.dart';
import 'package:down/screens/BottomNavbar.dart';
import 'package:down/screens/HomePage.dart';
import 'package:down/screens/nowPlaying2.dart';
import 'package:down/widgets/Favourites.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../widgets/FloatingControler.dart';

class Favourites extends StatefulWidget {
  const Favourites({super.key});

  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  List<Audio> allsongs = [];
  AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');
  @override
  void initState() {
    // TODO: implement initState
    final favSongsdb = Hive.box<favsongs>('favsongs').values.toList();
    for (var item in favSongsdb) {
      allsongs.add(Audio.file(item.songurl.toString(),
          metas: Metas(
              artist: item.artist,
              title: item.songname,
              id: item.id.toString())));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final height = MediaQuery.of(context).size.height;
    // final width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          // stops: [0.1, 0.5, 0.7, 0.9],
          colors: [gr1, Colors.black],
        ),
      ),
      child: Scaffold(
        backgroundColor: black.withOpacity(0),
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: ((c) => BottomNavbar())));
              },
              icon: Icon(
                Icons.arrow_back,
                color: white,
              )),
          title: Row(
            children: [
              Text(
                "F",
                style: TextStyle(
                    fontFamily: "Inter",
                    fontWeight: FontWeight.bold,
                    color: cyan,
                    fontSize: 30),
              ),
              const Text(
                "avourites",
                style: TextStyle(
                    fontFamily: "Inter",
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
            ],
          ),
          backgroundColor: trans,
        ),
        // bottomSheet: FloatingController(),
        body: ValueListenableBuilder<Box<favsongs>>(
          valueListenable: Hive.box<favsongs>('favsongs').listenable(),
          builder: ((context, Box<favsongs> alldbfavsongs, child) {
            List<favsongs> allDbsongs = alldbfavsongs.values.toList();
            if (favsongsdb.isEmpty) {
              return Center(
                child: Text(
                  "No Favourites",
                  style: TextStyle(
                    color: white,
                    fontSize: 20,
                  ),
                ),
              );
            }
            if (favsongsdb == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              itemCount: allDbsongs.length,
              padding: EdgeInsets.only(top: 10),
              itemBuilder: (context, index) {
                return Dismissible(
                  key: ObjectKey(allDbsongs[index]),
                  onDismissed: (direction) {
                    setState(() {
                      favsongsdb.deleteAt(index);
                    });
                  },
                  child: ListTile(
                      onTap: (() {
                        audioPlayer.open(
                            Playlist(audios: allsongs, startIndex: index),
                            showNotification: true,
                            headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplug,
                            loopMode: LoopMode.playlist);
                        setState(() {});
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => NowPlaying2())));
                      }),
                      leading: QueryArtworkWidget(
                        id: allDbsongs[index].id!,
                        type: ArtworkType.AUDIO,
                        artworkFit: BoxFit.cover,
                        size: 200,
                        quality: 100,
                        artworkBorder: BorderRadius.circular(10),
                        nullArtworkWidget: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: Image.asset(
                            'assets/images/music.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      trailing: IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: ((context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    backgroundColor: grey,
                                    title: Text(
                                      "Remove from favourites",
                                      style: TextStyle(color: white),
                                    ),
                                    content: Text("Are you Sure ?",
                                        style: TextStyle(color: white)),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("Cancel",
                                            style: TextStyle(color: white)),
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            favsongsdb.deleteAt(index);
                                            Navigator.pop(context);
                                          },
                                          child: Text("Remove",
                                              style:
                                                  TextStyle(color: (white)))),
                                    ],
                                  );
                                }));
                          },
                          icon: Icon(
                            Icons.delete,
                            color: red,
                          )),
                      subtitle: Text(
                        allDbsongs[index].artist!,
                        style: TextStyle(
                          color: white,
                          fontFamily: "Inter",
                        ),
                      ),
                      title: Text(
                        allDbsongs[index].songname!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: cyan,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.bold),
                      )),
                );
              },
            );
          }),
        ),
      ),
    );
  }
}
