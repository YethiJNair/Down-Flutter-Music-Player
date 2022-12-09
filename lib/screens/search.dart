import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:down/screens/nowPlaying2.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../colors/colors.dart';
import '../model/songModel.dart';

class screenSearch extends StatefulWidget {
  const screenSearch({super.key});

  @override
  State<screenSearch> createState() => _screenSearchState();
}

class _screenSearchState extends State<screenSearch> {
  final TextEditingController searchController = TextEditingController();
  final box = SongBox.getInstance();
  late List<Songs> dbSongs;
  final AssetsAudioPlayer _audioPlayer = AssetsAudioPlayer.withId('0');
  List<Audio> allSongs = [];

  @override
  void initState() {
    dbSongs = box.values.toList();

    super.initState();
  }

  late List<Songs> another = List.from(dbSongs);
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
      decoration:  BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          // stops: [0.1, 0.5, 0.7, 0.9],
          colors: [gr1, Colors.black],
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: trans,
          title: searchbar(context),
          centerTitle: true,
        ),
        backgroundColor: trans,
        body: SafeArea(
          child: Column(
            children: [
              // Padding(
              //     padding: const EdgeInsets.all(8), child: searchbar(context)),
              const SizedBox(
                height: 10,
              ),
              Expanded(child: searchHistory())
            ],
          ),
        ),
      ),
    );
  }

  searchbar(BuildContext context) {
    return TextFormField(
      autofocus: true,
      style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
      onTap: () {},
      controller: searchController,
      onChanged: (value) => updateList(value),
      decoration: InputDecoration(
        filled: true,
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: BorderSide(color: Colors.grey, width: 2)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 2)),
        hintText: "  Search ",
        hintStyle: TextStyle(color: Colors.grey),
      ),
    );
  }

  searchHistory() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: another.isEmpty
          ? const Center(
              child: Text(
              "No Songs Found",
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            ))
          : ListView.builder(
              itemCount: another.length,
              itemBuilder: ((context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: ListTile(
                    onTap: () {
                      _audioPlayer.open(
                          Playlist(audios: allSongs, startIndex: index),
                          showNotification: notificationStatus,
                          headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplug,
                          loopMode: LoopMode.playlist);
                      setState(() {});
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => const NowPlaying2()),
                        ),
                      );
                    },
                    leading: QueryArtworkWidget(
                      artworkHeight: 55,
                      artworkWidth: 55,
                      id: another[index].id!,
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
                      another[index].artist!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontFamily: "Inter",
                      ),
                    ),
                    title: Text(
                      another[index].songname!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Colors.white,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              }),
            ),
    );
  }

  void updateList(String value) {
    setState(() {
      another = dbSongs
          .where((element) =>
              element.songname!.toLowerCase().contains(value.toLowerCase()))
          .toList();
      allSongs.clear();
      for (var item in another) {
        allSongs.add(
          Audio.file(
            item.songurl.toString(),
            metas: Metas(
              artist: item.artist,
              title: item.songname,
              id: item.id.toString(),
            ),
          ),
        );
      }
    });
  }
}
