import 'package:durge/config/prefs_utils.dart';
import 'package:durge/surge_host.dart';
import 'package:flutter/material.dart';

class PrefsModel extends ChangeNotifier {
  List<SurgeHost> _hosts;

  Future<List<SurgeHost>> listSurgeHosts() async {
    if (_hosts == null) {
      _hosts = await PrefsUtils.listSurgeHosts();
    }
    return _hosts;
  }

  Future<List<SurgeHost>> addSurgeHost(SurgeHost host) async {
    _hosts = await PrefsUtils.addSurgeHost(host);
    notifyListeners();
    return _hosts;
  }

  Future<List<SurgeHost>> delSurgeHost(SurgeHost host) async {
    _hosts = await PrefsUtils.delSurgeHost(host);
    notifyListeners();
    return _hosts;
  }

  /// get selected surge host
  Future<SurgeHost> getSelectedSurgeHost() async {
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

  Future<SurgeHost> setSelectedSurgeHost(SurgeHost host) async {
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
      await PrefsUtils.updateSurgeHosts(hosts);
      notifyListeners();
    }

    return host;
  }
}
