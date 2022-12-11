import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qrscanner/providers/db_provider.dart';

import '../models/models.dart';

class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scans = [];
  String defaultTypeScan = 'http';

  Future<ScanModel> newScan(String value) async {
    final newScan = ScanModel(value: value);
    final id = await DBProvider.db.newScan(newScan);

    newScan.id = id;

    if (defaultTypeScan == newScan.type) {
      scans.add(newScan);
      notifyListeners();
    }
    return newScan;
  }

  loadScans() async {
    final queryScans = await DBProvider.db.getAllScan();
    scans = [...queryScans];
    notifyListeners();
  }

  loadScansByType(String type) async {
    final queryScans = await DBProvider.db.getScansByType(type);
    scans = [...queryScans];
    notifyListeners();
  }

  deleteAllScans() async {
    await DBProvider.db.deleteAllScans();
    scans = [];
    notifyListeners();
  }

  deleteScansByID(int id) async {
    await DBProvider.db.deleteScan(id);
    loadScansByType(defaultTypeScan);
  }
}
