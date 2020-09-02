import 'package:durge/config/durge_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../surge_host.dart';

class SurgeHostModifyPage extends StatefulWidget {
  @override
  _SurgeHostState createState() {
    return _SurgeHostState();
  }
}

class _SurgeHostState extends State<SurgeHostModifyPage> {
  String name;
  String host;
  int port;
  String apiKey;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Edit Host"),
        ),
        body: Container(
          padding: const EdgeInsets.all(0),
          margin: const EdgeInsets.symmetric(horizontal: 20.0),
          child: _buildForm(),
        ));
  }

  Future<void> _saveSurgeHost() async{
    return Prefs.addSurgeHost(SurgeHost(
      name: name,
      host: host,
      port: port,
      apiKey: apiKey,
      selected: true
    ));
  }

  Form _buildForm() {
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          TextFormField(
            decoration:
                InputDecoration(labelText: "Name", hintText: "Custom Name"),
            onChanged: (value) => setState(() => this.name = value),
            validator: (value) {
              if (value.isEmpty) {
                return "Name should not be empty";
              }
              return null;
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: "Host", hintText: "Host"),
            onChanged: (value) => setState(() => this.host = value),
            validator: (value) {
              if (value.isEmpty) {
                return "Host should not be empty";
              }
              return null;
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: "Port", hintText: "Port"),
            keyboardType: TextInputType.number,
            onChanged: (value) => setState(() => this.port = int.parse(value)),
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            validator: (value) {
              if (value.isEmpty) {
                return "Port should not be empty";
              }
              return null;
            },
          ),
          TextFormField(
            decoration:
                InputDecoration(labelText: "API Key", hintText: "API Key"),
            onChanged: (value) => setState(() => this.apiKey = value),
            validator: (value) {
              if (value.isEmpty) {
                return "API key should not be empty";
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  _saveSurgeHost().then((value) => Navigator.pop(context));
                }
              },
              child: Text('Save'),
            ),
          ),
        ],
      ),
    );
  }
}
