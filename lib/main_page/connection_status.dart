import 'dart:developer' as developer;

import 'package:durge/config/durge_preferences.dart';
import 'package:durge/surge_host.dart';
import 'package:flutter/material.dart';

var prefs = Prefs();
List<SurgeHost> surgeHosts;

class ConnectionStatus extends StatefulWidget {
  const ConnectionStatus();

  @override
  State createState() => _SelectConnectionStatusState();
}


class _HostList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false, title: Text("Hosts")),
      body: ListView.builder(
        itemCount: 0,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(surgeHosts[index].name),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showCreateDialog(context);
        },
        child: const Icon(Icons.add),
        backgroundColor: Theme.of(context).colorScheme.error,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }

  void _showCreateDialog(BuildContext context) {
    _showDialog(
      context: context,
      child: SimpleDialog(
        title: Text("Add New Host"),
        children: [
          ListTile(
            leading: const Text("Name"),
            title: new TextField(
              decoration: new InputDecoration(
                hintText: "Custom Name",
              ),
            ),
          ),
          ListTile(
            leading: const Text("Host"),
            title: new TextField(
              decoration: new InputDecoration(
                hintText: "Host",
              ),
            ),
          ),
          ListTile(
            leading: const Text("Port"),
            title: new TextField(
              decoration: new InputDecoration(
                hintText: "Port",
              ),
            ),
          ),
          ListTile(
            leading: const Text("API Key"),
            title: new TextField(
              decoration: new InputDecoration(
                hintText: "API Key",
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showDialog({BuildContext context, Widget child}) async {
    final value = await showDialog(
      context: context,
      builder: (context) => child,
    );
  }
}

class _SelectConnectionStatusState extends State<ConnectionStatus> {
  String name = "";

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
    prefs.listSurgeHosts().then((hosts) {
      developer.log(hosts.toString(), name: "surge hosts");
      surgeHosts = hosts;
      if (surgeHosts.length > 0) {
        name = surgeHosts[0].name;
      }
    });
    developer.log("fuck");
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("Status"),
      trailing: FlatButton.icon(
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
    );
  }
}
