import 'package:flutter/material.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class NowPlayingClip extends StatefulWidget {
  const NowPlayingClip({super.key});

  @override
  State<NowPlayingClip> createState() => _NowPlayingClipState();
}

class _NowPlayingClipState extends State<NowPlayingClip>
    with SingleTickerProviderStateMixin {
  AssetsAudioPlayer player = AssetsAudioPlayer();
  late AnimationController _animationController;

  bool isPlaying = false;
  @override
  void initState() {
    super.initState();
    player.open(Audio("assets/audio/The Weeknd - After Hours (Audio).mp3"),
        autoStart: false, showNotification: true);
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // player.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset("assets/images/The_Weeknd_-_After_Hours.png"),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          "Save Your Tears",
          style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontFamily: "Inter",
              fontWeight: FontWeight.w900),
        ),
        Text(
          "The Weeknd",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 20,
            fontFamily: "Inter",
          ),
        ),
        SizedBox(
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
                onPressed: () {},
                icon: Icon(
                  Icons.loop,
                  color: Colors.white,
                  size: 30,
                )),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.shuffle,
                  color: Colors.white,
                  size: 30,
                )),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.favorite_border_outlined,
                  color: Colors.white,
                  size: 30,
                )),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        player.builderRealtimePlayingInfos(
          builder: (context, RealtimePlayingInfos? infos) {
            if (infos == null) {
              return SizedBox();
            }
            return Column(
              children: [
                SizedBox(
                  width: 360,
                  child: ProgressBar(
                    baseBarColor: Colors.white.withOpacity(0.5),
                    progressBarColor: Colors.white,
                    thumbColor: Colors.white,
                    thumbRadius: 5,
                    // barHeight: 1,
                    timeLabelPadding: 5,
                    // timeLabelLocation: TimeLabelLocation.sides,
                    progress: infos.currentPosition,
                    total: infos.duration,
                    timeLabelTextStyle: TextStyle(color: Colors.white),
                    onSeek: (duration) {
                      // print('User selected a new time: $duration');
                      player.seek(duration);
                    },
                  ),
                ),
              ],
            );
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 40,
            ),
            IconButton(
                iconSize: 40,
                onPressed: () {},
                icon: Icon(
                  Icons.skip_previous_rounded,
                  color: Colors.white,
                )),
            IconButton(
                onPressed: () {
                  player.seekBy(const Duration(seconds: -10));
                },
                icon: Icon(
                  Icons.fast_rewind_rounded,
                  color: Colors.white,
                )),
            Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(101),
                  color: Color.fromARGB(255, 255, 255, 255)),
              child: IconButton(
                // splashColor: Colors.lightGreenAccent,
                iconSize: 70,
                onPressed: () => _handleOnPress(),
                icon: AnimatedIcon(
                    color: Color.fromARGB(255, 0, 0, 0),
                    size: 50,
                    icon: AnimatedIcons.play_pause,
                    progress: _animationController),
              ),
            ),
            IconButton(
                onPressed: () {
                  player.seekBy(const Duration(seconds: 10));
                },
                icon: Icon(
                  Icons.fast_forward_rounded,
                  color: Colors.white,
                )),
            IconButton(
                iconSize: 40,
                onPressed: () {},
                icon: Icon(
                  Icons.skip_next_rounded,
                  color: Colors.white,
                )),
            SizedBox(
              width: 40,
            ),
          ],
        ),
      ],
    );
  }

  void _handleOnPress() {
    setState(() {
      isPlaying = !isPlaying;

      if (isPlaying) {
        _animationController.forward();
        player.play();
      } else {
        _animationController.reverse();
        player.pause();
      }
    });
  }
}
