// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class SquareButton extends StatelessWidget {
  const SquareButton({
    Key? key,
    required this.title,
    required this.loading,
    this.onTap,
  }) : super(key: key);
  final String title;
  final bool loading;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: loading ? null : onTap,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.deepPurple,
        ),
        child: Center(
            child: loading
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const CircularProgressIndicator(color: Colors.white,),
                  )
                : Text(
                    title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  )),
      ),
    );
  }
}
