import 'package:down/colors/colors.dart';
import 'package:down/screens/Settings.dart';
import 'package:flutter/material.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 10, right: 20, top: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "D",
                      style: TextStyle(
                          fontSize: 35,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.bold,
                          color: cyan),
                    ),
                    Text(
                      "own",
                      style: TextStyle(
                          fontSize: 35,
                          color: Colors.white,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                IconButton(
                    iconSize: 30,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Settings(),
                          ));
                    },
                    icon: const Icon(
                      Icons.settings,
                      color: Colors.white,
                    ))
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          )
        ],
      ),
    );
  }
}
