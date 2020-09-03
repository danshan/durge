import 'package:durge/config/preferences_utils.dart';
import 'package:durge/config/surge_utils.dart';
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
  SurgeHost _surgeHost = SurgeHost(selected: true);

  final _formKey = GlobalKey<FormState>();

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
    return Prefs.addSurgeHost(_surgeHost);
  }

  Form _buildForm() {
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          TextFormField(
            decoration:
                InputDecoration(labelText: "Name", hintText: "Custom Name"),
            onChanged: (value) => setState(() => _surgeHost.name = value),
            validator: (value) {
              if (value.isEmpty) {
                return "Name should not be empty";
              }
              return null;
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: "Host", hintText: "Host"),
            onChanged: (value) => setState(() => _surgeHost.host = value),
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
            onChanged: (value) => setState(() => _surgeHost.port = int.parse(value)),
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
            onChanged: (value) => setState(() => _surgeHost.apiKey = value),
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
                  Surge.getOutboundMode(_surgeHost).then((value) {
                    _saveSurgeHost().then((value) => Navigator.pop(context));
                  });

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
