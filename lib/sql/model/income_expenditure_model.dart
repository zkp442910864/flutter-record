part 'home_data_model.dart';

abstract class UniteType {}

class IncomeExpenditureModel extends UniteType{
  /// in支出 out收入
  String? type;

  /// 时间
  DateTime? date;

  /// 金额
  double? value;

  /// 备注
  String? remark;

  /// 使用类型
  UseType? useType;
  int? id;

  IncomeExpenditureModel({
    this.type,
    this.date,
    this.value,
    this.remark,
    this.useType,
    this.id,
  });

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'type': type,
      'date': date?.toUtc().toString(),
      'value': value,
      'remark': remark,
      'use_type': useType?.value,
    };
  }

  static String tableName = 'income_expenditure';

  static IncomeExpenditureModel itemConvert(Map<String, dynamic> json) {
    final useType = (json['use_type'] as num?)?.toInt();
    final date = json['date'] as String;

    return IncomeExpenditureModel(
      id: (json['id'] as num?)?.toInt(),
      type: json['type'] as String?,
      date: DateTime.parse(date).toLocal(),
      value: (json['value'] as num?)?.toDouble(),
      remark: json['remark'] as String?,
      useType: useType != null ? UseType.values.firstWhere((element) => element.value == useType) : null,
    );
  }

  static List<IncomeExpenditureModel> listConvert(List<Map<String, dynamic>> data) {
    final List<IncomeExpenditureModel> list = [];
      for (var value in data) {
        list.add(IncomeExpenditureModel.itemConvert(value));
      }
      return list;
  }

  static String getCreateSql() {
    return '''
      CREATE TABLE IF NOT EXISTS $tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        type TEXT,
        date TEXT,
        value REAL,
        remark TEXT,
        use_type INTEGER
      );
    ''';
  }
}

enum UseType {
  shop(name: '购物', value: 1),
  household(name: '家用', value: 2),
  threeMeals(name: '三餐', value: 3),
  telephoneCharge(name: '话费', value: 5),
  lendOrBorrow(name: '借出/借入', value: 6);

  const UseType({required this.name, required this.value});
  final String name;
  final int value;
}

