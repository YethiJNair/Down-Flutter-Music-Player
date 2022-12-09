import 'package:flutter/material.dart';

class FavSongs extends StatelessWidget {
  const FavSongs({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 50,
      padding: EdgeInsets.only(top: 10),
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: [
            ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child:
                      Image.asset('assets/images/The_Weeknd_-_After_Hours.png'),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
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
                          Icons.favorite,
                          color: Colors.white,
                        ))
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
      },
    );
  }
}
