class StatisticsDataModal {
  List<StatisticsBaseDataModal> month;
  List<StatisticsBaseDataModal> category;

  StatisticsDataModal({
    required this.month,
    required this.category,
  });
}

class StatisticsBaseDataModal {
  double inTotal;
  double outTotal;

  /// month,category
  String type;

  /// 存储未知数据
  dynamic value;

  StatisticsBaseDataModal({
    this.inTotal = 0,
    this.outTotal = 0,
    required this.type,
    required this.value,
  });
}
