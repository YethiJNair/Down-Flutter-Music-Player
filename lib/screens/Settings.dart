import 'package:down/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:down/widgets/SettingList2.dart';
import 'package:down/widgets/SettingsList.dart';
import 'package:hexcolor/hexcolor.dart';

import '../widgets/FloatingControler.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          // stops: [0.1, 0.5, 0.7, 0.9],
          colors: [gr1, Colors.black],
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: trans,
          elevation: 0,
          title: Row(
            children: [
              Text(
                "S",
                style: TextStyle(
                    fontSize: 28,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.bold,
                    color: cyan),
              ),
              const Text(
                "ettings",
                style: TextStyle(
                    fontSize: 28,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        backgroundColor: trans,
        body: SettingList2(),
        // bottomSheet: FloatingController(),
      ),
    );
  }
}
