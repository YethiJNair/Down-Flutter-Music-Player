import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class NotificationList extends StatefulWidget {
  const NotificationList({super.key, required this.title, required this.logo});
  final String title;
  final IconData logo;

  @override
  State<NotificationList> createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  bool status = false;
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
          trailing: Container(
            width: 40,
            height: 30,
            child: FlutterSwitch(
              activeColor: Colors.white,
              toggleColor: Colors.black,
              width: 55.0,
              height: 25.0,
              valueFontSize: 12.0,
              toggleSize: 18.0,
              value: status,
              onToggle: (val) {
                setState(() {
                  status = val;
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
