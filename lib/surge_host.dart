class SurgeHost {
  SurgeHost({this.name, this.host, this.port, this.password});

  final String name;
  final String host;
  final int port;
  final String password;

  SurgeHost.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        host = json['host'],
        port = json['port'],
        password = json['password'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'host': host,
        'port': port,
        'password': password,
      };
}
