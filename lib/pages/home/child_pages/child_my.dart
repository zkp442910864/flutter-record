import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:record/model/sql_model/dog.dart';
import 'package:record/pages/home/modules/wave_view.dart';
import 'package:sqflite/sqflite.dart';

class ChildMy extends StatefulWidget {
  @override
  State<ChildMy> createState() => _ChildMyState();
}

class _ChildMyState extends State<ChildMy> {
  late Future<Database> database;
  var dataStr = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
      ),
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            snap: true,
            floating: true,
            expandedHeight: 200.0,
            backgroundColor: theme.colorScheme.primary,
            shadowColor: theme.colorScheme.primary,
            forceElevated: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Padding(
                padding: const EdgeInsets.only(bottom: 32.0),
                child: Text(
                  '0.00',
                  style:
                      TextStyle(fontSize: 50, color: theme.colorScheme.scrim),
                ),
              ),
              titlePadding: const EdgeInsets.only(bottom: 6, left: 16),
              background: _topBg(theme),
              centerTitle: true,
            ),
            actions: [],
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              height: 300,
              padding: EdgeInsets.all(16),
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(30, 0, 0, 0),
                      offset: Offset(0, 0),
                      blurRadius: 24,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('data'),
                    );
                  },
                  itemCount: 10,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _topBg(ThemeData theme) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary,
        // borderRadius: BorderRadius.circular(100),
      ),
      // width: 100,
      // height: 200,
      child: WaveView(
          percentageValue: 50, color: theme.colorScheme.primaryContainer),
    );
  }
}
