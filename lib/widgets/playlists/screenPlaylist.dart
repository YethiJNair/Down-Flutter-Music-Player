// ignore_for_file: must_be_immutable

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:down/colors/colors.dart';
import 'package:down/model/dbfunctions.dart';
import 'package:down/model/playlistmodel.dart';
import 'package:down/model/songModel.dart';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:hive_flutter/adapters.dart';
import 'package:down/screens/nowPlaying2.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../model/songModel.dart';

class ScreenPlaylist extends StatefulWidget {
  ScreenPlaylist(
      {super.key,
      required this.allPlaylistSongs,
      required this.playlistindex,
      required this.playlistname});

  List<Songs> allPlaylistSongs = [];
  int playlistindex;
  String playlistname;

  @override
  State<ScreenPlaylist> createState() => _ScreenPlaylistState();
}

class _ScreenPlaylistState extends State<ScreenPlaylist> {
  AssetsAudioPlayer player = AssetsAudioPlayer.withId('0');
  List<Audio> plstsongs = [];

  @override
  void initState() {
    for (var song in widget.allPlaylistSongs) {
      plstsongs.add(Audio.file(song.songurl.toString(),
          metas: Metas(
              title: song.songname,
              artist: song.artist,
              id: song.id.toString())));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          // stops: [0.1, 0.5, 0.7, 0.9],
          colors: [
            HexColor("#0f1223"),
            HexColor("#070915"),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: black.withOpacity(0),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 370,
                  decoration: BoxDecoration(
                    color: black.withOpacity(0),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/logo.jpg",
                        height: 280,
                        width: 280,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 15, 15, 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.playlistname,
                              style: const TextStyle(
                                  fontSize: 50,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                favoriteList()
              ],
            ),
          ),
        ),
      ),
    );
  }

  favoriteList() {
    return ValueListenableBuilder<Box<PlaylistSongs>>(
        valueListenable: playlistbox.listenable(),
        builder: (context, value, _) {
          List<PlaylistSongs> plsongs = playlistbox.values.toList();
          List<Songs>? songs = plsongs[widget.playlistindex].playlistssongs;
          if (songs!.isEmpty) {
            return const Align(
              heightFactor: 7.5,
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Center(
                  child: Text(
                    "No Songs Added",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
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
              itemCount: songs.length,
              itemBuilder: ((context, index) {
                return ListTile(
                  onTap: () {
                    player.open(Playlist(audios: plstsongs, startIndex: index),
                        showNotification: true, loopMode: LoopMode.playlist);
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const NowPlaying2(),
                    ));
                    /* Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => playingNow()))); */
                  },
                  leading: QueryArtworkWidget(
                    artworkFit: BoxFit.cover,
                    id: songs[index].id!,
                    type: ArtworkType.AUDIO,
                    artworkQuality: FilterQuality.high,
                    size: 2000,
                    quality: 100,
                    artworkBorder: BorderRadius.circular(10),
                    nullArtworkWidget: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                      child: Image.asset(
                        'assets/images/music.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  subtitle: Text(
                    songs[index].artist!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Colors.grey,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.bold),
                  ),
                  title: Text(
                    songs[index].songname!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Colors.white,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.bold),
                  ),
                  trailing: IconButton(
                    onPressed: (() {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor: Color.fromARGB(255, 50, 50, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            title: const Text(
                              "Delete Playlist",
                              style: TextStyle(color: Colors.white),
                            ),
                            content: const Text(
                              "Are You Sure ?",
                              style: TextStyle(color: Colors.white),
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Cancel",
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 213, 213, 213)))),
                              TextButton(
                                  onPressed: () {
                                    setState(() {
                                      songs.removeAt(index);
                                      plsongs.removeAt(index);
                                      playlistbox.putAt(
                                          widget.playlistindex,
                                          PlaylistSongs(
                                              playlistname: widget.playlistname,
                                              playlistssongs: songs));
                                    });
                                    setState(() {});
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Delete",
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 213, 213, 213))))
                            ],
                          );
                        },
                      );
                    }),
                    icon: const Icon(
                      Icons.delete_outline_outlined,
                      color: Colors.grey,
                    ),
                  ),
                );
              }),
            ),
          );
        });
  }
}
