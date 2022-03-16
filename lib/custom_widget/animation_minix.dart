import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

mixin RenderObjectAnimationMixin on RenderObject {
  // 下面的属性用于调度动画
  double _progress = 0; // 动画当前进度
  int? _lastTimeStamp; // 上一次绘制的时间

  // 动画时长，子类可以重写
  Duration get duration => const Duration(milliseconds: 10000);
  // 默认状态为完成状态
  AnimationStatus _animationStatus = AnimationStatus.completed;
  // 设置动画状态
  set animationStatus(AnimationStatus v) {
    if (_animationStatus != v) {
      markNeedsPaint(); //标记为下一帧需要重绘
    }
    _animationStatus = v;
  }

  double get progress => _progress;
  set progress(double v) {
    _progress = v.clamp(0, 1);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    doPaint(context, offset); // 调用子类绘制逻辑
    _scheduleAnimation();
  }

  /// 控制动画的时间
  /// 移除后，也有变化，但doPaint()只做一次
  /// 因为该方法中有[ markNeedsPaint() ] 可以重新绘制UI
  void _scheduleAnimation() {
    if (_animationStatus != AnimationStatus.completed) {
      SchedulerBinding.instance!.addPostFrameCallback((Duration timeStamp) {
        // 安排进度
        if (_lastTimeStamp != null) {
          double delta = (timeStamp.inMilliseconds - _lastTimeStamp!) /
              duration.inMilliseconds;

          //在特定情况下，可能在一帧中连续的往frameCallback中添加了多次，导致两次回调时间间隔为0，
          //这种情况下应该继续请求重绘。
          if (delta == 0) {
            markNeedsPaint();
            return;
          }

          if (_animationStatus == AnimationStatus.reverse) {
            delta = -delta;
          }

          _progress = _progress + delta;
          // 当 _progress 已经超过1 或小于0 则完成动画
          // 并重置 _progress;
          if (_progress >= 1 || _progress <= 0) {
            _animationStatus = AnimationStatus.completed;
            _progress = _progress.clamp(0, 1);
          }
        }

        markNeedsPaint();
        _lastTimeStamp = timeStamp.inMilliseconds;
      });
    } else {
      _lastTimeStamp = null;
    }
  }

  // 子类实现绘制逻辑的地方
  void doPaint(PaintingContext context, Offset offset);
}