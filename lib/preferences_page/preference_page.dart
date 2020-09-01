import 'package:flutter/material.dart';

class PreferencesPage extends StatelessWidget {
  PrefPanel contactPanel = PrefPanel(
    header: "Contact",
    isExpanded: true,
    items: [
      PrefItem(
          icon: Icons.public,
          header: "Homepage",
          value: "https://www.shanhh.com"),
      PrefItem(
          icon: Icons.email,
          header: "Email",
          value: "i@shanhh.com"),
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
            buildPanel(contactPanel),
          ],
        ));
  }

  List<ListTile> buildItem(List<PrefItem> items) {
    return items.map((PrefItem item) {
      return ListTile(
        leading: Icon(item.icon, color: Colors.white,),
        title: Text(item.header, style: TextStyle(color: Colors.white),),
        trailing: Text(item.value),
      );
    }).toList();
  }

  buildPanel(PrefPanel panel) {
    return Column(
      children: [
        Text(panel.header, style: TextStyle(color: Colors.grey),),
        Container(
          padding: const EdgeInsets.all(0),
          margin: const EdgeInsets.symmetric(horizontal: 20.0),
          decoration: BoxDecoration(color: Colors.grey, borderRadius: new BorderRadius.circular(5.0)),
          child: Column(
            children: buildItem(panel.items),
          ),
        )
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
