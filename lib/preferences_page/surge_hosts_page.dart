import 'package:durge/config/durge_preferences.dart';
import 'package:durge/preferences_page/surge_host_modify_page.dart';
import 'package:durge/surge_host.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SurgeHostsPage extends StatefulWidget {
  @override
  _SurgeHostsState createState() {
    return _SurgeHostsState();
  }
}

class _SurgeHostsState extends State<SurgeHostsPage> {

  Widget _buildFuture(BuildContext context, AsyncSnapshot snapshot) {
    switch (snapshot.connectionState) {
      case ConnectionState.none:
        return Text('还没有开始网络请求');
      case ConnectionState.active:
        return Text('ConnectionState.active');
      case ConnectionState.waiting:
        return Center(
          child: CircularProgressIndicator(),
        );
      case ConnectionState.done:
        if (snapshot.hasError) return Text('Error: ${snapshot.error}');
        return _createHostsView(context, snapshot);
      default:
        return null;
    }
  }

  Widget _createHostsView(BuildContext context, AsyncSnapshot snapshot) {
    List hosts = snapshot.data;

    return Container(
      padding: const EdgeInsets.all(0),
      margin: const EdgeInsets.all(20.0),
      child: ListView.builder(
        itemBuilder: (context, index) => _hostBuilder(context, index, hosts),
        itemCount: hosts.length,
      ),
    );
  }

  Widget _hostBuilder(BuildContext context, int index, List<SurgeHost> hosts) {
    final host = hosts[index];

    return Dismissible(
      key: Key(host.name),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        hosts.removeAt(index);
        Prefs.delSurgeHost(host);
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text("${host.name} removed")));
      },
      child: ListTile(
        title: Text(
          host.name,
          style: TextStyle(color: Colors.white),
        ),
        subtitle: Text("${host.host}:${host.port} ${host.apiKey}",
            style: TextStyle(color: Colors.white54)),
        trailing: Icon(
          Icons.chevron_right,
          color: Colors.white,
        ),
        tileColor: Colors.black45,
      ),
      background: Container(
        alignment: AlignmentDirectional.centerEnd,
        color: Colors.red,
        child: Padding(
          padding: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hosts"),
      ),
      body: FutureBuilder(
        builder: _buildFuture,
        future: Prefs.listSurgeHosts(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => SurgeHostModifyPage()));
        },
        child: const Icon(Icons.add),
        backgroundColor: Theme.of(context).colorScheme.error,
      ),
    );
  }
}
