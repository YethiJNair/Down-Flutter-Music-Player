import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:down/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:down/model/songModel.dart';
import 'package:down/screens/BottomNavbar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

final audioquery = OnAudioQuery();
final box = SongBox.getInstance();

List<SongModel> fetchSongs = [];
List<SongModel> allSongs = [];
List<Audio> fullsongs = [];

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 1)).then((value) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: ((ctx) => BottomNavbar())));
    });
    requestStoragePermission();
  }

  requestStoragePermission() async {
    bool permissionStatus = await audioquery.permissionsStatus();
    if (!permissionStatus) {
      await audioquery.permissionsRequest();

      fetchSongs = await audioquery.querySongs();
      for (var element in fetchSongs) {
        if (element.fileExtension == "mp3") {
          allSongs.add(element);
        }
      }

      for (var element in allSongs) {
        box.add(Songs(
            songname: element.title,
            artist: element.artist,
            duration: element.duration,
            id: element.id,
            songurl: element.uri));
      }
    }
    setState(() {});
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
          backgroundColor: HexColor("#0f1225").withOpacity(0),
          body: SizedBox(
            width: double.infinity,
            child: Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Image(
                    image: AssetImage("assets/logo.jpg"),
                    width: 350,
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
