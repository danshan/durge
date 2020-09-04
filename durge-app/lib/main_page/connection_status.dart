import 'package:durge/config/prefs_model.dart';
import 'package:durge/surge_host.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConnectionStatus extends StatefulWidget {
  @override
  _ConnectionStatusState createState() => _ConnectionStatusState();
}

class _ConnectionStatusState extends State<ConnectionStatus> {
  Widget _builderFuture(BuildContext context, AsyncSnapshot snapshot) {
    switch (snapshot.connectionState) {
      case ConnectionState.done:
        if (snapshot.hasError) return Text('Error: ${snapshot.error}');
        return _statusButton(context, snapshot);
      default:
        return Text('Connecting ...');
    }
  }

  Widget _statusButton(BuildContext context, AsyncSnapshot snapshot) {
    SurgeHost host = snapshot.data;
    if (host == null) {
      return Text("No hosts");
    }

    return FlatButton.icon(
      icon: Icon(
        Icons.lens,
        size: 10,
        color: Colors.grey,
      ),
      label: Text(host.name),
      onPressed: () {
        _showHostList(context);
      },
    );
  }

  void _showHostList(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return _HostList();
      },
    );
  }

  void _changeHost(void name) {}

  @override
  Widget build(BuildContext context) {
    return Consumer<PrefsModel>(
      builder: (context, prefs, child) {
        return ListTile(
          title: Text("Status"),
          trailing: FutureBuilder(
            builder: _builderFuture,
            future: prefs.getSelectedSurgeHost(),
          ),
        );
      },
    );
  }
}

class _HostList extends StatefulWidget {
  @override
  _HostListState createState() {
    return _HostListState();
  }
}

class _HostListState extends State<_HostList> {
  Widget _builderFuture(BuildContext context, AsyncSnapshot snapshot) {
    switch (snapshot.connectionState) {
      case ConnectionState.done:
        if (snapshot.hasError) return Text('Error: ${snapshot.error}');
        return _buildHostList(context, snapshot);
      default:
        return Text('Connecting ...');
    }
  }

  Widget _buildHostList(BuildContext context, AsyncSnapshot snapshot) {
    List<SurgeHost> hosts = snapshot.data;
    return ListView.builder(
      itemCount: hosts.length,
      itemBuilder: (context, index) {
        SurgeHost host = hosts[index];
        return Consumer<PrefsModel>(
          builder: (context, prefs, child) {
            return ListTile(
              title: Text(host.name),
              subtitle: Text("${host.host}:${host.port} ${host.apiKey}"),
              onTap: () {
                setState(() {
                  prefs.setSelectedSurgeHost(host);
                  Navigator.pop(context);
                });
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false, title: Text("Hosts")),
      body: Consumer<PrefsModel>(
        builder: (context, prefs, child) {
          return FutureBuilder(
            builder: _builderFuture,
            future: prefs.listSurgeHosts(),
          );
        },
      ),
    );
  }
}
