import "package:flutter/material.dart";

class DragWidget extends StatefulWidget {
//构造器传入坐标和参数
  DragWidget({Key? key, required this.offset, required this.widgetColor}) : super(key: key);
  final Offset offset;
  final Color widgetColor;

  @override
  _DragWidgetState createState() => _DragWidgetState();
}

class _DragWidgetState extends State<DragWidget> {
  Offset offset = Offset(0.0, 0.0);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //获取继承的状态类的数据
    offset = widget.offset;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // Positioned实现组件位置为鼠标停止位置
      child: Positioned(
        left: offset.dx,
        top: offset.dy,
        child: Draggable(
          // 拖拽传递的数据
          data: widget.widgetColor,
          // 拖动过程中的组件
          feedback: Container(
            width: 100,
            height: 100,
            color: Colors.red,
          ),
          //待拖动组件
          child: Container(
            width: 100,
            height: 100,
            color: widget.widgetColor,
          ),
          //拖动过程回调
          onDraggableCanceled: (Velocity velocity, Offset offset) {
            setState(() {
              //第二个参数为拖动的动态坐标
              this.offset = offset;
            });
          },
        ),
      ),
    );
  }
}
