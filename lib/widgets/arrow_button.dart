
import 'package:flutter/material.dart';

class ArrowButton extends StatelessWidget {
  const ArrowButton({
    super.key,
    required this.icon,
    required this.onTap,
  });
  final IconData icon;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.circular(20)),
        child: Center(
            child: Icon(
          icon,
          color: Colors.black,
        )),
      ),
    );
  }
}
