import 'package:flutter/material.dart';

class TriadTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Tr",
          style: Theme.of(context).textTheme.headline1,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Container(
            width: Theme.of(context).textTheme.headline1!.fontSize! * 0.8,
            height: Theme.of(context).textTheme.headline1!.fontSize! * 0.8,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).primaryColor,
                  blurRadius: 10.0,
                  spreadRadius: 0,
                  offset: Offset(
                    0.0,
                    0.0,
                  ),
                )
              ]
            ),
            alignment: Alignment.center,
            child: VerticalDivider(
              color: Colors.white, thickness: 3, indent: 8, endIndent: 8, width: 8,
            )
          ),
        ),
        Text(
          "ad Web",
          style: Theme.of(context).textTheme.headline1,
        ),
      ],
    );
  }
}