import 'package:flutter/material.dart';

class KeyValueText extends StatelessWidget {
  final String keyText;
  final String valueText;
  const KeyValueText(
      {super.key, required this.keyText, required this.valueText});

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(children: [
      TextSpan(
          text: keyText,
          style: TextStyle(
              fontWeight: FontWeight.w600, color: Colors.black, fontSize: 18)),
      TextSpan(
          text: valueText, style: TextStyle(color: Colors.black, fontSize: 18))
    ]));
  }
}
