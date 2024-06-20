class Wallet {
  /// 时间
  DateTime? date;
  /// 金额
  double? value;
  /// 备注
  String? remark;
  int? id;

  Wallet({
    this.date,
    this.value,
    this.remark,
    this.id,
  });

  static String getCreateSql() {
    return '''
      CREATE TABLE IF NOT EXISTS wallet (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        date TEXT,
        value REAL,
        remark TEXT
      );
    ''';
  }
}
