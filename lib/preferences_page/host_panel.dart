
import 'package:durge/commons/common_panel.dart';
import 'package:durge/config/preferences_utils.dart';
import 'package:durge/preferences_page/surge_hosts_page.dart';
import 'package:durge/surge_host.dart';
import 'package:flutter/material.dart';

class HostPanel extends StatefulWidget {
  @override
  _HostPanelState createState() {
    return _HostPanelState();
  }
}

class _HostPanelState extends State<HostPanel> {
  Widget _builderFuture(BuildContext context, AsyncSnapshot snapshot) {
    switch (snapshot.connectionState) {
      case ConnectionState.done:
        if (snapshot.hasError) return Text('Error: ${snapshot.error}');
        return _hostList(context, snapshot);
      default:
        return Text('Loading ...');
    }
  }

  Widget _hostList(BuildContext context, AsyncSnapshot snapshot) {
    SurgeHost host = snapshot.data;

    return Column(
      children: [
        ListTile(
          title: (host == null)
              ? Text("Host list is empty", style: TextStyle(color: Colors.white))
              : Text(host.name, style: TextStyle(color: Colors.white)),
          subtitle: (host == null) ? null : Text("${host.host}", style: TextStyle(color: Colors.white54)),
          trailing: Icon(
            Icons.chevron_right,
            color: Colors.white,
          ),
          onTap: () {
            _navSurgeHostsPage(context);
          },
        )
      ],
    );

  }

  @override
  Widget build(BuildContext context) {
    return CommonPanel(
      title: "Host",
      child: FutureBuilder(
        builder: _builderFuture,
        future: Prefs.currentSurgeHost()
      ),
    );
  }

  void _navSurgeHostsPage(BuildContext context) async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) => SurgeHostsPage()));
    setState(() {});
  }

}