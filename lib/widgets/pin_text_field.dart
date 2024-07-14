import 'package:flutter/material.dart';

import 'package:pin_code_fields/pin_code_fields.dart';

class PinTextField extends StatefulWidget {
  const PinTextField({
    super.key,
    this.controller,
    this.validator,
  });
  final TextEditingController? controller;
  final String? Function(String? value)? validator;
  @override
  State<PinTextField> createState() => _PinTextFieldState();
}

class _PinTextFieldState extends State<PinTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      child: PinCodeTextField(
        controller: widget.controller,
        appContext: context,
        length: 6,
        validator: widget.validator,
        animationType: AnimationType.fade,
        cursorColor: Colors.white,
        pinTheme: PinTheme(
          inactiveColor: Colors.white,
          inactiveFillColor: Colors.white,
          selectedFillColor: Colors.white,
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(5),
          activeColor: Colors.white,
          selectedColor: Colors.white,
          disabledColor: Colors.white,
          activeFillColor: Colors.white,
          errorBorderColor: Colors.white,
        ),
        animationDuration: const Duration(milliseconds: 300),
        enableActiveFill: true,
        onCompleted: (v) {},
        onChanged: (value) {},
        beforeTextPaste: (text) {
          return true;
        },
      ),
    );
  }
}
