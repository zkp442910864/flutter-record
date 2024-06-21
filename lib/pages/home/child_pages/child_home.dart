import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:record/sql/logic/income_expenditure_logic.dart';
import 'package:record/sql/model/income_expenditure_model.dart';

class ChildHome extends StatefulWidget {
  @override
  State<ChildHome> createState() => _ChildHomeState();
}

class _ChildHomeState extends State<ChildHome> {
  /// 当前月份
  var currentMonth = '${int.parse(DateFormat('MM').format(DateTime.now()))}月';

  /// 当前月份支出
  num currentMonthOut = 0.00;

  /// 当前月份收入
  num currentMonthIn = 0.00;

  /// 当天月份支出
  num currentDayOut = 0.00;

  List<UniteType> items = [];

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    double aspectRatio = MediaQuery.of(context).size.aspectRatio;

    print(deviceWidth);
    print(deviceHeight);
    print(MediaQuery.of(context).size.aspectRatio);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // 获取数据
    });

    return Scaffold(
      body: CustomScrollView(
        // style
        slivers: [
          SliverAppBar(
            pinned: true,
            snap: true,
            floating: true,
            expandedHeight: aspectRatio * 370,
            // expandedHeight: 170,
            backgroundColor: theme.colorScheme.primary,
            shadowColor: theme.colorScheme.primary,
            forceElevated: true,
            flexibleSpace: FlexibleSpaceBar(
              title: _topCurrentDayWidget(theme),
              titlePadding: const EdgeInsets.only(bottom: 6, left: 16),
              background: _topWidget(theme),
            ),
            actions: [
              // Text('更多')
            ],
          ),
          if (items.isNotEmpty)
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  final item = items[index];

                  if (item is HomeListDataModel) {
                    return Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.inversePrimary,
                        // padding: const EdgeInsets.all(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            DateFormat('yyyy-MM-dd').format(item.date),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '收:${item.inValue.toStringAsFixed(2)},支:${item.outValue.toStringAsFixed(2)}',
                            style: TextStyle(
                                color: Color.fromARGB(255, 71, 71, 71)),
                          ),
                        ],
                      ),
                    );
                  } else if (item is IncomeExpenditureModel) {
                    return Padding(
                      padding: const EdgeInsets.all(12),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            // border: Border.all(
                            //   color: theme.colorScheme.primary,
                            //   width: 1,
                            // ),
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                color: theme.colorScheme.inversePrimary,
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset:
                                    Offset(0, 0), // changes position of shadow
                              ),
                            ]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              item.useType!.name,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Column(
                              children: [
                                Text(
                                  '${item.type == 'in' ? '+' : '-'}${item.value}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: theme.colorScheme.primary),
                                ),
                                Text(
                                  DateFormat('HH:mm').format(item.date!),
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 71, 71, 71)),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  }

                  return ListTile(
                    title: Text('error'),
                  );
                },
                childCount: items.length,
              ),
            ),
          if (items.isEmpty)
            SliverFillRemaining(
              hasScrollBody: false,
              child: SizedBox(
                height: 300,
                child: Column(
                  children: [
                    Image.asset('assets/no_data_amico.png', width: 300),
                    Html(
                        data:
                            '<div style="text-align:right;"><a href="https://storyset.com/data">Data illustrations by Storyset</a></div>',
                        onLinkTap: (url, data, el) {
                          // launchUrlString(url!);
                        })
                  ],
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final index =
              await IncomeExpenditureLogic.insertDb(IncomeExpenditureModel(
            type: 'out',
            useType: UseType.shop,
            date: DateTime.now(),
            // date: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day - 1),
            remark: 'test',
            value: 11.23,
          ));

          _getData();
          // BaseApi.closeDb();
          // print(index);
          // final data = await IncomeExpenditureLogic.queryHomeData();
          // print(data);
        },
        shape: CircleBorder(),
        backgroundColor: theme.colorScheme.primary,
        child: Icon(Icons.add, color: theme.colorScheme.primaryFixed),
      ),
    );
  }

  void _getData() async {
    final data = await IncomeExpenditureLogic.queryHomeData();
    // print(data);
    setState(() {
      currentMonthOut = data.outTotal;
      currentMonthIn = data.inTotal;
      currentDayOut = data.outTotalCurrentDay;
      items = data.list;
    });
  }

  Widget _topCurrentDayWidget(ThemeData theme) {
    return Row(
      // style: theme.textTheme.labelSmall,
      // verticalDirection: VerticalDirection.up,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '今日支出:',
          style: theme.textTheme.labelSmall!.copyWith(
            color: Colors.white,
            height: 1.5,
          ),
        ),
        SizedBox(width: 10),
        Text(
          currentDayOut.toStringAsFixed(2),
          style: theme.textTheme.labelLarge!.copyWith(
            color: Colors.white,
            height: 1,
          ),
        )
      ],
    );
  }

  Widget _topWidget(ThemeData theme) {
    return DefaultTextStyle(
      style: theme.textTheme.labelMedium!.copyWith(
        color: Colors.white,
      ),
      child: Container(
          // height: 300,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            // border: Border( bottom: BorderSide(width: 1)),
            color: theme.colorScheme.primary,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16)),
            shape: BoxShape.rectangle,
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(55, 0, 0, 0),
                offset: Offset(0, 16),
                blurRadius: 24,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$currentMonth合计',
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '支出',
                          style: theme.textTheme.labelSmall!
                              .copyWith(color: Colors.white),
                        ),
                        Text(
                          currentMonthOut.toStringAsFixed(2),
                          style: theme.textTheme.labelLarge!
                              .copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '收入',
                          style: theme.textTheme.labelSmall!
                              .copyWith(color: Colors.white),
                        ),
                        Text(
                          currentMonthIn.toStringAsFixed(2),
                          style: theme.textTheme.labelLarge!
                              .copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Divider(),
              // _topCurrentDayWidget(theme),
            ],
          )),
    );
  }
}

class Custom {
  int? type;

  Custom({this.type});
}
