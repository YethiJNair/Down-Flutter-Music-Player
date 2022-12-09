import 'package:down/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:down/widgets/Cards.dart';
import 'package:down/widgets/FloatingControler.dart';
import 'package:down/widgets/SearchBar.dart';
import 'package:down/widgets/TitleWidget.dart';
import 'package:down/widgets/allSongs.dart';
import 'package:hexcolor/hexcolor.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool mp = false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          // stops: [0.1, 0.5, 0.7, 0.9],
          colors: [gr1, Colors.black],
        ),
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: black.withOpacity(0),
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(height * 0.07),
            child: Container(
                decoration: BoxDecoration(color: black.withOpacity(0)),
                child: Column(
                  children: const [
                    BannerWidget(),
                    // SearchBar(),
                  ],
                )),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Column(
                children: [
                  const Cards(),
                  allSongsScreen(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void toast(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ));
  }
}
