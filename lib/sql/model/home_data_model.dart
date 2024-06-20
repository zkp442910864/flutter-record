part of 'income_expenditure_model.dart';

class HomeDataModel {
  num inTotal;
  num outTotal;
  num outTotalCurrentDay;
  List<UniteType> list;

  HomeDataModel({
    required this.inTotal,
    required this.outTotal,
    required this.outTotalCurrentDay,
    required this.list,
  });
}

class HomeListDataModel extends UniteType {
  /// 时间
  DateTime date;

  /// 收入
  num inValue;

  /// 支出
  num outValue;

  HomeListDataModel({
    required this.date,
    required this.inValue,
    required this.outValue,
  });
}
