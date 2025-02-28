import 'package:flutter/material.dart';

class ComplainCards extends StatelessWidget {
  const ComplainCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 100,
        width: 150,
        color: Colors.blue,
      ),
    );
  }
}