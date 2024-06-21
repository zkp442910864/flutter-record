import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:record/pages/home/modules/chart.dart';
import 'package:record/sql/logic/income_expenditure_logic.dart';
import 'package:record/sql/model/income_expenditure_model.dart';
import 'package:record/sql/model/statistics_data_modal.dart';

class ChildStatistics extends StatefulWidget {
  @override
  State<ChildStatistics> createState() => _ChildStatisticsState();
}

class _ChildStatisticsState extends State<ChildStatistics> {
  var currentSelectYear = int.parse(DateFormat('yyyy').format(DateTime.now()));
  StatisticsDataModal chartList = StatisticsDataModal(category: [], month: []);

  @override
  void initState() {
    super.initState();

    _getData(currentSelectYear);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DefaultTextStyle(
      // textAlign: TextAlign.left,
      style: theme.textTheme.labelSmall!,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: theme.colorScheme.primary,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  '$currentSelectYear年',
                  style: theme.textTheme.labelLarge!.copyWith(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(top: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              child: Chart(list: chartList.month),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text(
                  '分类明细',
                  style: theme.textTheme.labelSmall!.copyWith(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: Container(
                // padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                child: AspectRatio(
                  aspectRatio: 1.75,
                  child: ListView.builder(
                    itemCount: chartList.category.length,
                    itemBuilder: (context, index) {
                      final item = chartList.category[index];

                      return Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              (item.value as UseType).name,
                              style: theme.textTheme.labelSmall!.copyWith(
                                color: Colors.black87,
                              ),
                            ),
                            Column(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      item.outTotal.toStringAsFixed(2),
                                      style: TextStyle(
                                        color: Color(0xFF2a9d8f),
                                      ),
                                    ),
                                    Text(
                                      ' 支出',
                                      style: TextStyle(
                                        color: Colors.blueGrey,
                                        fontSize: theme.textTheme.labelMedium!
                                                .fontSize! -
                                            14,
                                      ),
                                    ),
                                    Text(
                                      '',
                                      style: theme.textTheme.labelMedium,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      item.inTotal.toStringAsFixed(2),
                                      style: TextStyle(
                                        color: Color(0xFFE80054),
                                      ),
                                    ),
                                    Text(
                                      ' 收入',
                                      style: TextStyle(
                                        color: Colors.blueGrey,
                                        fontSize: theme.textTheme.labelMedium!
                                                .fontSize! -
                                            14,
                                      ),
                                    ),
                                    Text(
                                      '',
                                      style: theme.textTheme.labelMedium,
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void _getData(int year) async {
    final data = await IncomeExpenditureLogic.queryYearData(year);
    setState(() {
      chartList = data;
    });
  }
}
