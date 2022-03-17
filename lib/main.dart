import "package:flutter/material.dart";
import 'package:learn/custom_widget/home_view.dart';

import 'custom_paint/painter.dart';
import 'dragDemo/Home.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('小案例'),
        ),
        body: GradientCircularProgressRoute(),
      ),

      //去掉右上角的debug贴纸
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}
