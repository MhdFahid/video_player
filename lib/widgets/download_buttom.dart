
import 'package:flutter/material.dart';

class DownloadButton extends StatelessWidget {
  const DownloadButton({
    super.key,
    required this.onTap,
  });

  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 254, 254),
            borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
          child: Row(
            children: [
              Container(
                height: 10,
                width: 30,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('icons/arrow_down.png'))),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Download',
                style: TextStyle(
                    color: theme.brightness == Brightness.light
                        ? Color.fromARGB(255, 0, 0, 0)
                        : Color.fromARGB(255, 0, 0, 0)),
              ),
              SizedBox(
                width: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
