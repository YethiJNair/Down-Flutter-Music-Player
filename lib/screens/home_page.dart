import 'package:down/Colors/colors.dart';
import 'package:down/screens/setting_scrren.dart';
import 'package:flutter/material.dart';
import 'package:down/widgets/cards.dart';
import 'package:down/widgets/TitleWidget.dart';
import 'package:down/widgets/allSongs.dart';

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
          begin: Alignment.topLeft,
          end: Alignment.bottomCenter,
          // stops: [0.1, 0.5, 0.7, 0.9],
          colors: [gr1, Colors.black],
        ),
      ),
      child: Scaffold(
        backgroundColor: trans,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(71),
          child: Container(
              decoration: BoxDecoration(color: trans),
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.039,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const BannerWidget(),
                        SizedBox(
                          width: width * .10,
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const Settings()));
                            },
                            icon: const Icon(
                              Icons.settings,
                              size: 30,
                              color: Colors.white,
                            ))
                      ],
                    ),
                  ),
                ],
              )),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Column(
              children: [const Cards(), allSongsScreen(), endsongs(width)],
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

  SizedBox endsongs(double width) {
    return SizedBox(
        height: 100,
        width: width,
        child: const Align(
          alignment: Alignment.topCenter,
          child: Text("End of songs...",
              style: TextStyle(
                color: Colors.grey,
              )),
        ));
  }
}
