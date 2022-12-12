import 'package:flutter/material.dart';
import 'package:down/colors/colors.dart';

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
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: "Inter",
                fontSize: 18),
          ),
          trailing: Switch(
            activeTrackColor: Colors.white,
            activeColor: Colors.grey,
            inactiveTrackColor: Colors.grey,
            value: notificationStatus,
            onChanged: (value) {
              setState(() {
                notificationStatus = value;
              });
            },
          ),
        ),
      ],
    );
  }
}
