class SurgeHost {
  SurgeHost({this.name, this.host, this.port, this.password, this.selected});

  final String name;
  final String host;
  final int port;
  final String password;
  final bool selected;

  SurgeHost.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        host = json['host'],
        port = json['port'],
        password = json['password'],
        selected = json['selected'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'host': host,
        'port': port,
        'password': password,
        'selected': selected,
      };
}
