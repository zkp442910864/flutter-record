import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:record/sql/model/income_expenditure_model.dart';
import 'package:record/model/sql_model/wallet.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class BaseApi {
  static late Future<Database> database;
  static late String filePath;

  /// 打开，并创建表
  static Future<void> openDb() async {

    filePath = join(await getDatabasesPath(), 'record_database.db');
    // print(filePath);

    // https://bbs.huaweicloud.com/blogs/415705

    // Directory appDocDir = await getApplicationDocumentsDirectory();
    // String appDocPath = appDocDir.path;
    // print('appDocPath: $appDocPath');

    // Directory supportDir = await getApplicationSupportDirectory();
    // String supportPath = supportDir.path;
    // print('supportPath: $supportPath');

    // final externalStorageDir = await getExternalStorageDirectory();
    // String externalStoragePath = externalStorageDir!.path;
    // print('externalStoragePath: $externalStoragePath');

    database = openDatabase(
      filePath,
      version: 1,
      readOnly: false,
      singleInstance: true,
      onCreate: (db, version) {
        return db.execute(
          IncomeExpenditureModel.getCreateSql() + Wallet.getCreateSql(),
        );
      },
    );
  }

  static void closeDb() async {
    (await database).close();
  }

  /// 获取db
  static Future<Database> getDatabase() async {
    return database;
  }
}
