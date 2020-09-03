import 'package:durge/commons/common_panel.dart';
import 'package:durge/config/durge_meta.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AboutPanel extends StatelessWidget {
  final TextStyle _titleStyle = TextStyle(color: Colors.white);
  final TextStyle _valueStyle = TextStyle(color: Colors.white54);

  @override
  Widget build(BuildContext context) {
    return CommonPanel(
      title: "About",
      child: Column(
        children: [
          buildItem(FontAwesomeIcons.appStore, "App Version", DurgeMeta.about["appversion"]),
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
