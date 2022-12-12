import 'package:down/Colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:down/widgets/SettingsList.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
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
        appBar: AppBar(
          backgroundColor: trans,
          elevation: 0,
          title: Row(
            children: const [
              Text(
                "Settings",
                style: TextStyle(
                    fontSize: 28,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        backgroundColor: trans,
        body: SettingsList(),
      ),
    );
  }
}
