import 'package:durge/config/durge_preferences.dart';
import 'package:durge/preferences_page/surge_hosts_page.dart';
import 'package:flutter/material.dart';

import '../surge_host.dart';

class PreferencesPage extends StatelessWidget {
  PrefPanel contactPanel = PrefPanel(
    header: "Contact",
    isExpanded: true,
    items: [
      PrefItem(
          icon: Icons.public,
          header: "Homepage",
          value: "https://www.shanhh.com"),
      PrefItem(icon: Icons.email, header: "Email", value: "i@shanhh.com"),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Preferences"),
        ),
        body: Column(
          children: [
            buildHostPanel(context),
            buildPropertiesPanel(contactPanel),
          ],
        ));
  }

  List<ListTile> buildItem(List<PrefItem> items) {
    return items.map((PrefItem item) {
      return ListTile(
        leading: Icon(
          item.icon,
          color: Colors.white,
        ),
        title: Text(
          item.header,
          style: TextStyle(color: Colors.white),
        ),
        trailing: Text(item.value),
      );
    }).toList();
  }

  buildPropertiesPanel(PrefPanel panel) {
    return Column(
      children: [
        Text(
          panel.header,
          style: TextStyle(color: Colors.grey),
        ),
        Container(
          padding: const EdgeInsets.all(0),
          margin: const EdgeInsets.symmetric(horizontal: 20.0),
          decoration: BoxDecoration(
              color: Colors.grey, borderRadius: new BorderRadius.circular(5.0)),
          child: Column(
            children: buildItem(panel.items),
          ),
        )
      ],
    );
  }

  buildHostPanel(BuildContext context) {
    List<SurgeHost> hosts = Prefs().listSurgeHostsSync();

    return Column(
      children: [
        Text(
          "Host",
          style: TextStyle(color: Colors.grey),
        ),
        Container(
          padding: const EdgeInsets.all(0),
          margin: const EdgeInsets.symmetric(horizontal: 20.0),
          decoration: BoxDecoration(
              color: Colors.grey, borderRadius: new BorderRadius.circular(5.0)),
          child: Column(
            children: [
              (hosts == null || hosts.length == 0)
                  ? ListTile(
                      title: Text("Host list is empty"),
                      trailing: Icon(Icons.chevron_right),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SurgeHostsPage()),
                        );
                      },
                    )
                  : ListTile(
                      title: Text(hosts[0].name),
                      subtitle: Text("${hosts[0]}"),
                      trailing: Icon(Icons.chevron_right),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SurgeHostsPage()),
                        );
                      },
                    )
            ],
          ),
        ),
      ],
    );
  }
}

class PrefPanel {
  PrefPanel({this.header, this.isExpanded, this.items});

  String header;
  bool isExpanded;
  List<PrefItem> items;
}

class PrefItem {
  PrefItem({this.icon, this.header, this.value});

  IconData icon;
  String header;
  String value;
}
