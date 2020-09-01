import 'package:durge/config/durge_preferences.dart';
import 'package:durge/surge_host.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SurgeHostsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<SurgeHost> hosts = Prefs().listSurgeHostsSync();

    return Scaffold(
      appBar: AppBar(
        title: Text("Hosts"),
      ),
      body: Container(
        padding: const EdgeInsets.all(0),
        margin: const EdgeInsets.symmetric(horizontal: 20.0),
        child: hosts == null
            ? null
            : ListView.builder(
                itemCount: hosts.length,
                itemBuilder: (context, index) {
                  final host = hosts[index];

                  return Dismissible(
                    key: Key(host.name),
                    onDismissed: (direction) {
                      hosts.removeAt(index);
                      Scaffold.of(context).showSnackBar(
                          SnackBar(content: Text("${host.name} removed")));
                    },
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
//          _showCreateDialog(context);
        },
        child: const Icon(Icons.add),
        backgroundColor: Theme.of(context).colorScheme.error,
      ),
    );
  }
}
