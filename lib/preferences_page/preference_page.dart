import 'package:durge/commons/common_panel.dart';
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

  PrefPanel aboutPanel = PrefPanel(
    header: "About",
    isExpanded: true,
    items: [
      PrefItem(icon: Icons.widgets, header: "App Version", value: "v0.1.0"),
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
            buildPropertiesPanel(aboutPanel),
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
        trailing: Text(
          item.value,
          style: TextStyle(color: Colors.white54),
        ),
      );
    }).toList();
  }

  buildPropertiesPanel(PrefPanel panel) {
    return CommonPanel(
      title: panel.header,
      child: Column(
        children: buildItem(panel.items),
      ),
    );
  }

  buildHostPanel(BuildContext context) {
    SurgeHost host = Prefs.currentSurgeHostSync();

    var column = Column(
      children: [
        ListTile(
          title: (host == null)
              ? Text("Host list is empty",
                  style: TextStyle(color: Colors.white))
              : Text(host.name, style: TextStyle(color: Colors.white)),
          subtitle: (host == null)
              ? null
              : Text("${host.host}", style: TextStyle(color: Colors.white54)),
          trailing: Icon(
            Icons.chevron_right,
            color: Colors.white,
          ),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SurgeHostsPage()));
          },
        )
      ],
    );

    return CommonPanel(
      title: "Host",
      child: column,
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
