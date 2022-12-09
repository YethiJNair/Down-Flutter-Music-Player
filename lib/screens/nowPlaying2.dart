import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:down/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:down/model/songModel.dart';
import 'package:down/screens/HomePage.dart';
import 'package:down/screens/SplashScreen.dart';
import 'package:down/widgets/addTofavourite.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:on_audio_query/on_audio_query.dart';

class NowPlaying2 extends StatefulWidget {
  const NowPlaying2({super.key});

  @override
  State<NowPlaying2> createState() => _NowPlaying2State();
}

class _NowPlaying2State extends State<NowPlaying2> {
  final player = AssetsAudioPlayer.withId('0');
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  late List<Songs> dbsongs;
  bool isRepeat = false;
  bool isPlaying = false;

  @override
  void initState() {
    dbsongs = box.values.toList();

    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return player.builderCurrent(builder: ((context, playing) {
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
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: white,
                )),
            centerTitle: true,
            backgroundColor: black.withOpacity(0),
            elevation: 0,
            // title: Text(
            //   "Now Playing",
            //   style: TextStyle(
            //       color: white,
            //       fontFamily: "Inter",
            //       fontWeight: FontWeight.bold,
            //       fontSize: 25),
            // ),
          ),
          backgroundColor: black.withOpacity(0),
          body: Center(
            child: Column(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: height * 0.05,
                    ),
                    Text(
                      "Now Playing",
                      style: TextStyle(
                          color: white,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                    SizedBox(
                      height: height * 0.1,
                    ),
                    SizedBox(
                      width: 350,
                      height: 350,
                      child: QueryArtworkWidget(
                        id: int.parse(playing.audio.audio.metas.id!),
                        type: ArtworkType.AUDIO,
                        artworkHeight: 300,
                        artworkWidth: 350,
                        artworkBorder: BorderRadius.circular(5),
                        artworkFit: BoxFit.cover,
                        nullArtworkWidget: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.asset(
                            'assets/images/music.jpg',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: width * 0.75,
                      child: Text(
                        player.getCurrentAudioTitle,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: cyan,
                            fontSize: 30,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                    Text(
                      player.getCurrentAudioArtist,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                        fontFamily: "Inter",
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.playlist_add,
                              color: Colors.white,
                              size: 30,
                            )),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                if (isRepeat) {
                                  player.setLoopMode(LoopMode.none);
                                  isRepeat = false;
                                } else {
                                  player.setLoopMode(LoopMode.single);
                                }
                              });
                            },
                            icon: isRepeat
                                ? Icon(
                                    Icons.repeat,
                                    color: Colors.white,
                                    size: 30,
                                  )
                                : const Icon(
                                    Icons.repeat,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    size: 30,
                                  )),
                        IconButton(
                            onPressed: () {
                              setState(() {});
                              player.toggleShuffle();
                            },
                            icon: player.isShuffling.value
                                ? Icon(
                                    Icons.shuffle,
                                    color: Colors.white,
                                    size: 30,
                                  )
                                : const Icon(
                                    Icons.shuffle,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    size: 30,
                                  )),
                        player.builderCurrent(builder: ((context, playing) {
                          return addToFav(
                              index: dbsongs.indexWhere((element) =>
                                  element.songname ==
                                  playing.audio.audio.metas.title));
                        }))
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        Container(
                          width: 360,
                          child: PlayerBuilder.realtimePlayingInfos(
                            player: player,
                            builder: (context, RealtimePlayingInfos) {
                              final duration =
                                  RealtimePlayingInfos.current!.audio.duration;
                              final position =
                                  RealtimePlayingInfos.currentPosition;

                              return ProgressBar(
                                baseBarColor: Colors.white.withOpacity(0.5),
                                progressBarColor: Colors.white,
                                thumbColor: Colors.white,
                                thumbRadius: 5,
                                // barHeight: 1,
                                timeLabelPadding: 5,
                                // timeLabelLocation: TimeLabelLocation.sides,
                                progress: position,

                                timeLabelTextStyle:
                                    TextStyle(color: Colors.white),
                                total: duration,
                                onSeek: (duration) async {
                                  // print('User selected a new time: $duration');
                                  await player.seek(duration);
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        PlayerBuilder.isPlaying(
                          player: player,
                          builder: ((context, isPlaying) {
                            return IconButton(
                                iconSize: 40,
                                onPressed: () async {
                                  await player.previous();
                                  setState(() {});
                                  if (isPlaying == false) {
                                    await player.pause();
                                  }
                                },
                                icon: Icon(
                                  Icons.skip_previous_rounded,
                                  color: Colors.white,
                                ));
                          }),
                        ),
                        // SizedBox(
                        //   width: 40,
                        // ),
                        IconButton(
                            onPressed: () async {
                              await player.seekBy(const Duration(seconds: -10));
                            },
                            icon: Icon(
                              Icons.replay_10,
                              color: white,
                            )),
                        Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(101),
                              color: white),
                          child: Center(
                            child: PlayerBuilder.isPlaying(
                                player: player,
                                builder: (context, isPlaying) {
                                  return IconButton(
                                    onPressed: () async {
                                      await player.playOrPause();
                                    },
                                    icon: Icon(isPlaying
                                        ? Icons.pause
                                        : Icons.play_arrow),
                                    iconSize: 40,
                                    color: black,
                                  );
                                }),
                          ),
                        ),
                        IconButton(
                            onPressed: () async {
                              await player.seekBy(Duration(seconds: 10));
                            },
                            icon: Icon(
                              Icons.forward_10,
                              color: white,
                            )),
                        PlayerBuilder.isPlaying(
                            player: player,
                            builder: ((context, isPlaying) {
                              return IconButton(
                                  iconSize: 40,
                                  onPressed: () async {
                                    await player.next();
                                    setState(() {});
                                    if (isPlaying == false) {
                                      await player.pause();
                                    }
                                  },
                                  icon: Icon(
                                    Icons.skip_next_rounded,
                                    color: white,
                                  ));
                            })),
                        // SizedBox(
                        //   width: 40,
                        // ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    }));
  }
}
