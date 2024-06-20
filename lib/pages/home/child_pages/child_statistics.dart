import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:record/pages/home/modules/chart.dart';
import 'package:record/sql/model/income_expenditure_model.dart';

class ChildStatistics extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final list = UseType.values;

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
                  '2024年',
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
              child: Chart(),
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
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                child: AspectRatio(
                  aspectRatio: 1.75,
                  child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      final item = list[index];
                      return ListTile(
                        title: Text(item.name),
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
}
