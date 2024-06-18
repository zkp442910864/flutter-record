import 'package:flutter/material.dart';
import 'package:record/pages/home/modules/child_home.dart';
import 'package:record/pages/home/modules/child_my.dart';

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
    return SafeArea(
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
            Placeholder(child: Text('2')),
            My(),
          ],
          onPageChanged: (index) {
            _goToTabPage('top', index);
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: tabIndex,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.directions_car), label: '首页'),
            BottomNavigationBarItem(
                icon: Icon(Icons.directions_transit), label: '统计'),
            BottomNavigationBarItem(
                icon: Icon(Icons.directions_bike), label: '我的'),
          ],
          onTap: (index) async {
            _goToTabPage('bottom', index);
      
            // var data = await fetchAlbum();
            // print(data.id);
          },
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
