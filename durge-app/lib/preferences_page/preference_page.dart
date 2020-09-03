import 'package:durge/preferences_page/about_panel.dart';
import 'package:durge/preferences_page/contact_panel.dart';
import 'package:durge/preferences_page/host_panel.dart';
import 'package:flutter/material.dart';

class PreferencesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Preferences")),
        body: Column(
          children: [
            HostPanel(),
            ContactPanel(),
            AboutPanel(),
          ],
        ));
  }

}
