import 'package:durge/commons/common_panel.dart';
import 'package:durge/config/preferences_utils.dart';
import 'package:durge/preferences_page/about_panel.dart';
import 'package:durge/preferences_page/contact_panel.dart';
import 'package:durge/preferences_page/host_panel.dart';
import 'package:durge/preferences_page/surge_hosts_page.dart';
import 'package:flutter/material.dart';

import '../surge_host.dart';

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
