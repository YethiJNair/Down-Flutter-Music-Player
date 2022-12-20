import 'package:flutter/material.dart';

class appbarRecentPlayed extends StatelessWidget {
  const appbarRecentPlayed({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(10),
      child: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          children: const [
            Text(
              "Recent Played.",
              style: TextStyle(
                  fontFamily: "Inter",
                  fontSize: 35,
                  fontWeight: FontWeight.w900,
                  color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
