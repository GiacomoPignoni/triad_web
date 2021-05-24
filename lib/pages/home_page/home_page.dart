import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:triad_web/pages/home_page/triad_title.dart';
import 'package:triad_web/widgets/button.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TriadTitle(),
                Divider(),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Button(
                    onPressed: () => Navigator.pushNamed(context, "two-player"),
                    text: "Two Player",
                  ),
                ),
                Divider(),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Button(
                    onPressed: () => print("WE"),
                    text: "Settings",
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}