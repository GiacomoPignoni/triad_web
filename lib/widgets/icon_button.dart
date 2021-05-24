import 'package:flutter/material.dart';

class MyIconButton extends StatelessWidget {
  final Function() onPressed;
  final Icon icon;

  MyIconButton({
    required this.onPressed,
    required this.icon
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: icon,
    );
  }
}