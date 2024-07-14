import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
  });

  final String hintText;
  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(borderRadius: BorderRadius.zero)),
    );
  }
}
