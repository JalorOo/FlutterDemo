import 'package:flutter/material.dart';

import 'drag.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Color dragColor = Colors.orange;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          // 拖动组件
          DragWidget(
            offset: Offset(80, 80),
            widgetColor: Colors.yellow,
          ),
          DragWidget(
            offset: Offset(180, 80),
            widgetColor: Colors.pink,
          ),
          Center(
            // 拖拽接收组件
            child: DragTarget(
              //当组件拖动到该组件触发的回调,参数为拖动组件的data数据内容
              onAccept: (Color color) {
                this.dragColor = color;
              },
              //重写方法,表示待接收的组件
              builder: (context, candidateData, rejectedData) {
                return Container(
                  width: 200,
                  height: 200,
                  color: this.dragColor,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
