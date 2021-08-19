import 'package:flutter/material.dart';
// import 'package:test_yt/pages/animation_test.dart';
import 'package:test_yt/pages/music/list_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ListPage(),
      // home: AnimationTest(),
    );
  }
}
