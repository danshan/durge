import 'dart:convert';
import 'dart:developer' as developer;

import 'package:durge/surge_host.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  static Future<void> addSurgeHost(SurgeHost host) async {
    List<SurgeHost> surgeHosts = await listSurgeHosts();

    for (SurgeHost exists in surgeHosts) {
      if (exists.name == host.name) {
        throw ("Name already exists.");
      }
      exists.selected = false;
    }

    host.selected = true;
    surgeHosts.add(host);
    List<String> hostStrs = List();
    for (SurgeHost surgeHost in surgeHosts) {
      hostStrs.add(jsonEncode(surgeHost));
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(_KEY_SURGE_HOSTS, hostStrs);
    developer.log("save surge host $host", name: "prefs");
  }

  static Future<void> updateSurgeHost(SurgeHost host) async {}

  static void delSurgeHost(SurgeHost host) async {
    List<SurgeHost> surgeHosts = await listSurgeHosts();
    List<SurgeHost> afterDelete = List();

    bool removeSelected = false;
    for (SurgeHost exists in surgeHosts) {
      if (exists.name == host.name) {
        removeSelected = exists.selected;
        continue;
      } else {
        afterDelete.add(exists);
      }
    }
    if (removeSelected && afterDelete.length > 0) {
      afterDelete[0].selected = true; // set the first host as selected
    }

    List<String> hostStrs = List();
    afterDelete.map((item) => hostStrs.add(jsonEncode(item)));

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(_KEY_SURGE_HOSTS, hostStrs);
    developer.log("delete surge host $host", name: "prefs");
  }
}
