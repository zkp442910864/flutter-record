import 'package:intl/intl.dart';
import 'package:record/sql/base.dart';
import 'package:record/sql/model/income_expenditure_model.dart';
import 'package:sqflite/sqflite.dart';

class IncomeExpenditureLogic {
  static Future<int> insertDb(IncomeExpenditureModel data) async {
    final db = await BaseApi.getDatabase();
    return await db.insert(
      IncomeExpenditureModel.tableName,
      data.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// 查询当月数据
  static Future<List<IncomeExpenditureModel>> queryMonthData() async {
    final db = await BaseApi.getDatabase();
    final now = DateTime.now();
    // currentDate.get
    final List<Map<String, dynamic>> list = (await db.query(
      IncomeExpenditureModel.tableName,
      where: 'date >= ? AND date <= ?',
      whereArgs: [
        DateTime(now.year, now.month, 1).toString(),
        DateTime(now.year, now.month + 1, 0, 23, 59, 59).toString()
      ],
      orderBy: 'date DESC, id DESC',
    ));
    // print(maps);

    return IncomeExpenditureModel.listConvert(list);
  }

  /// 查询当月总收支，以及当天支出
  static Future<HomeDataModel> queryHomeData() async {
    final list = await queryMonthData();
    final format = DateFormat('yyyy-MM-dd');
    final currentDay = format.format(DateTime.now());
    List<UniteType> homeList = [];

    // 每天的合计
    Map<String, HomeListDataModel> dayMap = {};

    // 当月总收入
    var inTotal = list
        .where((ii) => ii.type == 'in')
        .map((ii) => ii.value ?? 0)
        .reduce((a, b) => a + b);
    // 当月总支出
    var outTotal = list
        .where((ii) => ii.type == 'out')
        .map((ii) => ii.value ?? 0)
        .fold(0.0, (a, b) => a + b);
    // 当天总支出
    var outTotalCurrentDay = list
        .where(
            (ii) => ii.type == 'out' && format.format(ii.date!) == currentDay)
        .map((ii) => ii.value ?? 0)
        .fold(0.0, (a, b) => a + b);

    for (var item in list) {
      final dateStr = format.format(item.date!);

      if (dayMap[dateStr] == null) {
        dayMap[dateStr] = HomeListDataModel(date: item.date!, inValue: 0, outValue: 0);
        homeList.add(dayMap[dateStr]!);
      }

      if (item.type == 'in') {
        dayMap[dateStr]!.inValue += item.value ?? 0;
      } else {
        dayMap[dateStr]!.outValue += item.value ?? 0;
      }

      homeList.add(item);
    }

    return HomeDataModel(
      inTotal: inTotal,
      outTotal: outTotal,
      outTotalCurrentDay: outTotalCurrentDay,
      list: homeList,
    );
  }
}
