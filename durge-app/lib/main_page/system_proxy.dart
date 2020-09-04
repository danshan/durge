import 'dart:developer' as developer;

import 'package:durge/config/surge_utils.dart';
import 'package:flutter/material.dart';

class SystemProxy extends StatefulWidget {
  @override
  _SwitchSystemProxyState createState() => _SwitchSystemProxyState();
}

class _SwitchSystemProxyState extends State<SystemProxy> {
  Widget _builderFuture(BuildContext context, AsyncSnapshot snapshot) {
    switch (snapshot.connectionState) {
      case ConnectionState.done:
        if (snapshot.hasError) return Text('Error: ${snapshot.error}');
        return _switch(context, snapshot);
      default:
        return Text('Loading ...');
    }
  }

  Widget _switch(BuildContext context, AsyncSnapshot snapshot) {
    bool enabled = snapshot.data;

    return SwitchListTile(
      title: Text("System Proxy"),
      value: enabled,
      onChanged: _changeSwitch,
    );
  }

  void _changeSwitch(bool value) {
    developer.log("change switch [$value]", name: "system proxy");
    setState(() {
//      switchValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: _builderFuture,
//      future: Surge.getSystemProxyEnabled(host),
    );
  }
}
