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
        body: Row(
          children: [
            Column(
              children: [
                Text("Status"),
                Text("System Proxy"),
                Text("Enhanced Mode"),
              ],
            )
          ],
        ));
  }
}
