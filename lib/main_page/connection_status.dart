import 'dart:developer' as developer;

import 'package:flutter/material.dart';

class ConnectionStatus extends StatefulWidget {
  @override
  _SelectConnectionStatusState createState() => _SelectConnectionStatusState();
}

class SurgeHost {
  SurgeHost({this.name, this.host, this.port, this.password});

  final String name;
  final String host;
  final int port;
  final String password;
}

var _SURGE_HOSTS = [
  SurgeHost(
      name: "macbook-pro", host: "127.0.0.1", port: 6100, password: "pwd"),
  SurgeHost(name: "esxi-macos", host: "127.0.0.1", port: 6100, password: "pwd")
];

class _HostList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: Column(
        children: [
          Container(
            height: 70,
            child: Center(
              child: Text(
                "Hosts",
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const Divider(thickness: 1),
          Expanded(
            child: ListView.builder(
              itemCount: _SURGE_HOSTS.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_SURGE_HOSTS[index].name),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _SelectConnectionStatusState extends State<ConnectionStatus> {
  String name;
  VoidCallback _showBottomSheetCallback;

  void _showHostList(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return _HostList();
      },
    ).whenComplete(() {
      _changeHost(name);
    });
  }

  void _changeHost(void name) {}

  @override
  void initState() {
    super.initState();
    name = _SURGE_HOSTS[0].name;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("Status"),
        Spacer(),
        FlatButton.icon(
          icon: Icon(
            Icons.lens,
            size: 10,
            color: Colors.green,
          ),
          label: Text(name),
          onPressed: () {
            _showHostList(context);
          },
        ),
      ],
    );
  }
}
