import 'package:durge/commons/common_panel.dart';
import 'package:durge/config/durge_meta.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContactPanel extends StatelessWidget {
  final TextStyle _titleStyle = TextStyle(color: Colors.white);
  final TextStyle _valueStyle = TextStyle(color: Colors.white54);

  @override
  Widget build(BuildContext context) {
    return CommonPanel(
      title: "Contact",
      child: Column(
        children: [
          buildItem(Icons.public, "Homepage", DurgeMeta.contact["homepage"]),
          buildItem(Icons.email, "Email", DurgeMeta.contact["email"]),
          buildItem(FontAwesomeIcons.githubAlt, "GitHub", DurgeMeta.contact["github"]),
          buildItem(FontAwesomeIcons.twitter, "Twitter", DurgeMeta.contact["twitter"]),
          buildItem(FontAwesomeIcons.telegramPlane, "Telegram", DurgeMeta.contact["telegram"]),
        ],
      ),
    );
  }

  ListTile buildItem(IconData icon, String header, String value) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(header, style: _titleStyle),
      trailing: Text(value, style: _valueStyle),
    );
  }
}
