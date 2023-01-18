import 'package:flutter/material.dart';

class FloatingActionMenu extends StatefulWidget {
  const FloatingActionMenu({Key? key}) : super(key: key);

  @override
  State<FloatingActionMenu> createState() => _FloatingActionMenuState();
}

class _FloatingActionMenuState extends State<FloatingActionMenu> {
  @override
  Widget build(BuildContext context) {
    return mainButton();
  }

  Widget mainButton() {
    return Positioned(
      bottom: 0,
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.all(Radius.circular(56)),
        ),
        child: Center(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
