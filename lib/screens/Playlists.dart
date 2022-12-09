import 'package:flutter/material.dart';
import 'package:down/widgets/FloatingControler.dart';
import 'package:down/widgets/Playlists.dart';
import 'package:down/widgets/playlists/playlistScreen.dart';
import 'package:hexcolor/hexcolor.dart';

class Playlists extends StatelessWidget {
  const Playlists({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: playLists(),
    );
  }
}
