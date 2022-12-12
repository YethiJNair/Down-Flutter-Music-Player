import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:down/Colors/colors.dart';
import 'package:down/model/mostPlayed.dart';
import 'package:down/model/recentlyPlayed.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:down/model/songModel.dart';
import 'package:down/screens/splash_screen.dart';
import 'package:down/screens/now_playing.dart';
import 'package:on_audio_query/on_audio_query.dart';

class FloatingController extends StatefulWidget {
  const FloatingController({super.key});

  @override
  State<FloatingController> createState() => _FloatingControllerState();
}

class _FloatingControllerState extends State<FloatingController> {
  AssetsAudioPlayer player = AssetsAudioPlayer.withId('0');
  // AssetsAudioPlayer player = AssetsAudioPlayer();
  // late AnimationController _animationController;

  // bool isPlaying = false;
  // @override
  // void initState() {
  //   super.initState();
  //   player.open(
  //       Audio(
  //           "assets/audio/X2Download.app - The Weeknd - Save Your Tears (Official Music Video) (128 kbps).mp3"),
  //       autoStart: false,
  //       showNotification: true);
  //   _animationController =
  //       AnimationController(vsync: this, duration: Duration(milliseconds: 450));
  // }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<Songs>>(
        valueListenable: box.listenable(),
        builder: ((context, Box<Songs> allsongbox, child) {
          List<Songs> allDbdongs = allsongbox.values.toList();
          return player.builderCurrent(builder: (context, playing) {
            return Container(
              color: black,
              height: 80,
              // width: MediaQuery.of(context).size.width,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  onTap: (() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => NowPlaying2())));
                  }),
                  // leading: ClipRRect(
                  //   child: Image.asset("assets/images/The_Weeknd_-_After_Hours.png"),
                  //   borderRadius: BorderRadius.all(Radius.circular(10)),
                  // ),
                  contentPadding: const EdgeInsets.all(0),
                  leading: QueryArtworkWidget(
                    id: int.parse(playing.audio.audio.metas.id!),
                    type: ArtworkType.AUDIO,
                    artworkBorder: BorderRadius.circular(5),
                    artworkWidth: 55,
                    artworkHeight: 55,
                    artworkQuality: FilterQuality.high,
                    size: 2000,
                    quality: 100,
                    artworkFit: BoxFit.cover,
                    nullArtworkWidget: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: Image.asset(
                        'assets/images/musify copy0.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  title: Text(
                    player.getCurrentAudioTitle,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w900,
                        color: Colors.white),
                  ),
                  subtitle: Text(
                    player.getCurrentAudioArtist,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontFamily: "Inter",
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 180, 179, 179)),
                  ),

                  trailing: PlayerBuilder.isPlaying(
                    player: player,
                    builder: (context, isPlaying) {
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () async {
                              if (playing.index == 0) {
                                player
                                    .playlistPlayAtIndex(allDbdongs.length - 1);
                              } else {
                                await player.previous();
                              }

                              setState(() {});
                              if (isPlaying == false) {
                                await player.pause();
                              }
                            },
                            icon: Icon(
                              Icons.skip_previous,
                              color: Colors.white,
                            ),
                          ),
                          IconButton(
                            iconSize: 40,
                            onPressed: () {
                              player.playOrPause();
                            },
                            icon: Icon(
                                isPlaying ? Icons.pause : Icons.play_arrow),
                            color: Colors.white,
                          ),
                          IconButton(
                            onPressed: () async {
                              if (playing.index == allDbdongs.length - 1) {
                                player.playlistPlayAtIndex(0);
                              } else {
                                await player.next();
                              }
                              // await player.next();
                              setState(() {});

                              if (isPlaying == false) {
                                await player.pause();
                              }
                            },
                            icon: Icon(
                              Icons.skip_next,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            );
          });
        }));
  }

  // void _handleOnPress() {
  //   setState(() {
  //     isPlaying = !isPlaying;
  //     if (isPlaying) {
  //       _animationController.forward();
  //       player.play();
  //     } else {
  //       _animationController.reverse();
  //       player.pause();
  //     }
  //   });
  // }
}
