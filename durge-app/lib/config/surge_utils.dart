import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:durge/surge_host.dart';

class Surge {
  static String _buildHttpHost(SurgeHost host, String path) {
    return "http://${host.host}:${host.port}${path}";
  }

  static Map<String, String> _buildHeaders(SurgeHost host) {
    return {"X-Key": host.apiKey, "Content-Type": "application/json"};
  }

  static Future<OutboundMode> getOutboundMode(SurgeHost host) async {
    var url = _buildHttpHost(host, '/v1/outbound');
    var headers = _buildHeaders(host);
    var response = await Dio().get(url, options: Options(headers: headers));
    print(response.data);

    Map hostMap = jsonDecode(response.data.toString());
    return OutboundMode.fromJson(hostMap);
  }
}

class OutboundMode {
  String mode;

  OutboundMode.fromJson(Map<String, dynamic> json) : mode = json['mode'];

  Map<String, dynamic> toJson() => {'mode': mode};
}
