import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class SettingsList extends StatefulWidget {
  SettingsList({super.key, required this.title, required this.logo});
  final String title;
  final IconData logo;

  @override
  State<SettingsList> createState() => _SettingsListState();
}

class _SettingsListState extends State<SettingsList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: Icon(
            widget.logo,
            size: 35,
            color: Colors.white,
          ),
          title: Text(
            widget.title,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: "Inter",
                fontSize: 18),
          ),
        ),
      ],
    );
  }
}
