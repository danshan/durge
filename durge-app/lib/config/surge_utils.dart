import 'package:dio/dio.dart';
import 'package:durge/surge_host.dart';

class Surge {
  static String _buildHttpHost(SurgeHost host, String path) {
    return "http://${host.host}:${host.port}${path}";
  }

  static Map<String, String> _buildHeaders(SurgeHost host) {
    return {"X-Key": host.apiKey, "Content-Type": "application/json"};
  }

  static Future checkConnection(SurgeHost host) async {
    return OutboundMode();
//    return getOutboundMode(host);
  }

  static Future<OutboundMode> getOutboundMode(SurgeHost host) async {
    var url = _buildHttpHost(host, '/v1/outbound');
    var headers = _buildHeaders(host);
    Response<Map> response = await Dio().get<Map>(url, options: Options(headers: headers));

    return OutboundMode.fromJson(response.data);
  }

  static Future<bool> getSystemProxyEnabled(SurgeHost host) async {
    var url = _buildHttpHost(host, '/v1/features/system_proxy');
    var headers = _buildHeaders(host);
    Response<Map> response = await Dio().get<Map>(url, options: Options(headers: headers));
    return response.data["enabled"];
  }

  static Future<void> setSystemProxyEnabled(SurgeHost host, bool enabled) async {
    var url = _buildHttpHost(host, '/v1/features/system_proxy');
    var headers = _buildHeaders(host);
    await Dio().post(url, data: {"enabled", enabled}, options: Options(headers: headers));
  }
}

class OutboundMode {
  OutboundMode({this.mode});

  String mode;

  OutboundMode.fromJson(Map<String, dynamic> json) : mode = json['mode'];

  Map<String, dynamic> toJson() => {'mode': mode};
}
