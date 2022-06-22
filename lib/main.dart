import "package:flutter/material.dart";
import 'package:learn/custom_widget/home_view.dart';
import 'package:learn/matrix4/matrix4_page.dart';

import 'custom_paint/painter.dart';
import 'fold_cell/folding_cell_list_page.dart';

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
        body: MyHomePage(),
      ),

      //去掉右上角的debug贴纸
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}
