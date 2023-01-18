import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double x = 0;
  double y = 0;
  double z = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Transform(
          /// 每个矩阵值的意思
          /// 且注意，Flutter 中 Matrix是列为主的,即(2,3)是 值 [translateZ]
          /// [scaleX,sin(x){z},-sin(x){y},perspectiveX]
          /// [-sin(x){z},scaleY,sin(x){x},perspectiveY]
          /// [sin(x){y},-sin(x){x},scaleZ,perspectiveZ]
          /// [translateX,translateY,translateZ,1/scaleAll]
          ///
          transform: Matrix4(
            1, 0, 0, 0,
            0, 1, 0, 0,
            0, 0, 1, 0,
            0, 0, 0, 1,
          )
            ..rotateX(x)
            ..rotateY(y)
            ..rotateZ(z),
          alignment: FractionalOffset.center,
          child: GestureDetector(
            onPanUpdate: (details) {
              setState(() {
                y = y - details.delta.dx / 100;
                x = x + details.delta.dy / 100;
              });
            },
            child: Container(
              color: Colors.red,
              height: 200.0,
              width: 200.0,
            ),
          ),
        ),
      ),
    );
  }
}
