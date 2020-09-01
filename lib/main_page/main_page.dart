import 'package:durge/main_page/connection_status.dart';
import 'package:durge/main_page/enhanced_mode.dart';
import 'package:durge/main_page/main_page_buttons.dart';
import 'package:durge/main_page/system_proxy.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.settings),
          ),
          title: Text("Durge"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
            )
          ],
        ),
        body: Column(
          children: [
            Column(
              children: [
                ConnectionStatus(),
                SystemProxy(),
                EnhancedMode(),
              ],
            ),
            Center(
              child: MainPageButtons()
            )
          ],
        ));
  }
}
