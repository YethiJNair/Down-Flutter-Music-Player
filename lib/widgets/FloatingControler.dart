import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:down/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:down/screens/nowPlaying2.dart';
import 'package:on_audio_query/on_audio_query.dart';

class FloatingController extends StatefulWidget {
  const FloatingController({super.key});

  @override
  State<FloatingController> createState() => _FloatingControllerState();
}

class _FloatingControllerState extends State<FloatingController> {
  AssetsAudioPlayer player = AssetsAudioPlayer.withId('0');

  @override
  Widget build(BuildContext context) {
    return player.builderCurrent(builder: (context, playing) {
      return Container(
        // decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),

        color: black,
        height: 80,
        // width: MediaQuery.of(context).size.width,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            onTap: (() {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => NowPlaying2())));
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
              artworkWidth: 60,
              artworkHeight: 60,
              artworkQuality: FilterQuality.high,
              size: 2000,
              quality: 100,
              artworkFit: BoxFit.cover,
              nullArtworkWidget: ClipRect(
                child: Image.asset(
                  "assets/images/music.jpg",
                  fit: BoxFit.cover,
                  width: 60,
                  height: 60,
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
            // trailing: Container(
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceAround,
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     mainAxisSize: MainAxisSize.min,
            //     children: [
            //       IconButton(
            //         onPressed: () {},
            //         icon: Icon(
            //           Icons.skip_previous,
            //           color: Color.fromARGB(255, 255, 255, 255),
            //         ),
            //       ),
            //       // Container(
            //       //   child: IconButton(
            //       //       // splashColor: Colors.lightGreenAccent,
            //       //       iconSize: 40,
            //       //       onPressed: () => _handleOnPress(),
            //       //       icon: AnimatedIcon(
            //       //           color: Colors.white,
            //       //           // size: 50,
            //       //           icon: AnimatedIcons.play_pause,
            //       //           progress: _animationController)),
            //       // ),
            //       IconButton(
            //         onPressed: () {},
            //         icon: Icon(
            //           Icons.skip_next,
            //           color: Color.fromARGB(255, 255, 255, 255),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            trailing: PlayerBuilder.isPlaying(
              player: player,
              builder: (context, isPlaying) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () async {
                        await player.previous();

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
                      icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                      color: Colors.white,
                    ),
                    IconButton(
                      onPressed: () async {
                        await player.next();
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
