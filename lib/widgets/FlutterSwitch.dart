import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class CustomSwitch extends StatefulWidget {
  const CustomSwitch({super.key});

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  bool status = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlutterSwitch(
        width: 100.0,
        height: 55.0,
        toggleSize: 45.0,
        value: status,
        borderRadius: 30.0,
        padding: 2.0,
        toggleColor: Color.fromRGBO(225, 225, 225, 1),
        switchBorder: Border.all(
          color: Color.fromRGBO(2, 107, 206, 1),
          width: 6.0,
        ),
        toggleBorder: Border.all(
          color: Color.fromRGBO(2, 107, 206, 1),
          width: 5.0,
        ),
        activeColor: Color.fromRGBO(51, 226, 255, 1),
        inactiveColor: Colors.black38,
        onToggle: (val) {
          setState(() {
            status = val;
          });
        },
      ),
    );
  }
}
