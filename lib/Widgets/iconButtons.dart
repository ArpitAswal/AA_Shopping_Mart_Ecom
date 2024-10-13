import 'package:flutter/material.dart';

class Buttons extends StatelessWidget {
  const Buttons({super.key, required this.function, required this.icon, this.bgColor = Colors.white, this.iconColor = Colors.deepPurple});
  final Function function;
  final IconData icon;
  final Color bgColor;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
          onTap: () {
            function();
          },
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: bgColor,
            ),
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Icon(icon, color: iconColor),
            ),
          )),
    );
  }
}
