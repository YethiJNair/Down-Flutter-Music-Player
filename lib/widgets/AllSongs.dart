import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:down/colors/colors.dart';
import 'package:down/model/dbfunctions.dart';
import 'package:down/model/mostPlayed.dart';
import 'package:down/model/recentlyPlayed.dart';
import 'package:down/model/songModel.dart';
import 'package:down/screens/now_playing.dart';
import 'package:down/screens/recent_played.dart';
import 'package:down/widgets/playlists/addToPlaylist.dart';
import 'package:down/widgets/addTofavourite.dart';
import 'package:on_audio_query/on_audio_query.dart';

class allSongsScreen extends StatefulWidget {
  allSongsScreen({super.key});

  @override
  State<allSongsScreen> createState() => _allSongsScreenState();
}

class _allSongsScreenState extends State<allSongsScreen> {
  late bool isplaying;
  late bool playerVisibility;

  final box = SongBox.getInstance();
  List<Audio> convertAudios = [];
  final AssetsAudioPlayer _audioPlayer = AssetsAudioPlayer.withId('0');

  @override
  void initState() {
    // TODO: implement initState
    List<Songs> dbsongs = box.values.toList();
    for (var item in dbsongs) {
      convertAudios.add(Audio.file(item.songurl!,
          metas: Metas(
              title: item.songname,
              artist: item.artist,
              id: item.id.toString())));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return ValueListenableBuilder<Box<Songs>>(
        valueListenable: box.listenable(),
        builder: ((context, Box<Songs> allsongbox, child) {
          List<Songs> allDbdongs = allsongbox.values.toList();
          List<MostPlayed> allmostplayedsongs = mostplayedsongs.values.toList();
          if (allDbdongs.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (allDbdongs == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: allDbdongs.length,
              itemBuilder: (context, index) {
                bool fav = true;
                Songs songs = allDbdongs[index];
                MostPlayed MPsongs = allmostplayedsongs[index];
                // MostPlayed MPsongs = allmostplayedsongs[index];
                RecentlyPlayed rsongs;
                return Padding(
                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 2),
                  child: ListTile(
                    onTap: (() {
                      rsongs = RecentlyPlayed(
                          songname: songs.songname,
                          id: songs.id,
                          artist: songs.artist,
                          duration: songs.duration,
                          songurl: songs.songurl);

                      updateRecentPlayed(rsongs, index);

                      updatePlayedSongsCount(MPsongs, index);
                      // updatePlayedSongsCount(MPsongs, index);
                      _audioPlayer.open(
                          Playlist(audios: convertAudios, startIndex: index),
                          showNotification: notificationStatus,
                          headPhoneStrategy:
                              HeadPhoneStrategy.pauseOnUnplugPlayOnPlug,
                          loopMode: LoopMode.playlist);
                      setState(() {});
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => NowPlaying2())));
                    }),
                    leading: QueryArtworkWidget(
                      artworkHeight: 55,
                      artworkWidth: 55,
                      id: songs.id!,
                      type: ArtworkType.AUDIO,
                      artworkFit: BoxFit.cover,
                      artworkQuality: FilterQuality.high,
                      size: 2000,
                      quality: 100,
                      artworkBorder: BorderRadius.circular(10),
                      nullArtworkWidget: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        child: Image.asset(
                          'assets/images/music.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    subtitle: Text(
                      songs.artist!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontFamily: "Inter",
                      ),
                    ),
                    title: Text(
                      songs.songname!,
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
        }));
  }
}
