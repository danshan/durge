import 'dart:convert';
import 'dart:developer' as developer;

import 'package:shared_preferences/shared_preferences.dart';

import '../surge_host.dart';

class Prefs {

  static final String _KEY_SURGE_HOSTS = "surge.hosts";

  static Future<List<SurgeHost>> listSurgeHosts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> hostStrs = prefs.getStringList(_KEY_SURGE_HOSTS);
    List<SurgeHost> hosts = List();
    if (hostStrs == null) {
      developer.log("surge hosts is empty", name: "prefs");
      return hosts;
    }

    for (String str in hostStrs) {
      Map hostMap = jsonDecode(str);
      var host = SurgeHost.fromJson(hostMap);
      hosts.add(host);
    }

    developer.log("found ${hosts.length} surge hosts: $hosts", name: "prefs");
    return hosts;
  }

  static Future<SurgeHost> currentSurgeHost() async {
    List<SurgeHost> hosts = await listSurgeHosts();
    if (hosts == null || hosts.length == 0) {
      return null;
    }
    for (SurgeHost host in hosts) {
      if (host.selected) {
        return host;
      }
    }

    return hosts[0];
  }

  static SurgeHost currentSurgeHostSync() {
    SurgeHost host;
    currentSurgeHost().then((value) => host = value);
    return host;
  }

  static Future<void> addSurgeHost(SurgeHost host) async {
    developer.log("save surge host $host", name:"prefs");
    List<SurgeHost> surgeHosts = await listSurgeHosts();

    for (SurgeHost exists in surgeHosts) {
      if (exists.name == host.name) {
        return;
      }
    }

    surgeHosts.add(host);

    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> hostStrs = List();
    for (SurgeHost surgeHost in surgeHosts) {
      hostStrs.add(jsonEncode(surgeHost));
    }
    prefs.setStringList(_KEY_SURGE_HOSTS, hostStrs);
    developer.log("current surge hosts $hostStrs", name:"prefs");

  }

  static void delSurgeHost(SurgeHost host) async {
    List<SurgeHost> surgeHosts = await listSurgeHosts();
    List<String> hostStrs = List();

    for (SurgeHost exists in surgeHosts) {
      if (exists.name == host.name) {
        continue;
      } else {
        hostStrs.add(jsonEncode(exists));
      }
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(_KEY_SURGE_HOSTS, hostStrs);
  }
}
