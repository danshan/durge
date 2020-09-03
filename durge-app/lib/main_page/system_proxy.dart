import 'package:flutter/material.dart';
import 'dart:developer' as developer;

class SystemProxy extends StatefulWidget {
  @override
  _SwitchSystemProxyState createState() => _SwitchSystemProxyState();
}

class _SwitchSystemProxyState extends State<SystemProxy> {
  bool switchValue = false;

  void _changeSwitch(bool value) {
    developer.log("change switch [$value]", name: "system proxy");
    setState(() {
      switchValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text("System Proxy"),
      value: switchValue,
      onChanged: _changeSwitch,
    );
  }
}
