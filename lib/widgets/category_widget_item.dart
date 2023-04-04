import 'package:flutter/material.dart';

class CategoryWidgetItem extends StatelessWidget {
  final Icon icon;
  final VoidCallback action;
  const CategoryWidgetItem(
      {super.key, required this.icon, required this.action});

  @override
  Widget build(BuildContext context) {
    Color containerColor = const Color.fromRGBO(220, 220, 220, 1);
    return Container(
      height: 55,
      width: 60,
      decoration: BoxDecoration(
          color: containerColor, borderRadius: BorderRadius.circular(10.0)),
      child: IconButton(onPressed: action, icon: icon),
    );
  }
}
