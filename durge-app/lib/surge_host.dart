import 'package:flutter/cupertino.dart';

class SurgeHost {
  SurgeHost({
    @required this.name,
    @required this.host,
    @required this.port,
    @required this.apiKey,
    @required this.selected,
  });

  String name;
  String host;
  int port;
  String apiKey;
  bool selected;

  SurgeHost.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        host = json['host'],
        port = json['port'],
        apiKey = json['apiKey'],
        selected = json['selected'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'host': host,
        'port': port,
        'apiKey': apiKey,
        'selected': selected,
      };

  @override
  String toString() {
    return "SurgeHost(name: $name, host: $host, port: $port, selected: $selected)";
  }
}
