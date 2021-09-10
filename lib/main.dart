import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:test_yt/pages/home_page.dart';
import 'package:test_yt/pages/video_info.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: VideoInfo(),
    );
  }
}
