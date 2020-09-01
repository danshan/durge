import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as developer;

import '../surge_host.dart';

class Prefs {
  final String _KEY_SURGE_HOSTS = "surge.hosts";

  Future<List<SurgeHost>> listSurgeHosts() async {
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

    developer.log("$hosts.length", name: "prefs");
    return hosts;
  }

  List<SurgeHost> listSurgeHostsSync() {
    Future<List<SurgeHost>> future = listSurgeHosts();
    future.then((hosts) {
      return hosts;
    });
  }

  Future<SurgeHost> currentSurgeHostsSync() async {
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

  void addSurgeHost(SurgeHost host) async {
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
  }

  void delSurgeHost(SurgeHost host) async {
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
