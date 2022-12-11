// Sigleton Patter
import 'dart:io';
import 'package:path/path.dart';
import 'package:qrscanner/models/models.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    // Path where dataBase is store. this path is diferent for each device.
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'ScansDb.db');

    //Create DataBase
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('''
          CREATE TABLE Scans(
            id INTEGER PRIMARY KEY,
            type TEXT,
            value TEXT
          )''');
    });
  }

  Future<int> newScan(ScanModel newScan) async {
    final db = await database;
    final queryRes = await db.insert('Scans', newScan.toJson());
    return queryRes;
  }

  Future<ScanModel?> getScanById(int id) async {
    final db = await database;
    final queryRes = await db.query('Scans', where: 'id=?', whereArgs: [id]);

    return queryRes.isNotEmpty ? ScanModel.fromJson(queryRes[0]) : null;
  }

  Future<List<ScanModel>> getAllScan() async {
    final db = await database;
    final queryRes = await db.query('Scans');

    return queryRes.isNotEmpty
        ? queryRes.map((s) => ScanModel.fromJson(s)).toList()
        : [];
  }

  Future<List<ScanModel>> getScansByType(String type) async {
    final db = await database;
    final queryRes =
        await db.query('Scans', where: 'type=?', whereArgs: [type]);

    return queryRes.isNotEmpty
        ? queryRes.map((s) => ScanModel.fromJson(s)).toList()
        : [];
  }

  Future<int> updateScan(ScanModel newScan) async {
    final db = await database;
    final queryRes = await db.update('Scans', newScan.toJson(),
        where: 'id = ?', whereArgs: [newScan.id]);
    return queryRes;
  }

  Future<int> deleteScan(int id) async {
    final db = await database;
    final queryRes = await db.delete('Scans', where: 'id=?', whereArgs: [id]);
    return queryRes;
  }

  Future<int> deleteAllScans() async {
    final db = await database;
    final queryRes = await db.delete('Scans');
    return queryRes;
  }
}
