
import 'dart:math';

import 'package:flutter/material.dart';

import 'animation_minix.dart';

class CustomFinishBox extends LeafRenderObjectWidget {
  const CustomFinishBox({
    Key? key,
    this.strokeWidth = 2.0,
    this.value = false,
    this.strokeColor = Colors.white,
    this.fillColor = Colors.blue,
    this.radius = 2.0,
  }) : super(key: key);

  final double strokeWidth; // “勾”的线条宽度
  final Color strokeColor; // “勾”的线条宽度
  final Color? fillColor; // 填充颜色
  final bool value; //选中状态
  final double radius; // 圆角

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderCustomFinishBox(this.strokeWidth, this.strokeColor,
        this.fillColor!, this.value, this.radius);
  }

  @override
  void updateRenderObject(
      BuildContext context, RenderCustomFinishBox renderObject) {
    if (renderObject.value != value) {
      renderObject.animationStatus = AnimationStatus.forward;
      renderObject.progress = 0;
    }
    renderObject
      ..strokeWidth = strokeWidth
      ..strokeColor = strokeColor
      ..fillColor = fillColor ?? Theme.of(context).primaryColor
      ..radius = radius
      ..value = value;
  }
}

class RenderCustomFinishBox extends RenderBox with RenderObjectAnimationMixin {
  bool value; // 选中状态
  int pointerId = -1; //
  double strokeWidth; //宽度
  Color strokeColor;
  Color fillColor;
  double radius;

  RenderCustomFinishBox(this.strokeWidth, this.strokeColor, this.fillColor,
      this.value, this.radius) {
    progress = 0;
  }

  double bgAnimationInterval = .4;

  @override
  void doPaint(PaintingContext context, Offset offset) {
    print('doPaint：$progress');
    Rect rect = offset & size;
    _drawBackground(context, offset);
    if (progress > bgAnimationInterval) {
      _drawCheckMark(context, rect);
    }
  }

  /// 绘制背景
  /// [PaintingContext] 上下文
  void _drawBackground(PaintingContext context, Offset offset) {
    Color color = value ? fillColor : Colors.red;
    // 设置画笔
    var paint = Paint()
      ..isAntiAlias = true //抗锯齿
      ..style = PaintingStyle.fill //填充
      ..strokeWidth
      ..color = color;

    // 画背景
    // 绘制嵌套圆形drawCircle
    context.canvas.drawCircle(
        offset + Offset(size.height/2, size.width/2),
        size.width * 2/3 * (min(progress, bgAnimationInterval) / bgAnimationInterval),
        paint);
  }

  //画 "勾" 或 叉
  void _drawCheckMark(PaintingContext context, Rect rect) {
    if(!value){
      // 确定左上起点位置
      final topLeftOffset = Offset(
        rect.left + rect.width / 4,
        rect.top + rect.height / 4,
      );
      // 确定左下起点位置
      final bottomLeftOffset = Offset(
        rect.left + rect.width / 4,
        rect.bottom - rect.height / 4,
      );
      // 确定右上结束点位置
      final topRightOffset = Offset(
        rect.right - rect.width / 4,
        rect.top + rect.height / 4,
      );
      // 确定右下结束点位置
      final bottomRightOffset = Offset(
        rect.right - rect.width / 4,
        rect.bottom - rect.height / 4,
      );

      // 我们对对角线的位置做插值
      final _firstOffset = Offset.lerp(
        topLeftOffset,
        bottomRightOffset,
        (progress - bgAnimationInterval) / (1 - bgAnimationInterval),
      )!;

      // 我们对对角线的位置做插值
      final _secondOffset = Offset.lerp(
        bottomLeftOffset,
        topRightOffset,
        (progress - bgAnimationInterval) / (1 - bgAnimationInterval),
      )!;

      final path = Path()
        ..moveTo(topLeftOffset.dx,topLeftOffset.dy)
        ..lineTo(_firstOffset.dx, _firstOffset.dy)..moveTo(bottomLeftOffset.dx,bottomLeftOffset.dy)..lineTo(
            _secondOffset.dx, _secondOffset.dy);

      final paint = Paint()
        ..isAntiAlias = true
        ..style = PaintingStyle.stroke
        ..color = strokeColor
        ..strokeWidth = strokeWidth;

      context.canvas.drawPath(path, paint..style = PaintingStyle.stroke);
    } else {
      //确定中间拐点位置
      final secondOffset = Offset(
        rect.left + rect.width / 2.5,
        rect.bottom - rect.height / 4,
      );
      // 第三个点的位置
      final lastOffset = Offset(
        rect.right - rect.width / 6,
        rect.top + rect.height / 4,
      );

      // 我们只对第三个点的位置做插值
      final _lastOffset = Offset.lerp(
        secondOffset,
        lastOffset,
        (progress - bgAnimationInterval) / (1 - bgAnimationInterval),
      )!;

      // 将三个点连起来
      final path = Path()
        ..moveTo(rect.left + rect.width / 7, rect.top + rect.height / 2)
        ..lineTo(secondOffset.dx, secondOffset.dy)..lineTo(
            _lastOffset.dx, _lastOffset.dy);

      final paint = Paint()
        ..isAntiAlias = true
        ..style = PaintingStyle.stroke
        ..color = strokeColor
        ..strokeWidth = strokeWidth;

      context.canvas.drawPath(path, paint..style = PaintingStyle.stroke);
    }
  }

  @override
  void performLayout() {
    // 如果父组件指定了固定宽高，则使用父组件指定的，否则宽高默认置为 25
    size = constraints.constrain(
      constraints.isTight ? Size.infinite : const Size(25, 25),
    );
  }
}