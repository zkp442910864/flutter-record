import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:record/pages/home/index.dart';
import 'package:record/sql/base.dart';
import 'package:record/store/index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await BaseApi.openDb();
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   statusBarColor: Color(int.parse('2a9d8f', radix: 16)), // 状态栏背景色
  //   statusBarIconBrightness: Brightness.light, // 状态栏图标颜色
  // ));

  runApp(MyApp());

}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

}

class _MyAppState extends State<MyApp> {

  @override
  void dispose() {
    // TODO: implement dispose
    BaseApi.closeDb();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => MyAppState(),
        child: MaterialApp(
          title: '记录',
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(seedColor: Color(int.parse('2a9d8f', radix: 16))),
            // labelLarge: 20,
            textTheme: TextTheme(
              labelLarge: TextStyle(fontSize: 32),
              labelMedium: TextStyle(fontSize: 24),
              labelSmall: TextStyle(fontSize: 16),
            ),
            // radioTheme: RadioThemeData(
            //   double: Radius.circular(16),
            // )
          ),
          home: Home(),
        ));
  }
}
