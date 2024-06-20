import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:record/pages/home/child_pages/child_home.dart';
import 'package:record/pages/home/child_pages/child_my.dart';
import 'package:record/pages/home/child_pages/child_statistics.dart';

class Home extends StatefulWidget {
  static const home = 0;
  static const statistics = 1;
  static const my = 2;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var tabIndex = Home.home;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: theme.colorScheme.primary,
        statusBarIconBrightness: Brightness.light,
      ),
      child: SafeArea(
        child: Scaffold(
          // body: [
          //   _getLayout1(context),
          //   // _getLayout2(context),
          //   TestPage(),
          //   _getLayout3(context),
          // ][tabCurrentIndex],
          body: PageView(
            controller: _pageController,
            children: [
              ChildHome(),
              ChildStatistics(),
              ChildMy(),
            ],
            onPageChanged: (index) {
              _goToTabPage('top', index);
            },
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: tabIndex,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: '首页'),
              BottomNavigationBarItem(icon: Icon(Icons.analytics), label: '统计'),
              BottomNavigationBarItem(icon: Icon(Icons.settings), label: '我的'),
            ],
            onTap: (index) async {
              _goToTabPage('bottom', index);
            },
          ),
        ),
      ),
    );
  }

  void _goToTabPage(String type, int index) {
    if (type == 'bottom') {
      _pageController.animateToPage(
        index,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }

    if (type == 'bottom' || type == 'top') {
      setState(() {
        tabIndex = index;
      });
    }
  }
}
