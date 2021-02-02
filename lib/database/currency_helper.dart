import 'package:convertCoin/models/currency_info.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

final String tableName = 'currency';
final String columnId = 'id';
final String columnToCurrency = 'tocurrency';
final String columnFromCurrency = 'fromcurrency';
final String columnToText = 'totext' ;
final String columnFromText = 'fromtext';

class CurrencyHelper {
  static Database _database;
  static CurrencyHelper _alarmHelper;

  CurrencyHelper._createInstance();
  factory CurrencyHelper() {
    if (_alarmHelper == null) {
      _alarmHelper = CurrencyHelper._createInstance();
    }
    return _alarmHelper;
  }

  Future<Database> get database async {
    if(_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    var dir = await getDatabasesPath();
    var path = dir + 'convertcoin.db';

    var database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE $tableName (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnToCurrency TEXT NOT NULL,
            $columnFromCurrency TEXT NOT NULL,
            $columnToText  TEXT NOT NULL,
            $columnFromText TEXT NOT NULL
          )
        ''');
      },
    );
    return database;
  }

  void insertCurrency(CurrencyInfo currencyInfo) async {
    var db = await this.database;
    var result = await db.insert(tableName, currencyInfo.toMap());
    print('result $result');
  }

  Future<List<CurrencyInfo>> getCurrency() async {
    List<CurrencyInfo> _alarms = [];

    var db = await this.database;
    var result = await db.query(tableName, orderBy: '$columnId DESC');
    result.forEach((element) {
      var alarmInfo = CurrencyInfo.fromMap(element);
      _alarms.add(alarmInfo);
    });

    return _alarms;
  }

  Future<int> delete(int id) async {
    var db = await this.database;
    return await db.delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  }


}