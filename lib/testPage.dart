import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
          onPressed: () {
            // Navigator.pop(context);
            setState(() {
              count++;
            });
          },
          // child: const Text('后退')
          child: Text('计数 $count')),
    );
  }
}
