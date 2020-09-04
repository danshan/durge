import 'dart:convert';
import 'dart:developer' as developer;

import 'package:durge/surge_host.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// tools for durge preferences
class PrefsUtils {
  static final String _KEY_SURGE_HOSTS = "surge.hosts";

  /// list surge host list
  static Future<List<SurgeHost>> listSurgeHosts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> hostStrs = prefs.getStringList(_KEY_SURGE_HOSTS);
    List<SurgeHost> hosts = [];
    if (hostStrs == null) {
      developer.log("surge hosts is empty", name: "prefs");
      return hosts;
    }

    for (String str in hostStrs) {
      Map hostMap = jsonDecode(str);
      var host = SurgeHost.fromJson(hostMap);
      hosts.add(host);
    }

    developer.log("found ${hosts.length} surge hosts: [$hosts]", name: "prefs");
    return hosts;
  }

  static Future<SurgeHost> setSelectSurgeHost(SurgeHost host) async {
    List<SurgeHost> hosts = await listSurgeHosts();
    if (hosts == null || hosts.length == 0) {
      return null;
    }

    bool foundExists = false;
    for (SurgeHost exists in hosts) {
      if (exists.name == host.name) {
        foundExists = true;
        exists.selected = true;
      } else {
        exists.selected = false;
      }
    }

    if (foundExists) {
      await updateSurgeHosts(hosts);
      developer.log("select host [$host]", name: "prefs");
    }

    return host;
  }

  /// add surge host to host list
  static Future<List<SurgeHost>> addSurgeHost(SurgeHost host) async {
    List<SurgeHost> surgeHosts = await listSurgeHosts();

    for (SurgeHost exists in surgeHosts) {
      if (exists.name == host.name) {
        throw ("Name [${exists.name}], already exists.");
      }
      exists.selected = false;
    }

    host.selected = true;
    surgeHosts.add(host);
    await updateSurgeHosts(surgeHosts);
    developer.log("add host [$host]", name: "prefs");
    return surgeHosts;
  }

  /// update surge host
  static Future<List<SurgeHost>> updateSurgeHost(SurgeHost host) async {}

  /// save surge hosts
  static Future<List<SurgeHost>> updateSurgeHosts(List<SurgeHost> hosts) async {
    List<String> hostStrs = [];
    for (SurgeHost surgeHost in hosts) {
      hostStrs.add(jsonEncode(surgeHost));
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(_KEY_SURGE_HOSTS, hostStrs);
  }

  /// delete surge host
  static Future<List<SurgeHost>> delSurgeHost(SurgeHost host) async {
    List<SurgeHost> currentHosts = await listSurgeHosts();
    List<SurgeHost> afterDelete = [];

    bool removeSelected = false;
    for (SurgeHost exists in currentHosts) {
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

    await updateSurgeHosts(afterDelete);
    developer.log("delete host [$host]", name: "prefs");
    return afterDelete;
  }
}
