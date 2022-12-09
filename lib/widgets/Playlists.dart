import 'package:flutter/material.dart';

class PlayslistSongs1 extends StatefulWidget {
  const PlayslistSongs1({super.key});

  @override
  State<PlayslistSongs1> createState() => _PlayslistSongsState();
}

class _PlayslistSongsState extends State<PlayslistSongs1> {
  bool toggle = false;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: 50,
        padding: EdgeInsets.only(top: 10),
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.asset(
                        'assets/images/The_Weeknd_-_After_Hours.png'),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.delete_forever_outlined,
                            color: Colors.white,
                            size: 25,
                          )),
                      IconButton(
                          icon: toggle
                              ? Icon(
                                  Icons.favorite_border,
                                  color: Colors.white,
                                )
                              : Icon(
                                  Icons.favorite,
                                  color: Colors.white,
                                ),
                          onPressed: () {
                            setState(() {
                              // Here we changing the icon.
                              toggle = !toggle;
                            });
                          }),
                    ],
                  ),
                  subtitle: Text(
                    "The Weeknd",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Inter",
                    ),
                  ),
                  title: Text(
                    "Save Your Tears",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.bold),
                  )),
              SizedBox(
                height: 15,
              )
            ],
          );
        });
  }
}
