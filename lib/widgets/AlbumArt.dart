import 'package:down/colors/colors.dart';
import 'package:flutter/material.dart';

class AlbumArt extends StatelessWidget {
  const AlbumArt(
      {super.key,
      required this.imageName,
      required this.head,
      required this.song});
  final String imageName;
  final String head;
  final int song;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0.0),
      child: Stack(
        children: [
          Container(
            height: 240,
            width: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                  image: AssetImage(imageName), fit: BoxFit.cover),
            ),
          ),
          Positioned(
            right: 29,
            top: 180,
            child: Container(
              height: 50,
              width: 150,
              decoration: BoxDecoration(
                  color: orange.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        head,
                        style: TextStyle(
                            fontFamily: "Inter", fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "$song songs",
                        style: TextStyle(
                            fontSize: 11, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  Icon(
                    Icons.play_circle_fill,
                    size: 35,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
