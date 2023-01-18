import 'package:flutter/material.dart';

class FloatingActionMenu extends StatefulWidget {
  final Color backgroundColor;
  final String heroTag;
  final List<SubFloatActionButton> children;

  FloatingActionMenu(
      {Key? key,
      required this.backgroundColor,
      required this.children,
      this.heroTag = 'JayFloatActionButton'})
      : super(key: key);

  @override
  State<FloatingActionMenu> createState() => _FloatingActionMenuState();
}

class _FloatingActionMenuState extends State<FloatingActionMenu>
    with TickerProviderStateMixin {
  late AnimationController _animationController; // 控制动画的类
  late Animation<double> _animation;
  List<Widget> _buttons = [];

  @override
  void initState() {
    // if(widget.children!=null) {
    // }
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController);

    // for (int i = 0; i < widget.children.length; i++) {
    //   _buttons.add(subButton(widget.children[i], i));
    // }
    // _buttons.add(mainButton());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _buttons.clear();
    for (int i = 0; i < widget.children.length; i++) {
      _buttons.add(subButton(widget.children[i], i));
    }
    _buttons.add(mainButton());
    return Container(
      height: 200,
      width: 56,
      // color: Colors.grey,
      child: Stack(children: _buttons),
    );
  }

  double _left = 0.0;

  Widget subButton(SubFloatActionButton subFloatActionButton, int i) {
    return AnimatedPositioned(
      bottom: (56 + (10.0 * (i + 1)) + 42 * i) * _left,
      left: (56 - 42) / 2,
      duration: Duration(milliseconds: 300),
      child: FadeTransition(
        opacity: _animation,
        child: subFloatActionButton,
      ),
    );
  }

  Widget mainButton() {
    return Positioned(
      bottom: 0,
      child: Hero(
        tag: widget.heroTag,
        child: GestureDetector(
            onTap: () {
              if (_animationController.isCompleted) {
                _closeMenu();
                setState(() {
                  _left = 0.0;
                });
              } else {
                _openMenu();
                setState(() {
                  _left = 1.0;
                });
              }
              print("点击 $_left");
            },
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                  color: widget.backgroundColor,
                  borderRadius: BorderRadius.all(Radius.circular(56)),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 10.0,
                        offset: Offset(0, 10),
                        color: widget.backgroundColor.withAlpha(100))
                  ]),
              child: Center(
                child: AnimatedIcon(
                  color: Colors.white,
                  icon: AnimatedIcons.menu_close,
                  progress: _animation,
                ),
              ),
            )),
      ),
    );
  }

  _openMenu() {
    _animationController.forward();
  }

  _closeMenu() {
    _animationController.reverse();
  }
}

class SubFloatActionButton extends StatelessWidget {
  final VoidCallback callback;
  final Color backgroundColor;
  final content;

  const SubFloatActionButton(
      {Key? key,
      required this.callback,
      required this.backgroundColor,
      required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: callback,
        child: Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.all(Radius.circular(56)),
              boxShadow: [
                BoxShadow(
                    blurRadius: 10.0,
                    offset: Offset(0, 10),
                    color: backgroundColor.withAlpha(100))
              ]),
          child: content,
        ));
  }
}
