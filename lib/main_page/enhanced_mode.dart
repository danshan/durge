import 'package:flutter/material.dart';
import 'dart:developer' as developer;


class EnhancedMode extends StatefulWidget {
  @override
  _SwitchEnhancedModeState createState() => _SwitchEnhancedModeState();
}

class _SwitchEnhancedModeState extends State<EnhancedMode> {
  bool switchValue = false;

  void _changeSwitch(bool value) {
    developer.log("change switch [$value]", name: "enhanced mode");
    setState(() {
      switchValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("Enhanced Mode"),
        Spacer(),
        Switch(
          value: switchValue,
          onChanged: _changeSwitch,
        ),
      ],
    );
  }
}
