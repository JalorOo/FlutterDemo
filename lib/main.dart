import "package:flutter/material.dart";
import 'package:learn/animation_widget/float_action_menu.dart';

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
        // body: CustomCheckboxTest(),
        floatingActionButton: FloatActionMenu(
          backgroundColor: Colors.orange,
          children: [
            SubFloatActionButton(
                callback: () {},
                backgroundColor: Colors.orange,
                content: Icon(
                  Icons.file_open,
                  color: Colors.white,
                )),
            SubFloatActionButton(
                callback: () {
                  print("hello");
                },
                backgroundColor: Colors.orange,
                content: Icon(
                  Icons.folder,
                  color: Colors.white,
                )),
          ],
        ),
      ),
      //去掉右上角的debug贴纸
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}
